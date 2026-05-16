#!/usr/bin/env zsh
# verdict-engine/scripts/lib/commit_push.sh
# 
# Phase 2: Stage / Commit / Push module
# 
# institutional 責任:
#   - Pre-commit verification (git status --short)
#   - Metadata 収集 (platform/owner/category)
#   - Stage + git diff --cached --stat review
#   - Commit message 自動生成 (template ベース)
#   - Commit + Push
# 
# Dependencies: lib/utils.sh
# 17 欠点対策: Layer 1.5 (commit message UX), 議題3 #3 (staged review)

# ============================================================================
# Pre-commit verification
# 対策: 議題3 #2 (git status --short)
# ============================================================================

verify_pre_commit() {
  log_section "Phase 2.1: Pre-commit verification"
  
  cd "$PLATFORMS_REPO" || return 1
  
  local untracked_evaluations
  untracked_evaluations=$(git status --short | grep '^?? evaluations/' || true)
  
  if [[ -z "$untracked_evaluations" ]]; then
    log_error "untracked な evaluations file が見つかりません"
    log_error "Phase 1 で配置された file が institutional に正常に存在するか確認してください"
    return 1
  fi
  
  log_info "Untracked evaluations:"
  echo "$untracked_evaluations" | sed 's/^/  /'
  echo ""
  
  # 他の予期しない変更がないか check
  local other_changes
  other_changes=$(git status --short | grep -v '^?? evaluations/' || true)
  
  if [[ -n "$other_changes" ]]; then
    log_warn "evaluations/ 以外の変更を検出:"
    echo "$other_changes" | sed 's/^/  /'
    echo ""
    
    if ! prompt_confirm "これらの変更は institutional に意図的ですか?" "n"; then
      log_warn "中断、手動対処後に再起動してください"
      return 1
    fi
  fi
  
  return 0
}

# ============================================================================
# Metadata collection
# institutional に簡潔な format: NNN Platform | Owner | Category
# ============================================================================

collect_metadata() {
  log_section "Phase 2.2: Metadata 収集"
  
  log_info "各評価の metadata を以下形式で提供してください:"
  log_info "  #NNN Platform Name | Owner Inc. | short category"
  echo ""
  log_info "例:"
  log_info "  #065 Weaviate | Weaviate B.V. | Vector Database"
  log_info "  #066 NeMo Guardrails | NVIDIA Corporation | AI Safety / LLM Guardrails"
  echo ""
  log_info "本 session で配置済の評価:"
  
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug rest <<< "$entry"
    log_info "  - #$nnn ($slug)"
  done
  echo ""
  
  # User input loop
  local metadata_file
  metadata_file=$(mktemp -t verdict_metadata.XXXXXX)
  
  log_info "全評価の metadata を 1 行ずつ入力してください"
  log_info "完了したら空行を入力 (Enter のみ) してください"
  log_info "Clipboard から複数行貼付も可:"
  echo ""
  
  if prompt_confirm "Clipboard から多行入力しますか? (y / n で 1 行ずつ)" "y"; then
    log_info "Clipboard から metadata を取得します"
    read -r "?metadata を clipboard にコピーしてから Enter: " _
    pbpaste > "$metadata_file"
  else
    log_info "1 行ずつ入力 (空行で終了):"
    while true; do
      local line
      read -r line
      [[ -z "$line" ]] && break
      echo "$line" >> "$metadata_file"
    done
  fi
  
  if [[ ! -s "$metadata_file" ]]; then
    log_error "metadata が入力されていません"
    rm -f "$metadata_file"
    return 1
  fi
  
  log_info "入力された metadata:"
  cat "$metadata_file" | sed 's/^/  /'
  echo ""
  
  # Parse + 各 filed evaluation との対応 verify
  typeset -gA VERDICT_METADATA
  VERDICT_METADATA=()
  
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    # Parse: #NNN <Platform> | <Owner> | <Category>
    if [[ "$line" =~ \#?([0-9]{3})[[:space:]]+(.+)\|(.+)\|(.+) ]]; then
      local nnn="${match[1]}"
      local platform=$(trim "${match[2]}")
      local owner=$(trim "${match[3]}")
      local category=$(trim "${match[4]}")
      VERDICT_METADATA[$nnn]="${platform}|${owner}|${category}"
      log_debug "metadata parsed: #$nnn $platform | $owner | $category"
    else
      log_warn "不正な形式の行を skip: $line"
    fi
  done < "$metadata_file"
  
  rm -f "$metadata_file"
  
  # 各 filed evaluation に metadata 対応があるか verify
  local missing=()
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug rest <<< "$entry"
    if [[ -z "${VERDICT_METADATA[$nnn]:-}" ]]; then
      missing+=("$nnn")
    fi
  done
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    log_error "以下の評価に metadata 対応がありません: ${missing[*]}"
    return 1
  fi
  
  log_success "Metadata 収集完了 (${#VERDICT_METADATA[@]} 件)"
  return 0
}

# ============================================================================
# Stage files
# ============================================================================

stage_files() {
  log_section "Phase 2.3: Stage files"
  
  cd "$PLATFORMS_REPO" || return 1
  
  local files_to_stage=()
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug platform owner category fw_ver file_path size lines <<< "$entry"
    files_to_stage+=("evaluations/${nnn}_${slug}.md")
  done
  
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    log_info "[DRY-RUN] git add: ${files_to_stage[*]}"
  else
    if ! git add "${files_to_stage[@]}"; then
      log_error "git add 失敗"
      return 1
    fi
  fi
  
  # Staged review (institutional 重要)
  log_info "Staged files の statistics (git diff --cached --stat):"
  echo ""
  
  local stat_output
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    # Dry-run でも stat 確認
    git diff --stat "${files_to_stage[@]}" 2>/dev/null | sed 's/^/  /'
  else
    stat_output=$(git diff --cached --stat)
    echo "$stat_output" | sed 's/^/  /'
  fi
  echo ""
  
  # institutional sanity check: 各 file の追加行数が妥当範囲か
  local anomaly_detected=false
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug platform owner category fw_ver file_path size lines <<< "$entry"
    if (( lines < 30 )); then
      log_warn "  #$nnn $slug: 行数異常 ($lines 行 < 30)"
      anomaly_detected=true
    fi
    if (( lines > 2000 )); then
      log_warn "  #$nnn $slug: 行数異常 ($lines 行 > 2000)"
      anomaly_detected=true
    fi
  done
  
  if $anomaly_detected; then
    log_warn "Stage 検証で行数異常を検知しました"
    if ! prompt_confirm "それでも commit を続行しますか? (institutional に注意)" "n"; then
      log_info "中断、unstage します"
      git reset HEAD "${files_to_stage[@]}" 2>/dev/null
      return 1
    fi
  fi
  
  log_success "Stage 検証完了"
  return 0
}

# ============================================================================
# Commit message generation
# template ベース、institutional precedent (#062-#064 commit 556401f) 整合
# ============================================================================

generate_commit_message() {
  local message_file
  message_file=$(mktemp -t verdict_commit_msg.XXXXXX)
  
  # Header line: "Add evaluations #NNN <Platform>, #NNN <Platform>, ... to evaluations/"
  local header_parts=()
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug rest <<< "$entry"
    local meta="${VERDICT_METADATA[$nnn]}"
    IFS='|' read -r platform owner category <<< "$meta"
    header_parts+=("#${nnn} ${platform}")
  done
  
  local header_joined
  header_joined=$(IFS=', '; echo "${header_parts[*]}")
  
  local count="${#VERDICT_FILED_EVALUATIONS[@]}"
  
  # Compose message
  cat > "$message_file" << EOF
Add evaluations ${header_joined} to evaluations/

Engine output verbatim per Path β workflow (operations_workflow_v2.md Section 4.2).
${count} new evaluation$([ $count -gt 1 ] && echo "s") deployed via verdict_deploy.sh v1.0.

EOF
  
  # Per-evaluation details
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug rest <<< "$entry"
    local meta="${VERDICT_METADATA[$nnn]}"
    IFS='|' read -r platform owner category <<< "$meta"
    echo "- #${nnn} ${platform} (${owner}) — ${category}" >> "$message_file"
  done
  
  cat >> "$message_file" << 'EOF'

Operations override application, canonical platforms/{slug}.md generation,
and HTML page generation are deferred to subsequent Operations / Strategy
sessions per role-boundary discipline.

Identity: zinova-lab
EOF
  
  echo "$message_file"
}

# ============================================================================
# Commit + Push
# ============================================================================

execute_commit_push() {
  log_section "Phase 2.4: Commit & Push"
  
  cd "$PLATFORMS_REPO" || return 1
  
  # Commit message 生成
  local message_file
  message_file=$(generate_commit_message)
  
  log_info "Commit message preview:"
  echo "---"
  cat "$message_file"
  echo "---"
  echo ""
  
  if ! prompt_confirm "この内容で commit & push しますか?" "y"; then
    log_warn "Commit cancelled, unstaging..."
    git reset HEAD evaluations/*.md 2>/dev/null
    rm -f "$message_file"
    return 1
  fi
  
  # Commit
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    log_info "[DRY-RUN] git commit -F $message_file"
    log_info "[DRY-RUN] git push origin $EXPECTED_BRANCH"
    rm -f "$message_file"
    typeset -g VERDICT_COMMIT_HASH="dry-run-hash"
    return 0
  fi
  
  if ! git commit -F "$message_file"; then
    log_error "Commit 失敗"
    rm -f "$message_file"
    return 1
  fi
  
  rm -f "$message_file"
  
  local commit_hash
  commit_hash=$(git rev-parse HEAD)
  typeset -g VERDICT_COMMIT_HASH="$commit_hash"
  log_success "Commit 完了: $commit_hash"
  
  # Push
  log_info "Push 開始..."
  if ! git push origin "$EXPECTED_BRANCH"; then
    log_error "Push 失敗"
    return 1
  fi
  
  log_success "Push 完了: ZinovaCreation/verdict-platforms ($EXPECTED_BRANCH)"
  log_info "git log:"
  git log --oneline -3 | sed 's/^/  /'
  
  return 0
}

# ============================================================================
# Public interface
# ============================================================================

run_phase_2() {
  log_section "Phase 2: Stage / Commit / Push"
  
  verify_pre_commit || return 1
  collect_metadata || return 1
  stage_files || return 1
  execute_commit_push || return 1
  
  return 0
}

COMMIT_PUSH_VERSION="1.0"
COMMIT_PUSH_LOADED=true
log_debug "commit_push.sh v${COMMIT_PUSH_VERSION} loaded"

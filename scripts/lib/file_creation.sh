#!/usr/bin/env zsh
# verdict-engine/scripts/lib/file_creation.sh
# 
# Phase 1: Sequential evaluation filing module
# 
# institutional 責任:
#   - 評価番号入力
#   - Platform 名入力 + slug 自動生成
#   - Slug 既存 check (curl で remote 確認)
#   - Clipboard 経由 content 取得
#   - Content validation
#   - Preview + 確認
#   - File write
# 
# Dependencies: lib/utils.sh
# 17 欠点対策: Layer 1.4 (pbpaste), 4.2 (validation)

# ============================================================================
# Slug generation
# ============================================================================

# Phase β convention: lowercase, space → underscore, invalid char strip
# 
# 入力例:
#   "NeMo Guardrails" → "nemo_guardrails"
#   "Cohere"          → "cohere"
#   "Arize AI"        → "arize_ai"
#   "OpenAI Assistants" → "openai_assistants"
generate_slug() {
  local input="$1"
  local result
  
  # 1. lowercase
  result="${input:l}"
  
  # 2. space → underscore
  result="${result// /_}"
  
  # 3. 不正文字 strip (a-z, 0-9, _, - のみ保持)
  result=$(echo "$result" | sed 's/[^a-z0-9_-]//g')
  
  # 4. _ 連続圧縮
  result=$(echo "$result" | sed 's/__*/_/g')
  
  # 5. 先頭・末尾の _ - を削除
  result="${result#[_-]}"
  result="${result%[_-]}"
  
  echo "$result"
}

# ============================================================================
# Slug existence check
# Returns: 
#   0 = 新規 deploy 可能
#   1 = Phase β (verdict-platforms) に既存
#   2 = Phase α legacy (verdict-index) に既存
#   3 = 両方に既存
# ============================================================================

check_slug_existence() {
  local nnn="$1"
  local slug="$2"
  local slug_hyphen="${slug//_/-}"
  
  local phase_beta_url="https://raw.githubusercontent.com/ZinovaCreation/verdict-platforms/main/evaluations/${nnn}_${slug}.md"
  local phase_alpha_url_underscore="https://raw.githubusercontent.com/zinova-lab/verdict-index/main/${slug}/index.html"
  local phase_alpha_url_hyphen="https://raw.githubusercontent.com/zinova-lab/verdict-index/main/${slug_hyphen}/index.html"
  
  local beta_status
  beta_status=$(curl_status "${phase_beta_url}?v=1")
  
  local alpha_status_u
  alpha_status_u=$(curl_status "${phase_alpha_url_underscore}?v=1")
  
  local alpha_status_h
  alpha_status_h=$(curl_status "${phase_alpha_url_hyphen}?v=1")
  
  log_debug "slug existence: Phase β=$beta_status, Phase α underscore=$alpha_status_u, Phase α hyphen=$alpha_status_h"
  
  local beta_exists=false
  local alpha_exists=false
  
  [[ "$beta_status" == "200" ]] && beta_exists=true
  [[ "$alpha_status_u" == "200" || "$alpha_status_h" == "200" ]] && alpha_exists=true
  
  if $beta_exists && $alpha_exists; then
    return 3
  elif $beta_exists; then
    return 1
  elif $alpha_exists; then
    return 2
  else
    return 0
  fi
}

# ============================================================================
# Content validation
# 対策: 欠点 4.2 (Notion export 揺れ)
# ============================================================================

validate_content() {
  local content="$1"
  local issues=()
  
  # Check 1: 非空
  if [[ -z "$content" ]]; then
    issues+=("空のコンテンツ")
  fi
  
  # Check 2: 最初の 1KB に "# " heading
  local first_chunk
  first_chunk=$(echo "$content" | head -c 1024)
  if ! echo "$first_chunk" | grep -q "^# "; then
    issues+=("先頭 1KB に markdown heading (# ) が見つかりません")
  fi
  
  # Check 3: 行数 30-2000
  local line_count
  line_count=$(echo "$content" | wc -l | tr -d ' ')
  if (( line_count < 30 )); then
    issues+=("行数が少なすぎます ($line_count, 期待: 30以上)")
  fi
  if (( line_count > 2000 )); then
    issues+=("行数が多すぎます ($line_count, 期待: 2000以下)")
  fi
  
  # Check 4: CRLF check
  if echo "$content" | head -c 4096 | grep -q $'\r'; then
    issues+=("CRLF 改行コード検出 (LF 推奨)")
  fi
  
  # Check 5: UTF-8 validity (基本的に zsh は OK、念のため)
  if ! echo "$content" | iconv -f UTF-8 -t UTF-8 >/dev/null 2>&1; then
    issues+=("UTF-8 として valid ではありません")
  fi
  
  if [[ ${#issues[@]} -gt 0 ]]; then
    log_warn "Content validation で問題検出:"
    for issue in "${issues[@]}"; do
      log_warn "  - $issue"
    done
    return 1
  fi
  
  return 0
}

# ============================================================================
# Preview
# ============================================================================

preview_content() {
  local content="$1"
  
  log_info "Content preview:"
  echo ""
  echo "--- 先頭 5 行 ---"
  echo "$content" | head -5
  echo "..."
  echo "--- 末尾 3 行 ---"
  echo "$content" | tail -3
  echo ""
  
  local line_count size_bytes
  line_count=$(echo "$content" | wc -l | tr -d ' ')
  size_bytes=$(echo -n "$content" | wc -c | tr -d ' ')
  log_info "  行数: $line_count"
  log_info "  サイズ: $size_bytes bytes"
}

# ============================================================================
# File write
# 対策: shell quoting safety
# ============================================================================

write_evaluation_file() {
  local target_path="$1"
  local content="$2"
  
  # parent directory 確認 / 作成
  local parent_dir
  parent_dir=$(dirname "$target_path")
  if [[ ! -d "$parent_dir" ]]; then
    if ! mkdir -p "$parent_dir"; then
      log_error "ディレクトリ作成失敗: $parent_dir"
      return 1
    fi
  fi
  
  # institutional に safe な書き込み: 一時 file 経由でアトミックに置換
  local temp_file="${target_path}.tmp.$$"
  
  if ! printf '%s' "$content" > "$temp_file"; then
    log_error "一時 file 書き込み失敗: $temp_file"
    rm -f "$temp_file"
    return 1
  fi
  
  # Atomic move
  if ! mv "$temp_file" "$target_path"; then
    log_error "file 移動失敗: $temp_file -> $target_path"
    rm -f "$temp_file"
    return 1
  fi
  
  log_debug "file 書き込み完了: $target_path"
  return 0
}

# ============================================================================
# Single evaluation filing flow
# Returns: stdout に "NNN:slug:platform:owner:category:framework_version:file_path:size:lines"
#          または "__SKIP__" / "__DONE__"
# ============================================================================

file_single_evaluation() {
  log_section "Phase 1: 評価ファイル化"
  
  # ----- Step 1.1: 評価番号入力 -----
  local nnn
  nnn=$(prompt_with_help \
    "次に処理する評価番号" \
    "3 桁数字 (例: 065, 070, 073)。'status' で deploy 状況、'done' で Phase 2 移行" \
    "^(#?[0-9]{3}|status|done|deploy|quit)$")
  
  [[ "$nnn" == "__BACK__" ]] && return 1
  [[ "$nnn" == "__QUIT__" ]] && { echo "__QUIT__"; return 0; }
  
  case "$nnn" in
    status)
      display_deploy_status
      file_single_evaluation
      return $?
      ;;
    done|deploy)
      echo "__DONE__"
      return 0
      ;;
  esac
  
  nnn="${nnn#\#}"  # # prefix を除去
  
  if [[ ! "$nnn" =~ ^[0-9]{3}$ ]]; then
    log_error "不正な評価番号形式: $nnn"
    return 1
  fi
  
  log_success "番号受領: #$nnn"
  
  # ----- Step 1.2: Platform 名入力 -----
  local platform_name
  platform_name=$(prompt_with_help \
    "Platform 名 (slug の元になります)" \
    "正式名を入力 (例: 'Cohere', 'NeMo Guardrails', 'Arize AI')")
  
  [[ "$platform_name" == "__BACK__" ]] && return 1
  [[ "$platform_name" == "__QUIT__" ]] && { echo "__QUIT__"; return 0; }
  
  if [[ -z "$platform_name" ]]; then
    log_error "Platform 名が空"
    return 1
  fi
  
  # ----- Slug 生成 + 確認 -----
  local slug
  slug=$(generate_slug "$platform_name")
  log_info "提案 slug: $slug"
  
  local confirm_slug
  confirm_slug=$(prompt_with_help \
    "この slug で進めますか? (y / 別 slug 入力)" \
    "y で承認、別 slug を input すると override (lowercase + 英数字 + _ - のみ)")
  
  [[ "$confirm_slug" == "__BACK__" ]] && return 1
  [[ "$confirm_slug" == "__QUIT__" ]] && { echo "__QUIT__"; return 0; }
  
  if [[ "$confirm_slug" != "y" && "$confirm_slug" != "yes" ]]; then
    # 別 slug 入力
    if [[ ! "$confirm_slug" =~ ^[a-z0-9_-]+$ ]]; then
      log_error "不正な slug 形式: $confirm_slug"
      return 1
    fi
    slug="$confirm_slug"
    log_info "Slug 上書き: $slug"
  fi
  
  # ----- 既存 check -----
  log_info "Slug existence check (curl 確認中)..."
  check_slug_existence "$nnn" "$slug"
  local exists_status=$?
  
  case "$exists_status" in
    0)
      log_success "Slug '$slug' は新規 deploy 可能"
      ;;
    1)
      log_warn "Slug '$slug' は Phase β (verdict-platforms) に既存"
      log_warn "  上書きすると過去 deploy が破壊されます"
      if ! prompt_confirm "本当に上書きしますか? (過去版は git history 内)" "n"; then
        log_info "中断"
        return 1
      fi
      ;;
    2)
      log_info "Slug '$slug' は Phase α legacy (verdict-index) に存在"
      log_info "  本 Phase β deploy は legacy と institutional に共存します"
      if ! prompt_confirm "Phase β として新規 deploy しますか?" "y"; then
        log_info "中断"
        return 1
      fi
      ;;
    3)
      log_warn "Slug '$slug' は Phase α と Phase β 両方に存在"
      log_warn "  Phase β 既存ファイルを上書きすることになります"
      if ! prompt_confirm "本当に上書きしますか?" "n"; then
        return 1
      fi
      ;;
  esac
  
  # ----- Step 1.3: Content 取得 (editor 経由、institutional 複数 source 対応) -----
  local temp_file="/tmp/verdict_eval_${nnn}_${slug}.md"
  
  # institutional 既存 temp file 確認 (前回中断からの復元)
  if [[ -f "$temp_file" ]]; then
    log_warn "前回の temp file が institutional に残存: $temp_file"
    if prompt_confirm "既存内容を使用しますか? (n で破棄して新規作成)" "y"; then
      log_info "既存 temp file の内容を使用します"
    else
      rm -f "$temp_file"
    fi
  fi
  
  # institutional 新規 temp file 作成 (空 file または header のみ)
  if [[ ! -f "$temp_file" ]]; then
    cat > "$temp_file" << TEMPLATE_EOF
# 評価 #${nnn} ${slug}

<!-- 
institutional 編集手順:
  1. Notion で英語評価を select → Cmd+C
  2. ここに貼付 (Cmd+V)
  3. Notion で日本語評価を select → Cmd+C
  4. 続けて貼付 (Cmd+V)
  5. 必要に応じて institutional に編集
  6. 保存 + 終了:
     - nano: Ctrl+O → Enter → Ctrl+X
     - vim: :wq → Enter
     - VS Code: Cmd+S → Cmd+W
  
このコメントブロックは institutional に削除可能 (任意)。
-->

TEMPLATE_EOF
  fi
  
  log_info "評価コンテンツを editor で institutional 編集します"
  log_info "  Temp file: $temp_file"
  log_info ""
  log_info "institutional 編集手順:"
  log_info "  - Notion 英語評価を copy → 貼付"
  log_info "  - Notion 日本語評価を copy → 貼付 (順序自由)"
  log_info "  - 保存 + 終了で本 script に戻ります"
  log_info ""
  
  read -r "?Enter で editor を起動: " _
  
  # institutional editor 選択: $EDITOR -> code --wait -> vim
  # nano は institutional に hang する環境があるため除外
  local editor_cmd=""
  if [[ -n "${EDITOR:-}" ]] && command -v "${EDITOR%% *}" >/dev/null 2>&1; then
    editor_cmd="$EDITOR"
  elif command -v code >/dev/null 2>&1; then
    editor_cmd="code --wait"
  elif command -v vim >/dev/null 2>&1; then
    editor_cmd="vim"
  else
    log_error "利用可能な editor が institutional に見つかりません"
    return 1
  fi
  log_info "Editor 起動: $editor_cmd"
  log_info "  (VS Code: 編集後タブを閉じると script に復帰)"
  log_info "  (vim: 編集後 :wq で保存終了)"
  echo ""
  ${=editor_cmd} "$temp_file" < /dev/tty > /dev/tty 2>&1
  local editor_exit=$?
  
  if [[ $editor_exit -ne 0 ]]; then
    log_warn "Editor が non-zero exit ($editor_exit) で institutional 終了"
    if ! prompt_confirm "それでも続行しますか?" "n"; then
      return 1
    fi
  fi
  
  # institutional file 読み取り
  if [[ ! -f "$temp_file" ]]; then
    log_error "Temp file が institutional に消失: $temp_file"
    return 1
  fi
  
  local content
  content=$(cat "$temp_file")
  
  if [[ -z "$content" ]]; then
    log_error "Temp file が空、編集が institutional に行われませんでした"
    return 1
  fi
  
  # institutional cleanup: temp file は配置成功後に削除 (institutional safety net)
  
  # ----- Content validation -----
  if ! validate_content "$content"; then
    log_warn "Validation に問題がありますが、続行可能です"
    if ! prompt_confirm "続行しますか?" "n"; then
      return 1
    fi
  fi
  
  # ----- Preview + 確認 -----
  preview_content "$content"
  
  if ! prompt_confirm "この内容で配置しますか?" "y"; then
    log_info "中断、再入力可能"
    return 1
  fi
  
  # ----- File write -----
  local target_path="$PLATFORMS_REPO/evaluations/${nnn}_${slug}.md"
  
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    log_info "[DRY-RUN] 書き込み対象: $target_path"
  else
    if ! write_evaluation_file "$target_path" "$content"; then
      log_error "file 書き込み失敗"
      return 1
    fi
  fi
  
  # ----- Verification -----
  local file_size line_count
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    file_size=$(echo -n "$content" | wc -c | tr -d ' ')
    line_count=$(echo "$content" | wc -l | tr -d ' ')
  else
    if [[ ! -f "$target_path" ]]; then
      log_error "file 書き込み後の存在確認失敗: $target_path"
      return 1
    fi
    file_size=$(stat -f%z "$target_path" 2>/dev/null || stat -c%s "$target_path" 2>/dev/null)
    line_count=$(wc -l < "$target_path" | tr -d ' ')
  fi
  
  # institutional cleanup: 成功時のみ temp file 削除
  if [[ -f "$temp_file" ]] && [[ "${VERDICT_DRY_RUN:-false}" != "true" ]]; then
    rm -f "$temp_file"
    log_debug "Temp file cleaned: $temp_file"
  fi
  
  log_success "#$nnn $slug 配置完了"
  log_info "  パス: $target_path"
  log_info "  サイズ: $file_size bytes"
  log_info "  行数: $line_count"
  
  # ----- Return entry (Phase 2 で metadata は別途収集) -----
  # Format: nnn:slug:::: :file_path:size:lines (中間 5 fields は Phase 2 で埋める)
  echo "${nnn}:${slug}::::: $target_path:${file_size}:${line_count}"
}

# ============================================================================
# Public interface
# ============================================================================

run_phase_1() {
  log_section "Phase 1: Sequential evaluation filing"
  
  if [[ "${VERDICT_SKIP_PHASE_1:-false}" == "true" ]]; then
    log_info "Phase 1 を skip (既存ファイルを使用)"
    # 既存ファイルから filed_evaluations list を construct
    _detect_existing_evaluations
    return $?
  fi
  
  local filed_evaluations=()
  
  while true; do
    local result
    result=$(file_single_evaluation)
    local exit_code=$?
    
    if [[ "$result" == "__DONE__" ]]; then
      log_info "Phase 1 完了、Phase 2 へ移行"
      break
    fi
    
    if [[ "$result" == "__QUIT__" ]]; then
      log_warn "user request: 中断"
      return 1
    fi
    
    if [[ $exit_code -ne 0 ]]; then
      log_warn "評価の filing 中断、再試行可能"
      continue
    fi
    
    filed_evaluations+=("$result")
    log_info "本 session 配置済: ${#filed_evaluations[@]} 件"
    
    echo ""
    if ! prompt_confirm "別の評価をファイル化しますか?" "y"; then
      break
    fi
  done
  
  if [[ ${#filed_evaluations[@]} -eq 0 ]]; then
    log_warn "配置された評価がありません"
    return 1
  fi
  
  # Export for Phase 2
  typeset -ga VERDICT_FILED_EVALUATIONS
  VERDICT_FILED_EVALUATIONS=("${filed_evaluations[@]}")
  
  log_success "Phase 1 完了: ${#filed_evaluations[@]} 件"
  return 0
}

_detect_existing_evaluations() {
  local existing=()
  for file in "$PLATFORMS_REPO/evaluations"/*.md; do
    [[ -f "$file" ]] || continue
    local basename
    basename=$(basename "$file" .md)
    # Check if untracked
    if (cd "$PLATFORMS_REPO" && git ls-files --error-unmatch "evaluations/$(basename "$file")" >/dev/null 2>&1); then
      continue  # already tracked
    fi
    
    if [[ "$basename" =~ ^([0-9]{3})_(.+)$ ]]; then
      local nnn="${match[1]}"
      local slug="${match[2]}"
      local size line_count
      size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
      line_count=$(wc -l < "$file" | tr -d ' ')
      existing+=("${nnn}:${slug}::::: $file:${size}:${line_count}")
    fi
  done
  
  if [[ ${#existing[@]} -eq 0 ]]; then
    log_error "evaluations/ に untracked ファイルが見つかりません"
    return 1
  fi
  
  log_info "既存 untracked ファイル: ${#existing[@]} 件検出"
  for entry in "${existing[@]}"; do
    log_info "  - $entry"
  done
  
  typeset -ga VERDICT_FILED_EVALUATIONS
  VERDICT_FILED_EVALUATIONS=("${existing[@]}")
  return 0
}

# ============================================================================
# Module info
# ============================================================================

FILE_CREATION_VERSION="1.0"
FILE_CREATION_LOADED=true

log_debug "file_creation.sh v${FILE_CREATION_VERSION} loaded"

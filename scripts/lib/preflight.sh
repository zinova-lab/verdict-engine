#!/usr/bin/env zsh
# verdict-engine/scripts/lib/preflight.sh
# 
# Phase 0: Pre-flight verification module
# 
# institutional 責任:
#   - Repository path 検証
#   - Remote URL 検証
#   - Branch 検証
#   - Git state diagnosis (7 anomaly types)
#   - Anomaly 別 recovery handler dispatch
# 
# institutional history:
#   - worktree helper v3 template Phase 0 decision tree を shell 化
#   - 17 欠点対策 mapping: Layer 1.1 (dispatch table 形式で表現力)
# 
# Dependencies: lib/utils.sh

# ============================================================================
# Constants
# ============================================================================

EXPECTED_REMOTE_PLATFORMS="${EXPECTED_REMOTE_PLATFORMS:-https://github.com/ZinovaCreation/verdict-platforms.git}"
EXPECTED_BRANCH="${EXPECTED_BRANCH:-main}"
PLATFORMS_REPO="${PLATFORMS_REPO:-$HOME/Desktop/VERDICT/verdict-platforms}"

# Anomaly type dispatch table
typeset -A ANOMALY_HANDLERS=(
  [path_not_found]="handle_path_not_found"
  [wrong_remote]="handle_wrong_remote"
  [wrong_branch]="handle_wrong_branch"
  [ahead_of_origin]="handle_ahead_of_origin"
  [behind_origin]="handle_behind_origin"
  [uncommitted]="handle_uncommitted"
  [untracked_evaluations]="handle_untracked_evaluations"
)

# ============================================================================
# Individual check functions
# Each returns: 0 = OK, 1 = anomaly detected
# ============================================================================

check_path() {
  if [[ ! -d "$PLATFORMS_REPO" ]]; then
    log_debug "anomaly: path_not_found ($PLATFORMS_REPO)"
    return 1
  fi
  if [[ ! -d "$PLATFORMS_REPO/.git" ]]; then
    log_debug "anomaly: not a git repo ($PLATFORMS_REPO)"
    return 1
  fi
  return 0
}

check_remote_url() {
  local actual
  actual=$(cd "$PLATFORMS_REPO" && git config --get remote.origin.url 2>/dev/null)
  if [[ "$actual" != "$EXPECTED_REMOTE_PLATFORMS" ]]; then
    log_debug "anomaly: wrong_remote (actual: $actual, expected: $EXPECTED_REMOTE_PLATFORMS)"
    return 1
  fi
  return 0
}

check_branch() {
  local current
  current=$(cd "$PLATFORMS_REPO" && git branch --show-current 2>/dev/null)
  if [[ "$current" != "$EXPECTED_BRANCH" ]]; then
    log_debug "anomaly: wrong_branch (current: $current, expected: $EXPECTED_BRANCH)"
    return 1
  fi
  return 0
}

check_git_state() {
  cd "$PLATFORMS_REPO" || return 1
  
  # Fetch latest origin state (institutional 必須、stale 判断回避のため)
  if ! git fetch origin "$EXPECTED_BRANCH" --quiet 2>/dev/null; then
    log_warn "git fetch 失敗、network 問題の可能性"
  fi
  
  # Ahead/behind check
  local ahead behind
  ahead=$(git rev-list --count "origin/$EXPECTED_BRANCH..$EXPECTED_BRANCH" 2>/dev/null || echo "0")
  behind=$(git rev-list --count "$EXPECTED_BRANCH..origin/$EXPECTED_BRANCH" 2>/dev/null || echo "0")
  
  if [[ "$ahead" -gt 0 ]]; then
    log_debug "anomaly: ahead_of_origin (count: $ahead)"
    echo "ahead_of_origin"
    return 1
  fi
  
  if [[ "$behind" -gt 0 ]]; then
    log_debug "anomaly: behind_origin (count: $behind)"
    echo "behind_origin"
    return 1
  fi
  
  # Uncommitted changes check
  if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
    log_debug "anomaly: uncommitted"
    echo "uncommitted"
    return 1
  fi
  
  # Untracked files in evaluations/ check
  local untracked
  untracked=$(git status --short 2>/dev/null | grep '^?? evaluations/' | wc -l | tr -d ' ')
  if [[ "$untracked" -gt 0 ]]; then
    log_debug "anomaly: untracked_evaluations (count: $untracked)"
    echo "untracked_evaluations"
    return 1
  fi
  
  echo "clean"
  return 0
}

# ============================================================================
# Main diagnosis function
# Returns: stdout に "clean" or anomaly type
# ============================================================================

diagnose_repo_state() {
  log_section "Phase 0: Pre-flight 検証"
  
  # 順次 check、最初に hit したものを return
  if ! check_path; then
    echo "path_not_found"
    return 1
  fi
  
  if ! check_remote_url; then
    echo "wrong_remote"
    return 1
  fi
  
  if ! check_branch; then
    echo "wrong_branch"
    return 1
  fi
  
  # check_git_state は detailed state を echo するので別扱い
  local state
  state=$(check_git_state)
  echo "$state"
  
  [[ "$state" == "clean" ]] && return 0 || return 1
}

# ============================================================================
# Anomaly handlers
# Each handler: user に状況説明 → recovery 提案 → 実行 → 再診断
# Returns: 0 = recovered, 1 = aborted
# ============================================================================

handle_path_not_found() {
  log_error "verdict-platforms repository が想定パスに見つかりません"
  log_info "  想定: $PLATFORMS_REPO"
  log_info "  観測: ディレクトリ不在"
  echo ""
  
  log_info "Fallback として home 配下を検索します..."
  local candidates
  candidates=$(find "$HOME" -maxdepth 4 -type d -name "verdict-platforms" 2>/dev/null | head -5)
  
  if [[ -n "$candidates" ]]; then
    log_info "候補が見つかりました:"
    echo "$candidates" | sed 's/^/  /'
    echo ""
    
    local response
    response=$(prompt_with_help \
      "正しいパスを入力してください (上記候補のいずれか、または別パス)" \
      "見つかった候補から選ぶか、フルパスを入力してください。空欄で abort。")
    
    if [[ -z "$response" ]]; then
      return 1
    fi
    
    if [[ -d "$response" ]]; then
      PLATFORMS_REPO="$response"
      log_success "PLATFORMS_REPO を $PLATFORMS_REPO に設定しました"
      return 0
    else
      log_error "指定パスが存在しません: $response"
      return 1
    fi
  fi
  
  # 候補なし、clone 提案
  log_warn "verdict-platforms repo が local に見つかりません"
  if prompt_confirm "新規 clone しますか? (装着先: $PLATFORMS_REPO)" "n"; then
    mkdir -p "$(dirname "$PLATFORMS_REPO")"
    if git clone "$EXPECTED_REMOTE_PLATFORMS" "$PLATFORMS_REPO"; then
      log_success "clone 完了"
      return 0
    else
      log_error "clone 失敗"
      return 1
    fi
  fi
  
  return 1
}

handle_wrong_remote() {
  local actual
  actual=$(cd "$PLATFORMS_REPO" && git config --get remote.origin.url)
  
  log_error "remote URL が想定と異なります"
  log_info "  観測: $actual"
  log_info "  期待: $EXPECTED_REMOTE_PLATFORMS"
  echo ""
  log_warn "これは重大な設定問題です。誤った repository への push は institutional に取り返しがつきません"
  echo ""
  
  log_info "考えられる原因:"
  log_info "  - 別 fork (zinova-lab/verdict-platforms 等) を指している"
  log_info "  - SSH/HTTPS の URL 形式違い"
  log_info "  - 単純な typo"
  echo ""
  
  if prompt_confirm "remote URL を $EXPECTED_REMOTE_PLATFORMS に更新しますか?" "n"; then
    if (cd "$PLATFORMS_REPO" && git remote set-url origin "$EXPECTED_REMOTE_PLATFORMS"); then
      log_success "remote URL 更新完了"
      return 0
    else
      log_error "remote URL 更新失敗"
      return 1
    fi
  fi
  
  log_warn "user 確認なしには修正しません。institutional safety のため abort します"
  return 1
}

handle_wrong_branch() {
  local current
  current=$(cd "$PLATFORMS_REPO" && git branch --show-current)
  
  log_error "main ブランチ以外にいます"
  log_info "  現在: $current"
  log_info "  期待: $EXPECTED_BRANCH"
  echo ""
  
  if prompt_confirm "main に切り替えますか?" "y"; then
    if (cd "$PLATFORMS_REPO" && git checkout "$EXPECTED_BRANCH"); then
      log_success "main に切り替え完了"
      return 0
    else
      log_error "切り替え失敗 (uncommitted changes 等の可能性)"
      return 1
    fi
  fi
  
  return 1
}

handle_ahead_of_origin() {
  local ahead
  ahead=$(cd "$PLATFORMS_REPO" && git rev-list --count "origin/$EXPECTED_BRANCH..$EXPECTED_BRANCH" 2>/dev/null || echo "0")
  
  log_warn "local commit が origin に push されていません"
  log_info "  未 push commit: $ahead 件"
  echo ""
  
  log_info "未 push commit 一覧:"
  (cd "$PLATFORMS_REPO" && git log --oneline "origin/$EXPECTED_BRANCH..$EXPECTED_BRANCH" | sed 's/^/  /')
  echo ""
  
  log_warn "新しい評価をファイル化する前に既存 commit を push する必要があります"
  log_warn "  (institutional 履歴の混在を回避するため)"
  echo ""
  
  if prompt_confirm "今すぐ push しますか?" "y"; then
    if (cd "$PLATFORMS_REPO" && git push origin "$EXPECTED_BRANCH"); then
      log_success "push 完了"
      return 0
    else
      log_error "push 失敗"
      return 1
    fi
  fi
  
  return 1
}

handle_behind_origin() {
  local behind
  behind=$(cd "$PLATFORMS_REPO" && git rev-list --count "$EXPECTED_BRANCH..origin/$EXPECTED_BRANCH" 2>/dev/null || echo "0")
  
  log_warn "local branch が origin から遅れています"
  log_info "  未取得 commit: $behind 件"
  echo ""
  
  log_info "未取得 commit 一覧:"
  (cd "$PLATFORMS_REPO" && git log --oneline "$EXPECTED_BRANCH..origin/$EXPECTED_BRANCH" | sed 's/^/  /')
  echo ""
  
  if prompt_confirm "今すぐ pull で同期しますか?" "y"; then
    if (cd "$PLATFORMS_REPO" && git pull origin "$EXPECTED_BRANCH"); then
      log_success "pull 完了"
      return 0
    else
      log_error "pull 失敗 (merge conflict の可能性)"
      return 1
    fi
  fi
  
  return 1
}

handle_uncommitted() {
  log_warn "作業ツリーに未コミット変更があります"
  echo ""
  
  log_info "考えられる原因:"
  log_info "  (a) 進行中の意図的作業 (別途 commit すべき)"
  log_info "  (b) 過去の中断された session の残骸"
  log_info "  (c) 過去 helper session で配置済の評価ファイル"
  echo ""
  
  log_info "未コミット変更の詳細:"
  (cd "$PLATFORMS_REPO" && {
    echo "--- unstaged ---"
    git diff --stat
    echo "--- staged ---"
    git diff --cached --stat
  })
  echo ""
  
  log_info "選択肢:"
  log_info "  [1] stash で institutional に退避 (後で復元可能)"
  log_info "  [2] 既存変更を破棄 (institutional に注意: 取り返し不可)"
  log_info "  [3] 手動で対処後、再診断"
  log_info "  [4] abort"
  echo ""
  
  local choice
  choice=$(prompt_with_help \
    "選択 (1/2/3/4)" \
    "1: git stash で退避、2: git checkout -- . で破棄、3: 別 terminal で手動対処、4: 中断" \
    "^[1-4]$")
  
  case "$choice" in
    1)
      if (cd "$PLATFORMS_REPO" && git stash push -m "verdict_deploy.sh pre-deploy stash $(date -u +'%Y%m%dT%H%M%SZ')"); then
        log_success "stash 完了 (復元: git stash pop)"
        return 0
      else
        log_error "stash 失敗"
        return 1
      fi
      ;;
    2)
      if ! prompt_confirm "本当に変更を破棄しますか? (取り返しがつきません)" "n"; then
        log_info "中断"
        return 1
      fi
      (cd "$PLATFORMS_REPO" && git checkout -- . && git clean -fd)
      log_warn "変更を破棄しました"
      return 0
      ;;
    3)
      log_info "別 terminal で対処後、本 script を再起動してください"
      return 1
      ;;
    4)
      return 1
      ;;
  esac
}

handle_untracked_evaluations() {
  log_warn "evaluations/ に未追跡ファイル検知"
  log_info "過去 helper session で配置後、commit & push 未完了の可能性"
  echo ""
  
  log_info "未追跡ファイル一覧:"
  (cd "$PLATFORMS_REPO" && git status --short | grep '^?? evaluations/' | sed 's/^/  /')
  echo ""
  
  log_info "選択肢:"
  log_info "  [1] 既存ファイルを使って Phase 2 commit のみ実行 (Phase 1 file 化 skip)"
  log_info "  [2] 既存ファイル削除して再開始"
  log_info "  [3] 手動で対処後、再診断"
  log_info "  [4] abort"
  echo ""
  
  local choice
  choice=$(prompt_with_help \
    "選択 (1/2/3/4)" \
    "1: 既存活用、2: 削除して再開、3: 手動対処、4: 中断" \
    "^[1-4]$")
  
  case "$choice" in
    1)
      log_success "Phase 1 を skip、既存ファイルで Phase 2 へ進みます"
      export VERDICT_SKIP_PHASE_1=true
      return 0
      ;;
    2)
      if ! prompt_confirm "未追跡ファイルを全て削除しますか?" "n"; then
        return 1
      fi
      (cd "$PLATFORMS_REPO" && git clean -fd evaluations/)
      log_warn "未追跡ファイルを削除しました"
      return 0
      ;;
    3)
      log_info "手動対処後、再起動してください"
      return 1
      ;;
    4)
      return 1
      ;;
  esac
}

# ============================================================================
# Public interface
# ============================================================================

run_preflight() {
  local max_iterations=5
  local iteration=0
  
  while (( iteration < max_iterations )); do
    iteration=$((iteration + 1))
    log_debug "preflight iteration: $iteration"
    
    local state
    state=$(diagnose_repo_state)
    
    if [[ "$state" == "clean" ]]; then
      log_success "Phase 0 検証完了"
      _display_repo_summary
      return 0
    fi
    
    log_debug "anomaly detected: $state"
    local handler="${ANOMALY_HANDLERS[$state]}"
    
    if [[ -z "$handler" ]]; then
      log_error "未知の anomaly type: $state"
      return 1
    fi
    
    if ! "$handler"; then
      log_error "anomaly recovery 失敗または abort"
      return 1
    fi
  done
  
  log_error "Phase 0 が $max_iterations 回の試行で収束しませんでした"
  log_error "institutional に深刻な repo state 問題の可能性、手動対処を推奨"
  return 1
}

_display_repo_summary() {
  log_info "リポジトリ状態:"
  log_info "  パス: $PLATFORMS_REPO"
  log_info "  ブランチ: $EXPECTED_BRANCH (origin と同期)"
  log_info "  リモート: $EXPECTED_REMOTE_PLATFORMS"
  log_info "  作業ツリー: clean"
  log_info "  最新 commit: $(cd "$PLATFORMS_REPO" && git log --oneline -1)"
}

# ============================================================================
# Module info
# ============================================================================

PREFLIGHT_VERSION="1.0"
PREFLIGHT_LOADED=true

log_debug "preflight.sh v${PREFLIGHT_VERSION} loaded"

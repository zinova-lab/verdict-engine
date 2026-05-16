#!/usr/bin/env zsh
# verdict-engine/scripts/verdict_deploy.sh
# 
# VERDICT Operations Deploy Script v1.0
# 
# Purpose: Stage 2 deploy (Engine 評価出力 markdown を 
# verdict-platforms/evaluations/ に commit & push) の institutional 自動化
# 
# Usage:
#   ./verdict_deploy.sh                # Interactive deploy
#   ./verdict_deploy.sh --dry-run      # Simulation only
#   ./verdict_deploy.sh --status       # deploy 状況のみ表示
#   ./verdict_deploy.sh --setup        # Initial setup wizard
#   ./verdict_deploy.sh --resume       # 前回 session 復元
#   ./verdict_deploy.sh --help         # Help
#   ./verdict_deploy.sh --version      # Version
# 
# Author: VERDICT Operations (ZinovaCreation)
# License: institutional internal use
# 
# institutional history:
#   v1.0 (2026-05-15): Initial release based on worktree helper v3 template

# ============================================================================
# Script bootstrap
# ============================================================================

set -euo pipefail

VERDICT_DEPLOY_VERSION="1.0"
SCRIPT_DIR="${0:A:h}"  # zsh で absolute dir
LIB_DIR="${SCRIPT_DIR}/lib"
HELPERS_DIR="${SCRIPT_DIR}/helpers"

# ============================================================================
# Module loading
# ============================================================================

for module in utils preflight status file_creation commit_push verify; do
  _verdict_module_path="${LIB_DIR}/${module}.sh"
  if [[ ! -f "$_verdict_module_path" ]]; then
    printf '[ERROR] Module not found: %s\n' "$_verdict_module_path" >&2
    exit 1
  fi
  source "$_verdict_module_path"
done
unset _verdict_module_path

# ============================================================================
# Constants
# ============================================================================

VERDICT_HOME="${VERDICT_HOME:-$HOME/Desktop/VERDICT}"
PLATFORMS_REPO="${PLATFORMS_REPO:-$VERDICT_HOME/verdict-platforms}"
ENGINE_REPO="${ENGINE_REPO:-$VERDICT_HOME/verdict-engine}"

EXPECTED_REMOTE_PLATFORMS="${EXPECTED_REMOTE_PLATFORMS:-https://github.com/ZinovaCreation/verdict-platforms.git}"
EXPECTED_BRANCH="${EXPECTED_BRANCH:-main}"

# ============================================================================
# Help / Version
# ============================================================================

show_help() {
  cat << 'EOF'
VERDICT Operations Deploy Script v1.0

USAGE:
  ./verdict_deploy.sh [OPTIONS]

OPTIONS:
  (no option)        Interactive deploy (default mode)
  --dry-run          実行 simulation のみ、実際の commit / push しない
  --status           deploy 状況を確認 (Phase 0.5 のみ実行)
  --setup            初回 environment setup wizard
  --resume           前回中断 session の state を復元 (実装中)
  --update-status    deploy_status.md のみ更新 (将来実装)
  --help             この help を表示
  --version          version 情報を表示
  --debug            verbose logging 有効

ENVIRONMENT VARIABLES:
  VERDICT_HOME       VERDICT repo group root (default: $HOME/Desktop/VERDICT)
  VERDICT_CONFIG     config file path
  VERDICT_DRY_RUN    "true" で dry-run mode
  VERDICT_DEBUG      "true" で verbose logging

WORKFLOW:
  Phase 0    Pre-flight verification (7 anomaly types)
  Phase 0.5  Deploy status query (optional, "status" command で発火)
  Phase 1    Sequential evaluation filing (clipboard 経由)
  Phase 2    Stage / Commit / Push
  Phase 2.5  CDN live verification (sleep 30 + retry)

EXAMPLES:
  ./verdict_deploy.sh                    # 通常の deploy
  ./verdict_deploy.sh --dry-run          # 試運転
  VERDICT_DEBUG=true ./verdict_deploy.sh # debug 出力付き

DEPENDENCIES:
  - zsh 5.x+
  - git
  - curl
  - python3 (for config parsing + deploy_status.md update)
  - pbpaste / pbcopy (macOS)

DOCUMENTATION:
  README.md in this directory
  verdict-engine/docs/deploy_status.md

VERSION: 1.0 (2026-05-15)
EOF
}

show_version() {
  cat << EOF
verdict_deploy.sh v${VERDICT_DEPLOY_VERSION}

Modules loaded:
  - utils.sh v${UTILS_VERSION}
  - preflight.sh v${PREFLIGHT_VERSION}
  - status.sh v${STATUS_VERSION}
  - file_creation.sh v${FILE_CREATION_VERSION}
  - commit_push.sh v${COMMIT_PUSH_VERSION}
  - verify.sh v${VERIFY_VERSION}

Environment:
  zsh: ${ZSH_VERSION}
  OS: $(uname -s) $(uname -r)
  git: $(git --version 2>/dev/null | awk '{print $3}')
  
VERDICT_HOME: $VERDICT_HOME
PLATFORMS_REPO: $PLATFORMS_REPO
EOF
}

# ============================================================================
# Setup wizard
# ============================================================================

run_setup_wizard() {
  log_section "VERDICT Deploy Setup Wizard"
  echo ""
  log_info "本 script の初回 setup を案内します"
  echo ""
  
  # Step 1: VERDICT_HOME
  log_info "[1/4] VERDICT_HOME 設定"
  log_info "  現在: $VERDICT_HOME"
  if prompt_confirm "別 path に変更しますか?" "n"; then
    local new_home
    new_home=$(prompt_with_help \
      "新しい VERDICT_HOME path" \
      "VERDICT 関連 repo の親 directory")
    VERDICT_HOME="$new_home"
    PLATFORMS_REPO="$VERDICT_HOME/verdict-platforms"
    ENGINE_REPO="$VERDICT_HOME/verdict-engine"
  fi
  
  # Step 2: Repo check
  log_info "[2/4] Repository 確認"
  if [[ ! -d "$PLATFORMS_REPO" ]]; then
    log_warn "  verdict-platforms repo が見つかりません"
    if prompt_confirm "clone しますか?" "y"; then
      mkdir -p "$VERDICT_HOME"
      git clone "$EXPECTED_REMOTE_PLATFORMS" "$PLATFORMS_REPO"
    fi
  else
    log_success "  verdict-platforms: $PLATFORMS_REPO"
  fi
  
  # Step 3: Git config check
  log_info "[3/4] Git config 確認"
  local user_name user_email
  user_name=$(cd "$PLATFORMS_REPO" && git config user.name || echo "")
  user_email=$(cd "$PLATFORMS_REPO" && git config user.email || echo "")
  
  if [[ -z "$user_name" || -z "$user_email" ]]; then
    log_warn "  git user.name / user.email 未設定"
    log_info "  以下で設定:"
    log_info "    git config --global user.name 'Your Name'"
    log_info "    git config --global user.email 'you@example.com'"
  else
    log_success "  user.name: $user_name"
    log_success "  user.email: $user_email"
  fi
  
  # Step 4: Network check
  log_info "[4/4] Network 接続確認"
  if check_network "https://raw.githubusercontent.com"; then
    log_success "  GitHub raw 接続 OK"
  else
    log_error "  GitHub raw 接続失敗"
  fi
  
  echo ""
  log_section "Setup 完了"
  log_info "通常の deploy: ./verdict_deploy.sh"
  log_info "Dry-run:       ./verdict_deploy.sh --dry-run"
  
  return 0
}

# ============================================================================
# Main workflow
# ============================================================================

run_main_workflow() {
  log_section "VERDICT Operations Deploy v${VERDICT_DEPLOY_VERSION}"
  
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    log_warn "DRY-RUN MODE: 実際の commit / push は行いません"
    echo ""
  fi
  
  # Environment verification
  verify_environment || return 1
  
  # Lock + clipboard backup setup
  acquire_lock || return 1
  setup_lock_trap
  backup_clipboard
  
  # Phase 0
  run_preflight || return 1
  
  # Phase 1
  run_phase_1 || return 1
  
  # Phase 2 + 2.5 (dry-run mode では institutional 全 skip)
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    log_section "Phase 2-2.5: Dry-run skip"
    log_info "[DRY-RUN] Phase 2 (Stage / Commit / Push / CDN verify) を institutional skip"
    log_info ""
    log_info "実 deploy では以下が institutional に実行されます:"
    log_info "  Phase 2.1  git status --short で untracked file 検証"
    log_info "  Phase 2.2  Platform metadata 入力 (clipboard or 1 行ずつ)"
    log_info "  Phase 2.3  git add + git diff --cached --stat review"
    log_info "  Phase 2.4  git commit + git push origin main"
    log_info "  Phase 2.5  sleep 30s + curl で CDN verification (retry 3)"
    log_info ""
    log_success "Dry-run 完走 — Phase 0 + Phase 1 institutional 動作確認済"
  else
    # Phase 2
    run_phase_2 || return 1
    
    # Phase 2.5
    verify_cdn_propagation || {
      log_warn "CDN verification に問題ありますが、push は完了しています"
      log_info "数分後に再確認してください"
    }
  fi
  
  # State save
  save_state_json "complete" "${VERDICT_COMMIT_HASH:-unknown}" "${VERDICT_FILED_EVALUATIONS[@]}"
  
  # Summary
  print_summary
  
  return 0
}

print_summary() {
  log_section "Deploy 完了 Summary"
  
  log_success "配置済評価: ${#VERDICT_FILED_EVALUATIONS[@]} 件"
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug rest <<< "$entry"
    local meta="${VERDICT_METADATA[$nnn]:-}"
    if [[ -n "$meta" ]]; then
      IFS='|' read -r platform owner category <<< "$meta"
      log_info "  - #${nnn} ${slug} (${platform})"
    else
      log_info "  - #${nnn} ${slug}"
    fi
  done
  echo ""
  
  log_info "Commit hash: ${VERDICT_COMMIT_HASH:-N/A}"
  log_info "Push 先: ZinovaCreation/verdict-platforms ($EXPECTED_BRANCH)"
  log_info "Script version: ${VERDICT_DEPLOY_VERSION}"
  echo ""
  
  log_info "後続 deploy stage (本 script は担当しない):"
  log_info "  - Stage 3: Canonical platforms/<slug>.md (YAML frontmatter)"
  log_info "  - Stage 4: docs/operations_override_log.md append"
  log_info "  - Stage 5: HTML platform pages, top index, rankings, sitemap"
  log_info "  - deploy_status.md 更新 (Python helper)"
  echo ""
  
  log_success "お疲れ様でした"
}

# ============================================================================
# Argument parsing + dispatch
# ============================================================================

main() {
  case "${1:-}" in
    --help|-h)
      show_help
      exit 0
      ;;
    --version|-v)
      show_version
      exit 0
      ;;
    --setup)
      run_setup_wizard
      exit $?
      ;;
    --status)
      display_deploy_status
      exit $?
      ;;
    --dry-run)
      export VERDICT_DRY_RUN=true
      run_main_workflow
      exit $?
      ;;
    --resume)
      log_warn "--resume mode は v1.x で実装予定"
      exit 1
      ;;
    --update-status)
      log_warn "--update-status mode は v1.x で実装予定 (Python helper 経由)"
      exit 1
      ;;
    --debug)
      export VERDICT_DEBUG=true
      run_main_workflow
      exit $?
      ;;
    "")
      run_main_workflow
      exit $?
      ;;
    *)
      log_error "未知のオプション: $1"
      show_help
      exit 1
      ;;
  esac
}

main "$@"

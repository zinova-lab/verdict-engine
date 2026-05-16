#!/usr/bin/env zsh
# verdict-engine/scripts/lib/utils.sh
# 
# Common utility functions for verdict_deploy.sh v1.0
# 
# institutional 責任:
#   - Logging (3 level)
#   - Lock 管理 (concurrent execution prevention)
#   - Clipboard 管理 (pre-session backup + cleanup)
#   - User prompts (with help subcommand)
#   - State JSON 保存 (Stage 3-5 連携用)
#   - Config 読み込み (YAML)
# 
# Dependencies: zsh 5.x+, pbpaste/pbcopy (macOS), python3
# 
# institutional history:
#   - 元 design: worktree helper v3 template の utility 機能を script 化
#   - 17 欠点対策 mapping: Layer 1.2, 4.1, 4.3, 5.2

# ============================================================================
# Logging functions
# ============================================================================

# institutional log level: INFO / WARN / ERROR / DEBUG
# DEBUG は VERDICT_DEBUG=true のみ出力

log_info() {
  printf '[\033[36mINFO\033[0m]  %s\n' "$*" >&2
}

log_warn() {
  printf '[\033[33mWARN\033[0m]  %s\n' "$*" >&2
}

log_error() {
  printf '[\033[31mERROR\033[0m] %s\n' "$*" >&2
}

log_debug() {
  [[ "${VERDICT_DEBUG:-false}" == "true" ]] && \
    printf '[\033[35mDEBUG\033[0m] %s\n' "$*" >&2
}

log_success() {
  printf '[\033[32mOK\033[0m]    %s\n' "$*" >&2
}

log_section() {
  printf '\n\033[1m=== %s ===\033[0m\n' "$*" >&2
}

# ============================================================================
# Lock 管理 (institutional concurrent execution prevention)
# 対策: 欠点 4.3
# ============================================================================

LOCK_FILE="${LOCK_FILE:-/tmp/verdict_deploy.lock}"

acquire_lock() {
  if [[ -f "$LOCK_FILE" ]]; then
    local pid
    pid=$(cat "$LOCK_FILE" 2>/dev/null)
    if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
      log_error "既に script (PID $pid) が実行中です"
      log_error "並行実行は institutional risk のため許可していません"
      log_info "終了するか、別 process を完了してから再試行してください"
      return 1
    else
      log_warn "stale lock 検出 (PID $pid not running)、削除します"
      rm -f "$LOCK_FILE"
    fi
  fi
  echo $$ > "$LOCK_FILE"
  log_debug "lock 取得: $LOCK_FILE (PID $$)"
  return 0
}

release_lock() {
  if [[ -f "$LOCK_FILE" ]]; then
    local pid
    pid=$(cat "$LOCK_FILE" 2>/dev/null)
    if [[ "$pid" == "$$" ]]; then
      rm -f "$LOCK_FILE"
      log_debug "lock 解放: $LOCK_FILE"
    fi
  fi
}

# institutional safety: script 終了時に必ず lock 解放
setup_lock_trap() {
  trap 'release_lock; restore_clipboard' EXIT INT TERM
}

# ============================================================================
# Clipboard 管理
# 対策: 欠点 4.1 (pre-session backup + cleanup)
# ============================================================================

CLIPBOARD_BACKUP_FILE="${CLIPBOARD_BACKUP_FILE:-/tmp/verdict_deploy_clipboard_backup.txt}"
CLIPBOARD_BACKUP_DONE=false

backup_clipboard() {
  if [[ "$CLIPBOARD_BACKUP_DONE" == "true" ]]; then
    return 0
  fi
  if ! command -v pbpaste >/dev/null 2>&1; then
    log_warn "pbpaste 未検出 (macOS 以外?)、clipboard backup を skip"
    return 0
  fi
  pbpaste > "$CLIPBOARD_BACKUP_FILE" 2>/dev/null || true
  CLIPBOARD_BACKUP_DONE=true
  log_debug "clipboard backup 保存: $CLIPBOARD_BACKUP_FILE"
}

restore_clipboard() {
  if [[ "$CLIPBOARD_BACKUP_DONE" != "true" ]] || [[ ! -f "$CLIPBOARD_BACKUP_FILE" ]]; then
    return 0
  fi
  if ! command -v pbcopy >/dev/null 2>&1; then
    return 0
  fi
  pbcopy < "$CLIPBOARD_BACKUP_FILE" 2>/dev/null || true
  rm -f "$CLIPBOARD_BACKUP_FILE"
  log_debug "clipboard 復元完了"
}

get_clipboard_content() {
  if ! command -v pbpaste >/dev/null 2>&1; then
    log_error "pbpaste 未検出、clipboard 取得不可"
    return 1
  fi
  pbpaste
}

# ============================================================================
# User prompts (with help subcommand)
# 対策: 欠点 1.2 (固定 prompt のみ)
# ============================================================================

# prompt_with_help <question> <help_text> [validation_regex]
# 
# question — user に提示する質問
# help_text — ? 入力時の help
# validation_regex — 入力検証 (optional)
# 
# Returns: stdout に user 入力
prompt_with_help() {
  local question="$1"
  local help_text="${2:-}"
  local regex="${3:-}"
  
  while true; do
    local answer
    if [[ -n "$help_text" ]]; then
      printf '%s\n  (? で help, back で前 step, quit で中断)\n> ' "$question" >&2
    else
      printf '%s\n> ' "$question" >&2
    fi
    read -r answer
    
    case "$answer" in
      "?")
        printf '\n[Help]\n%s\n\n' "$help_text" >&2
        continue
        ;;
      "back")
        echo "__BACK__"
        return 0
        ;;
      "quit"|"exit")
        log_info "user request: 中断"
        echo "__QUIT__"
        return 0
        ;;
      *)
        if [[ -n "$regex" && ! "$answer" =~ $regex ]]; then
          log_warn "入力形式が不正です (expected regex: $regex)"
          continue
        fi
        echo "$answer"
        return 0
        ;;
    esac
  done
}

# prompt_confirm <question> [default]
# 
# Returns: 0 = yes, 1 = no
prompt_confirm() {
  local question="$1"
  local default="${2:-n}"
  local prompt_suffix
  
  if [[ "$default" == "y" ]]; then
    prompt_suffix="(Y/n)"
  else
    prompt_suffix="(y/N)"
  fi
  
  while true; do
    printf '%s %s\n> ' "$question" "$prompt_suffix" >&2
    local answer
    read -r answer
    
    if [[ -z "$answer" ]]; then
      answer="$default"
    fi
    
    case "${answer:l}" in  # zsh の lowercase parameter expansion
      y|yes) return 0 ;;
      n|no)  return 1 ;;
      *)     log_warn "y または n で答えてください" ;;
    esac
  done
}

# ============================================================================
# State JSON 保存 (institutional Stage 3-5 連携用)
# 対策: 欠点 2.2
# ============================================================================

STATE_DIR="${STATE_DIR:-/tmp}"

save_metadata_json() {
  local timestamp
  timestamp=$(date -u +"%Y%m%dT%H%M%SZ")
  local state_file="${STATE_DIR}/verdict_deploy_state_${timestamp}.json"
  
  # Arguments:
  #   $1 — phase ("preflight" | "filing" | "commit" | "push" | "complete")
  #   $2 — commit hash (optional)
  #   $3+ — filed_evaluations (each "NNN:slug:platform:owner:category:framework_version:file_path:size:lines")
  
  local phase="$1"; shift
  local commit_hash="${1:-}"; shift || true
  
  local evaluations_json="[]"
  if [[ $# -gt 0 ]]; then
    local items=()
    for entry in "$@"; do
      IFS=':' read -r nnn slug platform owner category fw_ver path size lines <<< "$entry"
      items+=("$(printf '{
    "nnn": "%s",
    "slug": "%s",
    "platform": "%s",
    "owner": "%s",
    "category": "%s",
    "framework_version": "%s",
    "file_path": "%s",
    "file_size_bytes": %s,
    "line_count": %s,
    "filed_timestamp": "%s"
  }' "$nnn" "$slug" "$platform" "$owner" "$category" "$fw_ver" "$path" "$size" "$lines" "$(date -u +'%Y-%m-%dT%H:%M:%SZ')")")
    done
    evaluations_json="[$(IFS=','; echo "${items[*]}")]"
  fi
  
  cat > "$state_file" << EOF
{
  "session_id": "$(date -u +'%Y-%m-%dT%H:%M:%SZ')",
  "script_version": "1.0",
  "stage": 2,
  "phase": "${phase}",
  "filed_evaluations": ${evaluations_json},
  "commit": {
    "hash": "${commit_hash}",
    "timestamp": "$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  },
  "next_stages": {
    "stage_3_pending": true,
    "stage_4_pending": true,
    "stage_5_pending": true,
    "deploy_status_md_updated": false
  }
}
EOF
  
  log_debug "state file 保存: $state_file"
  echo "$state_file"
}

list_state_files() {
  ls -1t "${STATE_DIR}"/verdict_deploy_state_*.json 2>/dev/null || true
}

# ============================================================================
# Config loader (YAML)
# institutional 簡易 parser (key: value flat structure)
# ============================================================================

CONFIG_FILE="${VERDICT_CONFIG:-$(dirname "${BASH_SOURCE[0]:-$0}")/../verdict_deploy_config.yaml}"

# Returns: stdout に value
get_config() {
  local key="$1"
  local default="${2:-}"
  
  if [[ ! -f "$CONFIG_FILE" ]]; then
    log_debug "config file 不在: $CONFIG_FILE, default 使用"
    echo "$default"
    return 0
  fi
  
  # Simple YAML parser using python3 (institutional に robust)
  if command -v python3 >/dev/null 2>&1; then
    local value
    value=$(python3 -c "
import sys
try:
    import yaml
    with open('${CONFIG_FILE}') as f:
        config = yaml.safe_load(f)
    keys = '${key}'.split('.')
    val = config
    for k in keys:
        val = val[k] if isinstance(val, dict) else None
        if val is None:
            sys.exit(1)
    # Env var expansion
    import os
    if isinstance(val, str):
        val = os.path.expandvars(val)
    print(val)
except Exception as e:
    sys.exit(1)
" 2>/dev/null)
    if [[ -n "$value" ]]; then
      echo "$value"
      return 0
    fi
  fi
  
  echo "$default"
}

# ============================================================================
# Environment validation
# 対策: 欠点 1.3 (shell 環境依存)
# ============================================================================

verify_environment() {
  # zsh version check
  if [[ -z "${ZSH_VERSION:-}" ]]; then
    log_error "本 script は zsh 専用です"
    log_error "現在の shell: ${SHELL}"
    log_info "実行方法: zsh ${BASH_SOURCE[0]:-$0}"
    return 1
  fi
  
  # macOS check (pbpaste/pbcopy 依存のため)
  if [[ "$(uname)" != "Darwin" ]]; then
    log_warn "本 script は macOS で institutional に test 済"
    log_warn "他 OS では pbpaste/pbcopy が機能しない可能性"
  fi
  
  # 必須 command check
  local missing=()
  for cmd in git curl python3 awk sed; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      missing+=("$cmd")
    fi
  done
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    log_error "必須コマンドが見つかりません: ${missing[*]}"
    return 1
  fi
  
  return 0
}

# ============================================================================
# String utilities
# ============================================================================

# Quote string for safe shell expansion
shell_quote() {
  printf '%q' "$1"
}

# Trim whitespace
trim() {
  local var="$*"
  var="${var#"${var%%[![:space:]]*}"}"
  var="${var%"${var##*[![:space:]]}"}"
  echo -n "$var"
}

# ============================================================================
# Network utilities
# ============================================================================

check_network() {
  local url="${1:-https://raw.githubusercontent.com}"
  if curl -sI --connect-timeout 5 --max-time 10 "$url" >/dev/null 2>&1; then
    return 0
  else
    log_error "Network 接続不可: $url"
    return 1
  fi
}

# Returns: HTTP status code or "000" on failure
curl_status() {
  local url="$1"
  curl -sI --max-time 10 "$url" 2>/dev/null | head -1 | awk '{print $2}' || echo "000"
}

# ============================================================================
# Module info
# ============================================================================

UTILS_VERSION="1.0"
UTILS_LOADED=true

log_debug "utils.sh v${UTILS_VERSION} loaded"

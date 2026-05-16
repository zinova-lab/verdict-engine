#!/usr/bin/env zsh
# verdict-engine/scripts/lib/status.sh
# 
# Phase 0.5: Deploy status query module
# 
# institutional 責任:
#   - deploy_status.md を curl で取得
#   - Parse + 整形表示 (Layer 1 / Layer 2 / Scheduled)
# 
# Dependencies: lib/utils.sh

DEPLOY_STATUS_URL="${DEPLOY_STATUS_URL:-https://raw.githubusercontent.com/zinova-lab/verdict-engine/main/docs/deploy_status.md}"

display_deploy_status() {
  log_section "Phase 0.5: Deploy status query"
  log_info "deploy_status.md を取得中..."
  
  local content
  content=$(curl -sL "${DEPLOY_STATUS_URL}?v=$(date +%s)" 2>/dev/null)
  
  if [[ -z "$content" ]]; then
    log_error "deploy_status.md 取得失敗"
    log_info "URL: $DEPLOY_STATUS_URL"
    return 1
  fi
  
  # YAML frontmatter から metadata 抽出 (institutional 簡易 parse)
  local total_deployed last_updated
  total_deployed=$(echo "$content" | sed -n 's/^total_deployed: *\([0-9]*\)/\1/p' | head -1)
  last_updated=$(echo "$content" | sed -n 's/^last_updated: *\(.*\)/\1/p' | head -1)
  
  log_info "deploy_status.md 取得完了"
  log_info "  最終更新: $last_updated"
  log_info "  総 deploy 済み: $total_deployed platform"
  echo ""
  
  # Layer 1 section 抽出
  log_info "[Layer 1] Phase β workflow (完全 metadata):"
  echo "$content" \
    | awk '/^## 1\. Layer 1/,/^## 2\. Layer 2/' \
    | grep -E '^\| [0-9]{3} \|' \
    | head -20
  echo ""
  
  # Layer 2 slug listing
  log_info "[Layer 2] Phase α legacy (slug only, Notion backfill 待ち):"
  echo "$content" \
    | awk '/^### 2\.1 Slug listing/,/^計/' \
    | grep -v '^###' \
    | grep -v '^```' \
    | head -10
  echo "  ... (詳細は GitHub で確認)"
  echo ""
  
  # Scheduled section
  log_info "[Scheduled] 進行中 / 予定:"
  echo "$content" \
    | awk '/^## 3\. Scheduled deploy/,/^## 4/' \
    | grep -E '^\| [0-9]{3} \|' \
    | head -10
  echo ""
  
  log_info "Slug 命名 convention:"
  log_info "  Phase α (legacy): hyphen 優位 (例: guardrails-ai, manus-ai)"
  log_info "  Phase β (current): underscore 優位 (例: guardrails_ai, nemo_guardrails)"
  echo ""
  
  return 0
}

STATUS_VERSION="1.0"
STATUS_LOADED=true
log_debug "status.sh v${STATUS_VERSION} loaded"

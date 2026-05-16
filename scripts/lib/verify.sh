#!/usr/bin/env zsh
# verdict-engine/scripts/lib/verify.sh
# 
# Phase 2.5: CDN live verification module
# 
# institutional 責任:
#   - GitHub raw CDN への propagation 待機
#   - 各 deploy 済 file の HTTP 200 検証
#   - 404 時の retry (institutional safety net)
# 
# Dependencies: lib/utils.sh
# 17 欠点対策: 議題3 #6 (sleep 30 + retry)

CDN_SLEEP_SEC="${CDN_SLEEP_SEC:-30}"
CDN_RETRY_COUNT="${CDN_RETRY_COUNT:-3}"
CDN_RETRY_INTERVAL="${CDN_RETRY_INTERVAL:-10}"

verify_cdn_propagation() {
  log_section "Phase 2.5: CDN live verification"
  
  if [[ "${VERDICT_DRY_RUN:-false}" == "true" ]]; then
    log_info "[DRY-RUN] CDN verification を skip"
    return 0
  fi
  
  log_info "CDN propagation 待機: ${CDN_SLEEP_SEC}s"
  sleep "$CDN_SLEEP_SEC"
  
  local all_verified=true
  typeset -gA VERDICT_VERIFICATION_RESULTS
  VERDICT_VERIFICATION_RESULTS=()
  
  for entry in "${VERDICT_FILED_EVALUATIONS[@]}"; do
    IFS=':' read -r nnn slug rest <<< "$entry"
    local url="https://raw.githubusercontent.com/ZinovaCreation/verdict-platforms/main/evaluations/${nnn}_${slug}.md?v=$(date +%s)"
    
    log_info "Checking: #${nnn} ${slug}"
    log_debug "  URL: $url"
    
    local verified=false
    local last_status=""
    
    for ((retry = 1; retry <= CDN_RETRY_COUNT; retry++)); do
      last_status=$(curl_status "$url")
      log_info "  Attempt $retry: HTTP $last_status"
      
      if [[ "$last_status" == "200" ]]; then
        log_success "  ✓ Live"
        verified=true
        break
      fi
      
      if (( retry < CDN_RETRY_COUNT )); then
        log_info "  retry in ${CDN_RETRY_INTERVAL}s..."
        sleep "$CDN_RETRY_INTERVAL"
      fi
    done
    
    VERDICT_VERIFICATION_RESULTS[$nnn]="$last_status"
    
    if ! $verified; then
      log_error "  ✗ Verification 失敗: HTTP $last_status (3 retries 後も成功せず)"
      all_verified=false
    fi
  done
  
  echo ""
  
  if $all_verified; then
    log_success "全 file が CDN で live 確認完了"
    return 0
  else
    log_error "一部 file が CDN verification 失敗"
    log_warn "  これは institutional に push 後の CDN propagation 遅延の可能性があります"
    log_warn "  数分後に再 verification するか、git log で push 確認してください"
    return 1
  fi
}

VERIFY_VERSION="1.0"
VERIFY_LOADED=true
log_debug "verify.sh v${VERIFY_VERSION} loaded"

#!/usr/bin/env zsh
# verdict-engine/scripts/test/verdict_deploy_test.sh
# 
# Test runner for verdict_deploy.sh v1.0
# 
# institutional 責任:
#   - slug 生成 logic の unit test
#   - content validation の unit test
#   - anomaly detection の mock test
# 
# Usage:
#   ./test/verdict_deploy_test.sh           # Run all tests
#   ./test/verdict_deploy_test.sh slug      # Run slug tests only

set -euo pipefail

SCRIPT_DIR="${0:A:h}"
PROJECT_DIR="${SCRIPT_DIR}/.."
LIB_DIR="${PROJECT_DIR}/lib"
FIXTURES_DIR="${SCRIPT_DIR}/fixtures"

# Load modules
source "${LIB_DIR}/utils.sh" >/dev/null 2>&1
source "${LIB_DIR}/file_creation.sh" >/dev/null 2>&1

# ============================================================================
# Test framework
# ============================================================================

TESTS_PASSED=0
TESTS_FAILED=0

assert_equals() {
  local expected="$1"
  local actual="$2"
  local description="$3"
  
  if [[ "$expected" == "$actual" ]]; then
    TESTS_PASSED=$((TESTS_PASSED + 1))
    printf '\033[32m  ✓\033[0m %s\n' "$description"
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    printf '\033[31m  ✗\033[0m %s\n    expected: %s\n    actual:   %s\n' \
      "$description" "$expected" "$actual"
  fi
}

assert_returns() {
  local expected_code="$1"
  shift
  local description="$1"
  shift
  
  set +e
  "$@" >/dev/null 2>&1
  local actual_code=$?
  set -e
  
  if [[ "$expected_code" == "$actual_code" ]]; then
    TESTS_PASSED=$((TESTS_PASSED + 1))
    printf '\033[32m  ✓\033[0m %s\n' "$description"
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    printf '\033[31m  ✗\033[0m %s (expected: %s, actual: %s)\n' \
      "$description" "$expected_code" "$actual_code"
  fi
}

print_summary() {
  echo ""
  printf '\033[1m=== Test Summary ===\033[0m\n'
  printf '  Passed: \033[32m%d\033[0m\n' "$TESTS_PASSED"
  printf '  Failed: \033[31m%d\033[0m\n' "$TESTS_FAILED"
  
  if [[ "$TESTS_FAILED" -gt 0 ]]; then
    exit 1
  fi
}

# ============================================================================
# Slug generation tests
# ============================================================================

test_slug_generation() {
  printf '\033[1mTest: slug generation\033[0m\n'
  
  assert_equals "weaviate" "$(generate_slug 'Weaviate')" "single word"
  assert_equals "nemo_guardrails" "$(generate_slug 'NeMo Guardrails')" "compound name"
  assert_equals "arize_ai" "$(generate_slug 'Arize AI')" "two words with AI"
  assert_equals "cohere" "$(generate_slug 'Cohere')" "lowercase already"
  assert_equals "openai_assistants" "$(generate_slug 'OpenAI Assistants')" "OpenAI prefix"
  assert_equals "bedrock_agents" "$(generate_slug 'Bedrock Agents')" "Bedrock multi"
  assert_equals "amazon_q_business" "$(generate_slug 'Amazon Q Business')" "single char Q"
  assert_equals "v0" "$(generate_slug 'v0')" "version-like name"
  assert_equals "claude_3" "$(generate_slug 'Claude 3')" "name with digit"
  assert_equals "cohere_north" "$(generate_slug 'Cohere North')" "compound brand"
  
  # Edge cases
  assert_equals "test" "$(generate_slug '  Test  ')" "leading/trailing whitespace"
  assert_equals "ab_cd" "$(generate_slug 'ab__cd')" "consecutive underscores compressed"
  assert_equals "ab_cd" "$(generate_slug 'ab cd!@#')" "special chars stripped"
  assert_equals "ab" "$(generate_slug '_ab_')" "leading/trailing underscores stripped"
  
  echo ""
}

# ============================================================================
# Content validation tests
# ============================================================================

test_content_validation() {
  printf '\033[1mTest: content validation\033[0m\n'
  
  # Empty content
  assert_returns 1 "empty content fails" \
    validate_content ""
  
  # No heading
  local no_heading_content
  no_heading_content=$(printf 'This is just plain text\nwithout any markdown heading\n%.0s' {1..20})
  assert_returns 1 "no markdown heading fails" \
    validate_content "$no_heading_content"
  
  # Too few lines
  assert_returns 1 "too few lines fails" \
    validate_content "# Header only"
  
  # Valid content
  local valid_content
  valid_content="# VERDICT Evaluation: Test Platform

## Score: 50/85

## V — Verifiability (10/20)
Some content here...

## R — Resilience (10/20)
$(printf 'Resilience content line %d\n' {1..40})

## End"
  
  assert_returns 0 "valid markdown passes" \
    validate_content "$valid_content"
  
  echo ""
}

# ============================================================================
# Trim utility test
# ============================================================================

test_trim() {
  printf '\033[1mTest: trim utility\033[0m\n'
  
  assert_equals "hello" "$(trim '  hello  ')" "trim leading/trailing spaces"
  assert_equals "hello world" "$(trim '  hello world  ')" "preserve internal spaces"
  assert_equals "" "$(trim '   ')" "all whitespace becomes empty"
  assert_equals "x" "$(trim 'x')" "no whitespace unchanged"
  
  echo ""
}

# ============================================================================
# Main
# ============================================================================

main() {
  local filter="${1:-all}"
  
  printf '\033[1m=== VERDICT Deploy Script Test Suite v1.0 ===\033[0m\n\n'
  
  case "$filter" in
    all)
      test_slug_generation
      test_content_validation
      test_trim
      ;;
    slug)
      test_slug_generation
      ;;
    validation)
      test_content_validation
      ;;
    trim)
      test_trim
      ;;
    *)
      echo "Unknown test filter: $filter"
      echo "Available: all, slug, validation, trim"
      exit 1
      ;;
  esac
  
  print_summary
}

main "$@"

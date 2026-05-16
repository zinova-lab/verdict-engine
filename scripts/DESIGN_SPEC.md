# verdict_deploy.sh v1.0 — Institutional Design Specification

**Status**: Design specification, pre-implementation
**Date**: 2026-05-15
**Author**: VERDICT Operations
**Target deployment**: `verdict-engine/scripts/`

---

## 1. Purpose

`verdict_deploy.sh` は VERDICT 評価プロジェクトの Stage 2 deploy (Engine 評価出力 markdown を `verdict-platforms/evaluations/` に commit & push) を institutional に自動化する shell script。

claude.ai worktree helper v3 template の institutional logic を保持しつつ、LLM 依存を排除して reproducibility / cost / robustness を institutional に向上させる。

## 2. 17 欠点対策 mapping

| Layer | # | 欠点 | 対策 location |
|-------|---|------|--------------|
| 1 | 1.1 | 異常診断の表現力 limited | `lib/preflight.sh` の dispatch table |
| 1 | 1.2 | 固定 prompt のみ | `lib/utils.sh` の `prompt_with_help` + `?` subcommand |
| 1 | 1.3 | Shell 環境依存 | shebang `#!/usr/bin/env zsh` + version check |
| 1 | 1.4 | 多行 content 貼付 UX | `lib/file_creation.sh` の pbpaste 経由 |
| 1 | 1.5 | Commit message UX | `lib/commit_push.sh` の template ベース生成 |
| 2 | 2.1 | deploy_status.md 自動更新 | `helpers/update_deploy_status.py` |
| 2 | 2.2 | Stage 3-5 連携 | `lib/utils.sh` の `save_metadata_json` |
| 2 | 2.3 | Script の location | `verdict-engine/scripts/` + env var |
| 3 | 3.1 | Bug 時の復旧 | dry-run mode + state file |
| 3 | 3.2 | 改修時 regression | `test/verdict_deploy_test.sh` |
| 3 | 3.3 | 副パートナー onboarding | `README.md` + `--setup` wizard |
| 4 | 4.1 | Clipboard risk | pre-session backup + cleanup trap |
| 4 | 4.2 | Notion export 揺れ | content validation function |
| 4 | 4.3 | 並行 session 衝突 | lock file (`/tmp/verdict_deploy.lock`) |
| 4 | 4.4 | Security | `printf %q` quoting + no eval |
| 5 | 5.1 | Workflow 進化 | modular 分割 + config 外部化 |
| 5 | 5.2 | 知識移転 | 日本語 comment + README |

## 3. File structure

```
verdict-engine/scripts/
├── README.md                              # institutional onboarding doc
├── verdict_deploy.sh                      # main entry point
├── verdict_deploy_config.yaml.example     # config template
├── lib/
│   ├── preflight.sh                       # Phase 0 異常診断 (7 anomaly types)
│   ├── status.sh                          # Phase 0.5 deploy status query
│   ├── file_creation.sh                   # Phase 1 sequential file 化
│   ├── commit_push.sh                     # Phase 2 stage / commit / push
│   ├── verify.sh                          # CDN live verification with retry
│   └── utils.sh                           # 共通 utility (logging, prompts, lock)
├── test/
│   ├── verdict_deploy_test.sh             # test runner
│   ├── test_preflight.sh                  # preflight unit tests
│   ├── test_file_creation.sh              # file creation unit tests
│   ├── test_slug_generation.sh            # slug generation unit tests
│   └── fixtures/
│       ├── mock_evaluation_clean.md       # 正常 evaluation sample
│       ├── mock_evaluation_truncated.md   # 異常 sample (validation test 用)
│       └── setup_mock_repo.sh             # mock git repo 生成
└── helpers/
    └── update_deploy_status.py            # deploy_status.md 自動更新
```

## 4. Configuration

`verdict_deploy_config.yaml`:

```yaml
paths:
  verdict_home: $HOME/Desktop/VERDICT
  platforms_repo: $VERDICT_HOME/verdict-platforms
  engine_repo: $VERDICT_HOME/verdict-engine

git:
  default_branch: main
  expected_remote_platforms: https://github.com/ZinovaCreation/verdict-platforms.git
  expected_remote_engine: https://github.com/zinova-lab/verdict-engine.git
  identity: zinova-lab

deploy:
  evaluations_dir: evaluations
  sleep_before_verify: 30
  cdn_retry_count: 3
  cdn_retry_interval: 10
  lock_file: /tmp/verdict_deploy.lock
  state_dir: /tmp

slug_convention:
  case: lower
  separator: underscore     # Phase β convention
  legacy_separator: hyphen  # Phase α legacy (read-only check)
  invalid_chars_strip: true

deploy_status:
  raw_url: https://raw.githubusercontent.com/zinova-lab/verdict-engine/main/docs/deploy_status.md
  local_path: $ENGINE_REPO/docs/deploy_status.md

institutional:
  framework_version: v1.1
  workflow_version: path_beta
  schema_version: 1.0
```

Environment variables (override config):

- `VERDICT_HOME` — repo group root (default `$HOME/Desktop/VERDICT`)
- `VERDICT_CONFIG` — config file path (default `$(dirname $0)/verdict_deploy_config.yaml`)
- `VERDICT_DRY_RUN` — `true` で dry-run mode
- `VERDICT_DEBUG` — `true` で verbose logging

## 5. Command-line interface

```
./verdict_deploy.sh                       # interactive deploy
./verdict_deploy.sh --dry-run             # simulation only
./verdict_deploy.sh --status              # deploy status query (Phase 0.5 only)
./verdict_deploy.sh --setup               # initial environment setup wizard
./verdict_deploy.sh --resume              # restore previous session state
./verdict_deploy.sh --update-status       # deploy_status.md 更新のみ
./verdict_deploy.sh --help                # usage display
./verdict_deploy.sh --version             # version
```

## 6. Workflow

```
[Entry]
  └─> argument parsing (case statement)

[Setup mode] (--setup)
  └─> env var prompt / config file generation / git config check

[Deploy mode] (default)
  ├─> acquire_lock() — concurrent execution prevention
  ├─> backup_clipboard() — pre-session state save
  │
  ├─> [Phase 0: Preflight] (lib/preflight.sh)
  │    ├─> verify_repo_path()
  │    ├─> verify_remote_url()
  │    ├─> verify_branch()
  │    ├─> diagnose_git_state() — 7 anomaly type dispatch
  │    │     ├─> handle_path_not_found
  │    │     ├─> handle_wrong_remote
  │    │     ├─> handle_wrong_branch
  │    │     ├─> handle_ahead_of_origin
  │    │     ├─> handle_behind_origin
  │    │     ├─> handle_uncommitted
  │    │     └─> handle_untracked_evaluations
  │    └─> return "clean" or recovery loop
  │
  ├─> check_resume() — previous state file 検出 + prompt
  │
  ├─> [Phase 1: Sequential filing] (lib/file_creation.sh)
  │    loop:
  │      ├─> prompt_evaluation_number() — "status" / "done" subcommand 対応
  │      ├─> prompt_platform_name()
  │      ├─> generate_slug()
  │      ├─> check_slug_existence() — curl で remote 確認
  │      ├─> request_clipboard_paste()
  │      ├─> validate_content() — markdown structure check
  │      ├─> preview_content()
  │      ├─> confirm_or_redo()
  │      ├─> write_evaluation_file()
  │      └─> verify_file_written()
  │
  ├─> [Phase 2: Commit & Push] (lib/commit_push.sh)
  │    ├─> pre_commit_check() — git status --short 検証
  │    ├─> collect_metadata() — platform/owner/category 入力
  │    ├─> stage_files()
  │    ├─> review_staged() — git diff --cached --stat
  │    ├─> confirm_commit()
  │    ├─> generate_commit_message() — template ベース
  │    ├─> execute_commit()
  │    └─> push_to_remote()
  │
  ├─> [Phase 2.5: CDN Verification] (lib/verify.sh)
  │    └─> verify_cdn_propagation() — sleep 30 + retry up to 3
  │
  ├─> [Phase 2.6: deploy_status.md update] (optional)
  │    └─> python3 helpers/update_deploy_status.py
  │
  ├─> save_state_json() — Stage 3-5 用 metadata 出力
  ├─> release_lock()
  └─> [Summary]
```

## 7. Module interfaces

### 7.1 lib/preflight.sh

```bash
# Returns: stdout に "clean" or anomaly type
diagnose_git_state() {
  # ...
}

# Per-anomaly handlers
handle_path_not_found() { ... }
handle_wrong_remote() { ... }
handle_wrong_branch() { ... }
handle_ahead_of_origin() { ... }
handle_behind_origin() { ... }
handle_uncommitted() { ... }
handle_untracked_evaluations() { ... }
```

### 7.2 lib/status.sh

```bash
# deploy_status.md を curl で取得して整形表示
display_deploy_status() {
  # ...
}
```

### 7.3 lib/file_creation.sh

```bash
# Returns: stdout に generated slug
generate_slug() {
  local platform_name="$1"
  # lowercase → space to underscore → invalid char strip → consecutive _ compress
}

# Returns: 0 = OK to create, 1 = exists, 2 = legacy exists
check_slug_existence() {
  local nnn="$1"
  local slug="$2"
}

# Returns: 0 = valid, 1 = invalid
validate_content() {
  local content="$1"
  # 最低限 markdown structure check
}

# Write evaluation file with content (single quoted heredoc equivalent)
write_evaluation_file() {
  local target_path="$1"
  local content="$2"
}
```

### 7.4 lib/commit_push.sh

```bash
# Returns: temp file path containing commit message
generate_commit_message() {
  local -a filed_evaluations=("$@")
  # template + metadata から生成
}

execute_commit_push() {
  local message_file="$1"
}
```

### 7.5 lib/verify.sh

```bash
# Returns: 0 = all verified, 1 = some failed
verify_cdn_propagation() {
  local -a filed_evaluations=("$@")
  local sleep_sec="${CDN_SLEEP:-30}"
  local retry="${CDN_RETRY:-3}"
}
```

### 7.6 lib/utils.sh

```bash
# Common logging
log_info()  { echo "[INFO]  $*" >&2; }
log_warn()  { echo "[WARN]  $*" >&2; }
log_error() { echo "[ERROR] $*" >&2; }

# Lock management
acquire_lock() { ... }
release_lock() { ... }

# Clipboard management
backup_clipboard() { ... }
restore_clipboard() { ... }

# Prompt with help
prompt_with_help() {
  local question="$1"
  local help_text="$2"
}

# State save (Stage 3-5 連携用)
save_metadata_json() {
  local -a filed_evaluations=("$@")
}

# Config loader (YAML)
load_config() {
  # Simple YAML parser (key: value flat) or python wrapper
}
```

## 8. State file schema

`/tmp/verdict_deploy_state_<timestamp>.json`:

```json
{
  "session_id": "2026-05-15T23:30:00Z",
  "script_version": "1.0",
  "stage": 2,
  "phase": "complete",
  "filed_evaluations": [
    {
      "nnn": "065",
      "slug": "weaviate",
      "platform": "Weaviate",
      "owner": "Weaviate B.V.",
      "category": "Vector Database",
      "framework_version": "v1.1",
      "file_path": "evaluations/065_weaviate.md",
      "file_size_bytes": 12345,
      "line_count": 250,
      "filed_timestamp": "2026-05-15T23:31:15Z"
    }
  ],
  "commit": {
    "hash": "abc1234",
    "message_excerpt": "Add evaluations #065 Weaviate, ...",
    "timestamp": "2026-05-15T23:33:00Z"
  },
  "push": {
    "remote": "origin",
    "branch": "main",
    "timestamp": "2026-05-15T23:33:45Z"
  },
  "verification": {
    "cdn_sleep_sec": 30,
    "results": [
      {"url": "https://raw.githubusercontent.com/.../065_weaviate.md", "status": "HTTP/2 200", "attempts": 1},
      ...
    ],
    "all_verified": true
  },
  "next_stages": {
    "stage_3_pending": true,
    "stage_4_pending": true,
    "stage_5_pending": true,
    "deploy_status_md_updated": false
  }
}
```

## 9. Slug generation rules

```
入力: "NeMo Guardrails"
処理:
  1. lowercase   → "nemo guardrails"
  2. space → _   → "nemo_guardrails"
  3. 不正文字除去 → "nemo_guardrails"  (a-z, 0-9, _, - のみ保持)
  4. _ 連続圧縮  → "nemo_guardrails"
出力: "nemo_guardrails"

入力: "Cohere v2"
出力: "cohere_v2"

入力: "Bedrock Agents"
出力: "bedrock_agents"

入力: "OpenAI Assistants"
出力: "openai_assistants"
```

Phase α legacy slug は hyphen 区切り (例: `bedrock-agents`)。Script は Phase β underscore を default、ただし check_slug_existence で hyphen 版も curl 確認。

## 10. Content validation rules

```
Validation criteria:
  1. 非空 (length > 0)
  2. 最初の 1KB に "# " heading が 1 つ以上存在
  3. 行数が 30-2000 行範囲
  4. 改行コードが LF (CRLF 検出時は警告 + 続行 / 中断選択)
  5. UTF-8 valid encoding
```

Validation 失敗時の挙動:
- Validation level "warn" → 警告 + 続行確認
- Validation level "block" → 強制中断

Default: warn (institutional flexibility 重視)

## 11. Security considerations

```
✓ User input は printf %q または quote で escape
✓ eval, exec 不使用
✓ Notion content は heredoc 経由でのみ file 化 (shell 解釈不可)
✓ Lock file pid を kill -0 で institutional に検証 (stale lock 検出)
✓ Network request は curl で institutional に restricted (no shell expansion)
✓ Git operations は full path command で institutional に explicit
```

## 12. Testing strategy

```
Unit tests (test/test_*.sh):
  - generate_slug: 10+ test cases (single word / compound / unicode 等)
  - validate_content: 5+ cases (clean / truncated / non-markdown / CRLF / empty)
  - diagnose_git_state: mock repo で 7 anomaly type 各々 simulate

Integration tests:
  - test/fixtures/setup_mock_repo.sh で institutional 隔離環境構築
  - dry-run mode で full workflow simulate
  - 実 push は CI でのみ実行 (本 institutional script は local manual test)

Regression tests:
  - 過去 deploy precedent (#062-#064 commit 556401f) の commit message 形式 
    と institutional 整合性 verify
```

## 13. README outline

```markdown
# VERDICT Operations Deploy Script

## What this script does
## Prerequisites
## Initial setup
## Daily usage
## Architecture (file structure)
## 17 institutional safety nets
## Troubleshooting
## Versioning policy
```

## 14. Versioning

```
v1.0 — Initial release (本仕様、Stage 2 deploy 完全自動化)
v1.x — Bug fix / minor enhancement
v2.0 — Stage 3-5 統合 (canonical .md / override log / HTML deploy)
v3.0 — VERDICT framework v1.2 / Phase γ workflow 対応
```

## 15. Out of scope

本 v1.0 では institutional に実装しない:

- Stage 3 (canonical platforms/<slug>.md 生成)
- Stage 4 (operations_override_log.md append)
- Stage 5 (HTML page deploy)
- Notion API 連携 (clipboard 経由を維持)
- Web UI / GUI
- Multi-user / remote execution
- Cloud-based scheduling

これらは将来 institutional iteration の対象。

---

# END OF SPECIFICATION

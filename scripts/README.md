# VERDICT Operations Deploy Script

`verdict_deploy.sh` は VERDICT 評価プロジェクトの Stage 2 deploy を institutional に自動化する shell script です。

claude.ai worktree helper v3 template の institutional logic を保持しつつ、LLM 依存を排除して **reproducibility / cost / robustness** を institutional に向上させた v1.0 リリースです。

---

## 1. What this script does

```
[ Phase 0 ]  Pre-flight verification (7 anomaly types decision tree)
     ↓
[ Phase 0.5 ] (任意) deploy_status.md curl で deploy 状況確認
     ↓
[ Phase 1 ]  Sequential evaluation filing
              - 評価番号入力
              - Platform 名 + slug 自動生成
              - 既存 file check
              - clipboard 経由 content 取得
              - Validation + preview
              - File write (atomic)
     ↓
[ Phase 2 ]  Stage / Commit / Push
              - Pre-commit verification
              - Metadata 収集
              - git add + diff --cached --stat
              - Commit message 自動生成 (template ベース)
              - git commit + push
     ↓
[ Phase 2.5 ] CDN live verification (sleep 30 + retry 3)
```

## 2. Prerequisites

- **OS**: macOS (zsh + pbpaste/pbcopy 依存)
- **Shell**: zsh 5.x+
- **Tools**: git, curl, python3, awk, sed
- **Repos**: `verdict-platforms` を local clone 済 (default path: `$HOME/Desktop/VERDICT/verdict-platforms`)

## 3. Initial setup

```bash
cd ~/Desktop/VERDICT/verdict-engine/scripts
chmod +x verdict_deploy.sh
./verdict_deploy.sh --setup
```

Setup wizard が以下を case しながら案内します:

1. VERDICT_HOME 設定
2. Repository 存在確認 (必要なら clone)
3. Git config 確認 (user.name / user.email)
4. Network 接続確認

### 環境変数 (institutional 永続設定)

`~/.zshrc` に以下を追加 (institutional 推奨):

```bash
export VERDICT_HOME="$HOME/Desktop/VERDICT"
# 他 path に置く場合は適宜変更
```

## 4. Daily usage

### 通常の deploy

```bash
cd ~/Desktop/VERDICT/verdict-engine/scripts
./verdict_deploy.sh
```

Script の指示に従って:
1. 評価番号を入力 (例: `065`)
2. Platform 名を入力 (例: `Weaviate`)
3. 提案 slug 確認 (例: `weaviate` → `y`)
4. 既存 check 結果を確認
5. Notion から評価 markdown を clipboard にコピー
6. Enter を押して clipboard から読み取り
7. Preview 確認 → `y`
8. 別評価を続行 → `y` → 番号入力 (繰り返し)
9. 全評価完了 → 別評価続行 → `n`
10. Metadata 入力 (clipboard 貼付可)
11. Stage / commit / push 確認 → `y`
12. CDN verification 完了

### Dry-run (試運転)

```bash
./verdict_deploy.sh --dry-run
```

Commit / push を実行せず、workflow の流れと metadata 検証のみ。institutional に最初は dry-run で flow 確認推奨。

### Status query のみ

```bash
./verdict_deploy.sh --status
```

deploy_status.md を curl で取得して整形表示。Layer 1 / Layer 2 / Scheduled の確認。

### Help

```bash
./verdict_deploy.sh --help
./verdict_deploy.sh --version
```

## 5. Architecture

```
verdict-engine/scripts/
├── README.md                              ← この document
├── verdict_deploy.sh                      ← main entry point
├── verdict_deploy_config.yaml.example     ← config template
├── lib/
│   ├── utils.sh                           ← 共通 utility (lock, clipboard, logging)
│   ├── preflight.sh                       ← Phase 0 (7 anomaly handlers)
│   ├── status.sh                          ← Phase 0.5 (deploy_status.md query)
│   ├── file_creation.sh                   ← Phase 1 (slug, validation, write)
│   ├── commit_push.sh                     ← Phase 2 (stage, commit, push)
│   └── verify.sh                          ← Phase 2.5 (CDN verification)
├── test/
│   ├── verdict_deploy_test.sh             ← test runner
│   ├── test_slug_generation.sh            ← slug 生成 unit test
│   └── fixtures/
│       └── mock_evaluation_clean.md       ← test fixture
└── helpers/
    └── update_deploy_status.py            ← deploy_status.md 自動更新 (Python)
```

## 6. 17 institutional safety nets

| # | 対策 | 実装 location |
|---|------|--------------|
| 1.1 | 異常診断 dispatch table | preflight.sh `diagnose_repo_state` |
| 1.2 | `?` で help, `back` で前 step | utils.sh `prompt_with_help` |
| 1.3 | zsh version check | utils.sh `verify_environment` |
| 1.4 | pbpaste 経由 content | file_creation.sh |
| 1.5 | Commit message template | commit_push.sh `generate_commit_message` |
| 2.1 | deploy_status.md 更新 | helpers/update_deploy_status.py |
| 2.2 | Stage 3-5 metadata JSON | utils.sh `save_metadata_json` |
| 2.3 | Env var で path 外部化 | verdict_deploy.sh |
| 3.1 | Dry-run + state file | verdict_deploy.sh `--dry-run` |
| 3.2 | Test script | test/verdict_deploy_test.sh |
| 3.3 | Setup wizard | verdict_deploy.sh `--setup` |
| 4.1 | Clipboard backup + restore | utils.sh `backup_clipboard` |
| 4.2 | Content validation | file_creation.sh `validate_content` |
| 4.3 | Lock file | utils.sh `acquire_lock` |
| 4.4 | Quote / no eval | 全 modules で institutional 適用 |
| 5.1 | Modular 分割 + config | 本 architecture |
| 5.2 | 日本語 comment + README | 本 document |

## 7. Troubleshooting

### Phase 0 で `wrong_remote` 異常検知

```
✗ remote URL が想定と異なります
  観測: <actual>
  期待: https://github.com/ZinovaCreation/verdict-platforms.git
```

→ 別 fork を指している可能性。Script が institutional に確認して修正提案します。

### Phase 0 で `path_not_found` 検知

→ Setup wizard で path 設定、または `~/.zshrc` で `VERDICT_HOME` 環境変数を institutional 設定。

### Phase 1 で content validation 警告

```
[WARN] Content validation で問題検出:
  - 先頭 1KB に markdown heading (# ) が見つかりません
```

→ Notion → Copy as Markdown が institutional 推奨。普通の copy では rich text 混入の risk。

### Phase 2.5 で CDN verification 失敗

```
[ERROR] ✗ Verification 失敗: HTTP 404 (3 retries 後も成功せず)
```

→ Push は完了している可能性が高い。`git log --oneline -1` で確認、数分後に再 verification。GitHub CDN の institutional propagation 遅延の可能性。

### Lock file が残留

```
[ERROR] 既に script (PID xxxx) が実行中
```

→ 前 session が abnormal 終了した可能性。`kill -0 PID` で existence 確認、不在なら自動削除。それでも残留する場合: `rm /tmp/verdict_deploy.lock`

## 8. Versioning policy

- **v1.0** (現在) — Stage 2 deploy 完全自動化
- **v1.x** — Bug fix / minor enhancement
- **v2.0** — Stage 3-5 統合 (canonical .md / override log / HTML deploy)
- **v3.0** — VERDICT framework 進化対応

## 9. Out of scope (v1.0)

本 v1.0 では institutional に実装しない:

- Stage 3 (canonical platforms/<slug>.md 生成)
- Stage 4 (operations_override_log.md append)
- Stage 5 (HTML page deploy)
- Notion API 連携 (clipboard 経由を v1.0 では維持)
- Web UI / GUI

これらは将来 institutional iteration の対象。

## 10. institutional history

- 2026-05-15: v1.0 initial release
  - 元設計: claude.ai worktree helper v3 template
  - 翻訳: shell script (zsh) で institutional reproducibility
  - 17 欠点対策完全実装

## 11. Related institutional artifacts

- `verdict-engine/ENGINE.md` — VERDICT framework v0.3.1 + v1.1
- `verdict-engine/KNOWN_FACTS.md` — Anthropic Equity-Holder Records
- `verdict-engine/QA.md` — Engine output QA discipline
- `verdict-engine/docs/deploy_status.md` — Deploy 済 platform canonical record
- `verdict-engine/docs/operations_workflow_v2.md` — Path β workflow definition
- `verdict-platforms/evaluations/` — Stage 2 deploy 対象

---

# END OF README

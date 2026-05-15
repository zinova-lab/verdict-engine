---
schema_version: 1.0
artifact: deploy_status
canonical_path: docs/deploy_status.md
last_updated: 2026-05-15
last_updated_commit: pending
total_deployed: 63
layer_1_count: 6
layer_2_count: 57
layer_1_scope: "Path β workflow (verdict-platforms/evaluations/ + verdict-index/)"
layer_2_scope: "Phase α legacy (verdict-index/ only, source markdown is Notion canonical)"
backfill_status:
  layer_1: complete
  layer_2: pending_backfill_from_notion_canonical
related_artifacts:
  - ENGINE.md (framework v1.0/v1.1)
  - KNOWN_FACTS.md (Anthropic equity-holder records)
  - docs/operations_override_log.md
  - docs/operations_workflow_v2.md (Path β workflow definition)
---

# VERDICT Deploy Status

このファイルは VERDICT 評価プロジェクトの **deploy 済み platform** institutional canonical record です。`Notion canonical worklog` のサブセット (公開可能な deploy 事実のみ) で、machine-readable な参照を目的とします。

**最終更新**: 2026-05-15
**Schema version**: 1.0

このファイルは VERDICT の以下 deploy workflow に基づきます:

- **Phase α (legacy)** — HTML page のみ `verdict-index/` に deploy。source markdown は Notion canonical 内で完結 (git repo 未配置)。#017-#058 が該当。
- **Phase β (current)** — Engine output markdown を `verdict-platforms/evaluations/` に commit、その後 HTML を `verdict-index/` に deploy。`operations_workflow_v2.md` Section 4.2 で institutional に定義。#059 以降が該当。

## 1. Layer 1: Phase β workflow deploy 済み (#059-)

`verdict-platforms/evaluations/NNN_<slug>.md` に source markdown が存在する deploy。完全 metadata を保持。

| # | Slug | Platform | Owner | Category | Score | Tier | Deploy Date | 備考 |
|---|------|----------|-------|----------|-------|------|-------------|------|
| 059 | `e2b` | E2B | E2B, Inc. | Code Execution Sandbox | 46 | B | 2026-04 | Operations override applied |
| 060 | `langfuse` | Langfuse | Langfuse GmbH | LLM Observability | 62 | A | 2026-04 | ClickHouse acquisition + Anthropic indirect commercial relationship (framework v1.0) |
| 061 | `mistral_la_plateforme` | Mistral La Plateforme | Mistral AI | Foundation Model API | 55 | A | 2026-04 | Operations override (55-64 = A band per rankings convention); Koyeb acquisition (2026-02-17) |
| 062 | `langsmith` | LangSmith | LangChain Inc. | LLM Observability | TBD | TBD | 2026-04 | Path β workflow batch (#062-#064) commit 556401f |
| 063 | `pinecone` | Pinecone | Pinecone Systems, Inc. | Vector Database | TBD | TBD | 2026-04 | Path β workflow batch |
| 064 | `guardrails_ai` | Guardrails AI | Guardrails AI, Inc. | AI Safety / Validation | TBD | TBD | 2026-04 | Path β workflow batch; institutional learning: customer reference verification |

**注**: Score/Tier `TBD` の項目は次回 metadata backfill session で `docs/operations_override_log.md` から確証し更新予定。

## 2. Layer 2: Phase α legacy deploy 済み (#017-#058)

`verdict-index/<slug>/` に HTML page のみ deploy。source markdown は Notion canonical 内のみ。NNN-slug 対応は Notion worklog v5 が canonical。

### 2.1 Slug listing (alphabetical, verdict-index/ direct listing から確証 2026-05-15)

```
activepieces, ag2, agentforce, aider, amazon-q-business, autogen, autogpt,
babyagi, bedrock-agents, bolt-new, botpress, browser-use, browserbase,
camel-ai, cline, composio, copilot-studio, coze, crewai, cursor, devin,
dify, dust, flowise, gemini-code-assist, github-copilot, guardrails-ai,
haystack, langchain, langflow, langgraph, langroid, letta, llamaindex,
lovable, make, manus-ai, metagpt, n8n, openai-assistants, openhands,
phidata, pipedream, relevance-ai, replit, rivet, runner-h, semantic-kernel,
skyvern, stagehand, superagent, superagi, v0, vertex-ai, voiceflow,
watsonx-orchestrate, windsurf, wordware, zapier
```

計 57 件 (verdict-index 全 platform 直下 63 - Layer 1 重複 6 = 57)。

**注**: `guardrails-ai` (verdict-index, hyphen) と `guardrails_ai` (verdict-platforms/evaluations, underscore) は同一 platform (#064) の institutional slug 揺れ。Phase β workflow 移行以前の legacy convention 反映。

### 2.2 Slug 命名の institutional convention 揺れ

| Phase | Convention | 例 |
|-------|-----------|-----|
| Phase α (verdict-index legacy) | hyphen 優位 | `amazon-q-business`, `manus-ai`, `mistral-la-plateforme` |
| Phase β (verdict-platforms/evaluations/) | underscore 優位 | `mistral_la_plateforme`, `guardrails_ai`, `nemo_guardrails` |

新規 deploy では Phase β convention (underscore) を採用、Phase α legacy slug は institutional 互換性のため hyphen を保持。

### 2.3 Metadata backfill 状態

#017-#058 の以下 metadata は本 v0.1 では空欄、Notion canonical worklog v5 からの backfill 待ち:

- 評価番号 (#NNN) と slug の対応
- Platform 正式名 / Owner 法人
- Category 分類
- Score / Tier
- Deploy date
- Framework version (v1.0 / v1.1 / pre-v1.0) at evaluation

backfill 完了時に Layer 2 section を Layer 1 と同形式の table に statement upgrade します。

## 3. Scheduled deploy section (current Operations session)

本 Operations session (2026-05-15) で deploy 予定の評価。Stage 2 commit & push 完了時に Layer 1 main table に統合します。

| # | Slug | Platform | Owner | Category | Framework version | Special Considerations |
|---|------|----------|-------|----------|-------------------|------------------------|
| 065 | `weaviate` | Weaviate | Weaviate B.V. | Vector Database | v1.0 | — |
| 066 | `nemo_guardrails` | NeMo Guardrails | NVIDIA Corporation | AI Safety / LLM Guardrails | v1.1 | Trigger 1 (NVIDIA parent) |
| 067 | `zep` | Zep | Zep AI, Inc. | Agent Memory Layer / Temporal Knowledge Graph | v1.0 | — |
| 068 | `arize_ai` | Arize AI | Arize AI, Inc. | LLM Observability / AI Evaluation | v1.1 | Trigger 2 + 3 (Microsoft compound, Strategy Brief #3 first additive case) |
| 069 | `cohere` | Cohere | Cohere Inc. | Foundation Model + Agent Platform | v1.1 | Trigger 2 + 3 (NVIDIA compound, Brief #3 §A3 criteria second application) |

### 3.1 Engine output 評価結果 (pending Operations Override 判定)

Score / Tier は engine 評価完了後、本 Operations session で受領 → Operations Override 判定 → Stage 2 deploy → 本ファイル更新 という institutional sequencing で確定。

## 4. Framework version 適用境界

| Framework version | 適用範囲 | 確立 commit |
|-------------------|---------|-------------|
| pre-v1.0 | #017-#058 (Phase α legacy) | — |
| v1.0 | #059-#065, #067 | initial ENGINE.md |
| v1.1 | #066, #068-#069 以降 | ENGINE.md commit 9f4ad25 (2026-05-14) |

framework v1.1 は forward-only versioning 原則 (Strategy Brief #1) で過去評価は再 disclosure せず。Layer 2 全件は pre-v1.0 として institutional に固定。

## 5. Related institutional artifacts

- `ENGINE.md` — VERDICT framework v0.3.1 + v1.1 amendment (Strategy Briefs #1-#3 反映)
- `KNOWN_FACTS.md` — Anthropic Equity-Holder Records (NVIDIA $10B / Microsoft $5B 2025-11-18)
- `QA.md` — Engine output QA discipline
- `docs/operations_override_log.md` — Operations Override 監査ログ (Score/Tier 確定後 backfill)
- `docs/operations_workflow_v2.md` — Path β workflow definition (Section 4.2)
- `docs/operations_session_sop.md` — Operations Session SOP

## 6. Update mechanism

### 現時点 (v0.1): 手動更新

本 Operations session の Stage 2 commit 完了時に、本ファイルを手動更新 → commit & push。

更新内容:
1. Section 3 (Scheduled deploy) の該当行を削除
2. Section 1 (Layer 1) に該当行を追加 (full metadata)
3. YAML frontmatter `last_updated` と `total_deployed` を更新
4. YAML frontmatter `last_updated_commit` を Stage 2 commit hash に更新

### 将来 (v0.2+): 自動更新

Stage 2 worktree helper v3+ に deploy_status.md 自動更新 step を統合。手動更新フェーズの institutional 経験を蓄積後、自動化判断。

### Backfill 完了時 (Layer 2): v1.0 release

Notion canonical worklog v5 から #017-#058 の完全 metadata を抽出完了時に Layer 2 を Layer 1 形式の table に statement upgrade、`schema_version: 2.0` へ。

---

# END OF deploy_status.md v0.1

# VERDICT Operations Workflow v2 — Design Document

> **Purpose.** Codify a context-volume sustainable operations workflow for the
> 100-platform VERDICT roadmap. The current workflow (evaluation → Notion save →
> claude.ai paste → operations process → deploy) faces a hot-spot in the third
> step where Tatsuya pastes large state files (top index.html ~200 KB,
> rankings/index.html ~50 KB, individual platform templates ~30 KB) into every
> operations session. At 61/100 platforms this is operational, but the trajectory
> at 80–100 platforms requires institutional architecture revision before context
> burn becomes an institutional bottleneck.
>
> **Status.** Design document. Not a binding commitment. Pilot proposed for 062
> batch. Final architecture review to be conducted in Strategy Project after
> 062–065 pilot data is collected.
>
> **Created.** 2026-04-29 by Operations session (continuation of 059–061 batch
> deploy session).
>
> **Cross-references.**
> - `worklog_v4.md` operations learnings 2026-04-29 (8 learnings, 3 reusable scripts)
> - `verdict-platforms/evaluations/` directory (1st institutional precedent for
>   engine output verbatim externalization, established 2026-04-29)
> - `ENGINE.md` Tier Letter Assignment (2026-04-29 codification)
> - `QA.md` Operations Override Rules (2026-04-29 codification)

---

## 1. Current Workflow — Context Volume Analysis

### 1.1 Workflow stages

```
Stage 1: Evaluation (claude.ai engine session)
  Input:  evaluation prompt (~5 KB) + manual research (web fetch)
  Output: engine output Block 1 (English) + Block 2 (Japanese summary), ~20 KB
  Storage: Tatsuya saves to Notion working copy

Stage 2: Tatsuya hand-off
  Tatsuya copies evaluation content from Notion to operations session

Stage 3: Operations processing (claude.ai operations session)
  Input:  evaluation content (~20 KB)
        + top index.html (~200 KB)         ← HOT SPOT
        + rankings/index.html (~50 KB)
        + individual platform template (~30 KB)
        + cumulative session memory of past evaluations
  Operations: Tier override application, QA review,
              Special Considerations evaluation, deploy artifact generation
  Output: 11 deploy artifacts (~500 KB total across files)

Stage 4: Deploy
  Tatsuya runs deploy script locally → git commit + push
```

### 1.2 Context burn per session (current state)

| Source | Volume | Cumulative @ 100 platforms |
|--------|--------|----------------------------|
| Engine output (Block 1 + Block 2) | ~20 KB | 100 × 20 = 2 MB total (one-time per platform) |
| top index.html | ~200 KB | 200 KB × N sessions (recurring) |
| rankings/index.html | ~50 KB | 50 KB × N sessions (recurring) |
| Platform template | ~30 KB | 30 KB × N sessions (recurring) |
| EXISTING_N metadata (deploy script) | ~3 KB × N | grows linearly per platform |

**Hot spot.** The top index.html paste at ~200 KB per session is the single
largest recurring context cost. At 80+ platforms this approaches institutional
context window limits during a single batch deploy session.

### 1.3 What the current workflow does well

- **Judgment retention.** Operations Tier override decisions, Anthropic-relationship
  surface analysis, and Special Considerations reasoning are preserved in
  claude.ai chat history with full visible reasoning trace.
- **Iterative review.** Tatsuya can adjust evaluation, override decisions, and
  deploy artifacts mid-session with immediate feedback.
- **Reproducibility.** Each session produces commit-trackable artifacts; failures
  surface in chat and are recoverable.
- **Institutional learning.** Patterns surface across sessions and are codified
  into worklog and ENGINE.md / QA.md.

### 1.4 What the current workflow does not scale

- **Recurring large file paste.** top index.html, rankings/index.html, and
  templates are pasted in nearly every operations session despite changing only
  incrementally between sessions.
- **Linear growth in EXISTING_N metadata.** The deploy script's 58-platform
  baseline (deploy_059_060_061.py) will grow to 100+ entries; future scripts
  must regenerate this metadata each batch.
- **Memory vs. actual state divergence.** Multiple instances surfaced in
  2026-04-29 session (memory recorded "E2B Tier override applied" while no
  artifact existed; rank-denominator-stratified-staleness across 50 pages).
  Memory-only state is institutionally fragile at this volume.

---

## 2. Architecture Options

### Option A: Full GitHub Actions CI/CD

Trigger: `git push` to `verdict-platforms` evaluations/ directory.
Action: GitHub Actions workflow builds platform pages, rebuilds rankings, rebuilds
top index, commits results to `verdict-index`.

**Pros**
- Zero claude.ai context burn for deploy operations.
- Sustains 100+ platforms without operational burden.
- Automatic, fast, repeatable.

**Cons**
- Tier override and QA judgment cannot run inside GitHub Action (loss of visible
  reasoning trace; institutional integrity risk for override decisions).
- High initial setup cost (action authoring, template generation logic).
- Debugging via action logs is slower than chat-based feedback.
- Reversal cost (back to manual workflow) is high once committed.

### Option B: Local Python tool

Tatsuya runs `verdict-tool deploy --platform e2b --evaluation 059_e2b.md` locally
after evaluation creation. The tool unifies and generalizes the three scripts
created in 2026-04-29 session (deploy, fix, integrate) into a single CLI.

**Pros**
- Zero claude.ai context burn for deploy execution.
- Fast local feedback loop.
- Lower learning curve than GitHub Actions.
- Builds on existing institutional infrastructure (3 scripts already exist).

**Cons**
- Evaluation creation, Tier override judgment, and QA review still require claude.ai
  (the largest context burn is in Stage 3, not Stage 4).
- Tatsuya retains local Python environment maintenance responsibility.
- Does not address top index.html paste hot spot in operations sessions.

### Option C: State externalization via GitHub fetch (RECOMMENDED PILOT)

Operations claude.ai sessions begin by fetching current state directly from
GitHub raw URLs rather than receiving paste from Tatsuya:

```
Session start:
  Operations Claude: web_fetch https://raw.githubusercontent.com/zinova-lab/verdict-index/main/rankings/index.html
  (current rankings state retrieved without paste)

  Operations Claude: web_fetch https://raw.githubusercontent.com/zinova-lab/verdict-platforms/main/platforms/_template.md
  (canonical template retrieved without paste)

Tatsuya: paste evaluation content only (~20 KB)
Operations Claude: process + generate deploy artifacts

Context burn: ~280 KB → ~20 KB per session (10x+ reduction)
```

**Pros**
- Compatible with existing workflow; minimal learning cost.
- Treats `evaluations/` directory (established 2026-04-29) as institutional
  source of truth — extends an already-codified pattern.
- 10x+ context reduction without losing judgment retention.
- Incremental migration possible; revertible per-session.
- No new infrastructure required (web_fetch is already available).

**Cons**
- Public GitHub repo only (private repo would require token handling).
- web_fetch tool availability is a precondition.
- Tatsuya must remember to invoke fetch pattern at session start (or document
  it in a session-start ritual).

### Option D: Hybrid (C + selective A)

- **Evaluation session:** claude.ai chat (Tatsuya paste minimal).
- **Operations session:** claude.ai chat with GitHub fetch (Option C pattern).
- **Deploy execution:** GitHub Actions for purely mechanical steps (rank renumbering,
  rankings rebuild, top index card insertion); Tier override and QA judgment
  remain in claude.ai chat with visible reasoning.

**Pros**
- Optimal layer-by-layer: each step uses the right tool.
- Judgment retention preserved where it matters; mechanical steps automated.
- Sustainable for 100+ platforms.

**Cons**
- Highest implementation cost; requires both fetch pattern adoption and
  GitHub Actions authoring.
- Coordination overhead between layers.
- Premature for current 61-platform stage; better fit for post-100 institutional
  refresh.

---

## 3. Comparison Matrix

| Aspect | A (CI/CD) | B (Local tool) | C (State externalize) | D (Hybrid) |
|--------|-----------|----------------|------------------------|------------|
| claude.ai context burn | Lowest | Low (deploy only) | 10x reduction | Low + scoped |
| Tatsuya learning cost | High | Medium | **Low** | High |
| Debug speed | Slow | Fast | Medium | Mixed |
| 100-platform sustain | Excellent | Good | **Good** | Excellent |
| Judgment retention | Lost | Preserved | **Preserved** | Preserved |
| Implementation effort | High | Medium | **Low** | High |
| Reversibility | Hard | Easy | **Easy** | Medium |
| Strategy commitment | High | Medium | **Low (pilot)** | High |

---

## 4. Recommendation — Option C Pilot from 062 Batch

### 4.1 Rationale

1. **Existing institutional infrastructure aligns with Option C.**
   The 2026-04-29 session established `verdict-platforms/evaluations/` as the
   1st institutional precedent for engine output verbatim externalization.
   Option C is the natural extension: treat the externalized evaluations as
   the source of truth fetched at session start.

2. **Incremental migration is institutionally low-risk.**
   Pilot in 062 batch can revert immediately if context retrieval via fetch
   proves brittle. The current paste-based workflow remains as fallback.

3. **Judgment retention is preserved.**
   Tier override decisions, Anthropic-relationship analysis, and Special
   Considerations reasoning all happen in claude.ai chat as before; only
   the bulk-paste of state files is replaced by fetch.

4. **Option D is the natural long-term goal but premature now.**
   GitHub Actions for purely-mechanical deploy steps would benefit from a
   stable template at 80–100 platforms. Adopting Option D before institutional
   patterns settle increases risk of churning the action authoring.

### 4.2 Pilot scope (062 batch)

**Operations Claude session-start ritual (proposed):**

```markdown
At session start, Operations Claude executes:

1. web_fetch https://raw.githubusercontent.com/zinova-lab/verdict-index/main/rankings/index.html
   → current rankings + tier counts + existing platform list

2. web_fetch https://raw.githubusercontent.com/zinova-lab/verdict-platforms/main/evaluations/061_mistral_la_plateforme.md
   → reference evaluation for institutional pattern recognition (last
   completed evaluation)

3. (deferred) web_fetch top index.html only if proactive card-insertion
   review is needed. Default: skip; rely on deploy script automation.

Tatsuya then pastes:
- 062 evaluation content (engine output Block 1 + Block 2)

Operations Claude generates:
- 11 deploy artifacts (or unified single artifact set) following
  established 059-061 batch pattern
```

**Expected outcomes:**
- 5x–10x context reduction per operations session.
- No loss of judgment retention.
- Institutional pattern (`evaluations/` as source of truth) reinforced.

### 4.3 Pilot success criteria

After 062–065 pilot batches (4 platforms):

| Criterion | Target | Measurement |
|-----------|--------|-------------|
| Context burn per session | ≤ 30 KB total paste | Count session paste bytes |
| Judgment trace completeness | ≥ current quality | Compare worklog learnings density |
| Deploy success rate | 100% | Same as current workflow |
| Operations time per platform | ≤ 110% of current | Wall-clock measurement |
| Tatsuya cognitive load | Subjectively unchanged | Tatsuya self-assessment |

### 4.4 Pilot rollback criteria

If any of the following occur, revert to current paste-based workflow and
reassess:

- web_fetch returns stale data (caching issue beyond CDN propagation expectation).
- Operations Claude misses material institutional finding due to fetch
  granularity (e.g. fetches old rankings state).
- Tatsuya time-cost increases due to fetch coordination overhead.

---

## 5. Long-term Trajectory — Option D after 100 Platforms

When VERDICT reaches 100 platforms (institutional milestone for v0.4 framework
review), Option D becomes a candidate:

- **Mechanical deploy** (rank renumbering, rankings rebuild, top index card
  insertion, platform page generation from canonical .md) → GitHub Actions.
- **Judgment-bearing operations** (Tier override decision, Anthropic-relationship
  analysis, Special Considerations evaluation, QA review) → claude.ai chat with
  state externalization (Option C foundation).
- **Evaluation creation** → unchanged (claude.ai engine sessions).

This is institutionally premature in 2026-04 (61 platforms) but appropriate at
100-platform institutional review (estimated 2027-Q1–Q2 based on current cadence).

---

## 6. Open Questions for Strategy Project Review

The following questions are out of scope for Operations Project and should be
formally reviewed in Strategy Project:

1. **Tool stack commitment.** Should VERDICT institutionally commit to:
   - GitHub Actions for deploy automation (vendor lock to GitHub),
   - or Anthropic API direct (vendor lock to Anthropic),
   - or self-hosted minimal toolchain (institutional independence)?

2. **Repository structure.** Should `verdict-engine` repo include:
   - operations tooling (deploy scripts, fix scripts, integrate scripts), or
   - keep operations tooling in separate `verdict-operations-tools` repo?

3. **Visibility of operations tooling.** Should operations scripts be:
   - public (transparency principle of "silence is data"),
   - or private (security through obscurity / institutional discretion)?

4. **Engine session and operations session separation.** Currently both are
   claude.ai chat sessions; should they be:
   - in distinct claude Projects (already separated structurally),
   - or in distinct tools (e.g. claude API for engine, claude.ai for operations)?

5. **Long-term Anthropic dependency.** VERDICT bias disclosure already states
   Anthropic-relationship; institutional roadmap should consider:
   - tool diversity (multi-LLM evaluation engine),
   - or single-tool consistency (Anthropic-only with explicit disclosure).

These questions are tracked here for institutional traceability; resolution belongs
to Strategy Project.

---

## 7. Decision Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-04-29 | Codify Option C pilot proposal in this document | 100-platform sustainability requires architectural review before context burn becomes operational bottleneck |
| 2026-04-29 | Option D (hybrid CI/CD + state externalization) marked as long-term goal post-100 platforms | Premature now; appropriate after institutional patterns stabilize |
| 2026-04-29 | Option A (full CI/CD) explicitly rejected for current stage | Would lose judgment retention; institutional risk for Tier override decisions |
| 2026-04-29 | Option B (local Python tool) marked as fallback, not primary | Does not address operations-session context burn (Stage 3 is the hot spot, not Stage 4) |
| TBD (062 pilot start) | Pilot kickoff | Per pilot scope defined in Section 4.2 |
| TBD (065 pilot end) | Pilot evaluation | Per success criteria in Section 4.3 |

---

**Document version:** 1.0
**Framework version reference:** VERDICT v0.3.1 (operations workflow concerns
intersect with framework but are not framework-defined)
**Next review:** After 062–065 pilot batches complete, by Strategy Project.

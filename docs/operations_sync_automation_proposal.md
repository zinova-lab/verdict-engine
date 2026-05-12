# VERDICT Operations Sync Automation Proposal

> **Purpose.** Define the architecture and phased implementation roadmap for
> automating the manual Notion → GitHub sync step (Step 1-6 in
> `docs/operations_session_sop.md` Section 2.2). This step occurs after each
> VERDICT evaluation is completed in an Engine session and saved to Tatsuya's
> Notion working copy, and represents mechanical work that does not require
> operator judgment but currently consumes ~10-15 minutes per evaluation.
>
> **Status.** Design document. Pilot implementation (Option 1 bash script) is
> committed alongside this proposal at `operations-tools/sync_evaluation.sh`.
> Strategy Project formal review proposed after Phase 2 pilot data is collected
> (after 070 batch completes).
>
> **Created.** 2026-05-12 by Operations session (continuation of the 059-061
> deploy and 062-064 candidate selection session).
>
> **Cross-references.**
> - `docs/operations_workflow_v2.md` Section 4 (Option C pilot foundation)
> - `docs/operations_workflow_v2.md` Section 5 (Option D long-term trajectory)
> - `docs/operations_session_sop.md` Section 2.2 (current manual sync workflow)

---

## 1. Problem Statement

After each VERDICT evaluation is completed in an Engine session, the workflow
requires Tatsuya to:

1. Copy the Engine output (Block 1 English report + Block 2 Japanese summary)
   from the Notion working copy
2. Save to a local file at the correct path with the correct filename
   convention (`evaluations/{NNN}_{slug}.md` in verdict-platforms repo)
3. Execute `git add`, `git commit`, and `git push`
4. Verify the file is accessible via GitHub raw URL with HTTP/2 200

This sequence is purely mechanical (no operator judgment is required) but
consumes approximately 10-15 minutes per evaluation when executed manually.
Across the 36 remaining platforms in the 100-platform roadmap, this represents
~6-9 hours of Tatsuya cognitive bandwidth that could be redirected toward
judgment-bearing work.

The current manual workflow is also susceptible to mechanical errors:

- Filename convention drift (e.g., capitalization, separator character)
- Path errors (saving to wrong repo or wrong directory)
- Git operation errors (forgetting `git push`, omitting `git add`)
- Verification omission (skipping the HTTP/2 200 check, leading to downstream
  Operations session web_fetch failures)

This proposal addresses the automation of this mechanical step while
preserving the institutional integrity of the VERDICT verbatim-preservation
principle.

---

## 2. Constraints — Non-negotiable Institutional Requirements

Any automation solution must satisfy the following constraints:

### 2.1 Engine output verbatim preservation
The automation tool MUST NOT apply any transformation to the Engine output
content. No reformatting, no metadata insertion, no character encoding
conversion, no markdown re-rendering. The bytes that enter the file system
must be exactly the bytes Tatsuya copied from Notion.

### 2.2 Transparent execution
Every step the automation tool takes must be visible in the terminal output.
No invisible side effects. The Tatsuya-as-reviewer must be able to inspect
each step's outcome and abort before irreversible operations (git push).

### 2.3 No third-party API dependency
The tool MUST NOT integrate with Notion API, claude.ai API, or any other
commercial API that creates institutional lock-in. Input source must be
either the macOS clipboard (`pbpaste`) or a local file path; output is
git operations against the local repo clone.

### 2.4 Audit trail completeness
The git commit produced by the tool must include:
- A descriptive commit message identifying the evaluation number, slug, and
  date
- Author identity (`zinova-lab`)
- Standard commit footer (`Identity: zinova-lab`)

### 2.5 Reversibility at each step
The tool must offer an explicit confirmation step before `git commit` (last
locally-reversible step) and before `git push` (last globally-reversible
step). Tatsuya must be able to abort the workflow at any point with no
residual state changes.

### 2.6 Failure mode robustness
The tool must handle, with explicit user feedback, the following error modes:
- File already exists at the target path (overwrite vs abort prompt)
- Notion paste appears truncated (header verification fails)
- Network failure during git push (retry guidance)
- CDN propagation lag for HTTP/2 200 verification (retry-with-wait)

---

## 3. Architecture Options

### Option 1: Bash shell script (clipboard → local file → git operations)

**Implementation surface.** ~50 lines of bash, single file at
`operations-tools/sync_evaluation.sh`. Uses macOS-native `pbpaste` for
clipboard ingestion, standard `git` for repo operations, and `curl` for
HTTP/2 200 verification.

**Tatsuya workflow.**

```
1. Complete Engine session, save to Notion (unchanged)
2. In Notion, select entire evaluation content, Cmd+A → Cmd+C
3. Terminal: ./sync_evaluation.sh 062 langsmith
4. Tool displays the clipboard content header (first 10 lines)
5. Tool prompts: "Continue with commit? (y/n)"
6. Tatsuya types y
7. Tool executes git add + git commit + git push
8. Tool sleeps 60-90 sec for CDN propagation
9. Tool curls the raw URL, displays HTTP/2 200 confirmation
10. Done. Total Tatsuya time: ~2-3 minutes per evaluation.
```

**Institutional pros.**
- Maximally simple — readable by any engineer in 5 minutes.
- Notion-portable (Tatsuya could move to Obsidian / plain markdown editor
  without changing the tool).
- Every step visible in terminal output.
- Confirmation prompt prevents accidental commits.
- ~50 lines of bash is trivial to audit, suitable for business-partner
  review and external auditor inspection.

**Institutional cons.**
- Single-evaluation invocation; batch of 3 requires 3 tool invocations.
- Bash portability nuances (zsh vs bash). For VERDICT's macOS-only operator
  environment this is not an institutional concern.

**Institutional risk profile.** Lowest. The tool does nothing that Tatsuya
could not do manually; it only sequences the mechanical operations.

### Option 2: Python CLI tool with batch support and validation

**Implementation surface.** ~150 lines of Python at
`operations-tools/verdict_sync.py`. Adds the following capabilities over
Option 1:

- Multiple evaluations processed in a single invocation
- Pre-commit validation of Engine output structure (verify Block 1 + Block 2
  presence, score line presence, Tier line presence)
- Cross-block consistency check (verify Block 1 and Block 2 cite the same
  total score and Tier)
- `--dry-run` flag for review-before-execute
- Backup of any pre-existing target file before overwrite

**Tatsuya workflow.**

```
1. Complete Engine sessions for 062, 063, 064 (unchanged)
2. Save each evaluation to local intermediate files (Tatsuya editor)
   or to Notion + read by tool
3. Terminal: python3 verdict_sync.py --batch 062:langsmith 063:pinecone 064:guardrails_ai --dry-run
4. Tool validates each file, displays summary
5. Tool prompts: "All 3 evaluations validated. Continue? (y/n)"
6. Tatsuya types y
7. Tool commits all 3 files in a single commit + push
8. Tool verifies all 3 raw URLs return HTTP/2 200
9. Done. Total Tatsuya time: ~3-5 minutes for 3 evaluations.
```

**Institutional pros.**
- Batch processing matches the institutional rhythm of evaluation work
  (Operations sessions process batches of 3 platforms).
- Pre-commit validation catches structural defects before commit (currently
  detected only at downstream Operations session via web_fetch).
- Consistent with the existing `operations-tools/` Python script pattern
  (deploy_059_060_061.py, fix_rank_denominators_v1.py,
  integrate_engine_patch.py, deploy_batch.py).

**Institutional cons.**
- More code to maintain (~150 lines vs ~50 lines).
- Validation logic could itself contain bugs; requires test coverage.
- Slightly higher institutional barrier to business-partner review.

**Institutional risk profile.** Medium-low. The validation step is the only
new institutional surface that did not exist in the manual workflow; bugs in
this step could either incorrectly accept a defective file or incorrectly
reject a valid file. The latter is the safer failure mode (Tatsuya re-runs
with `--no-validate` flag) and design should bias toward false-rejection
over false-acceptance.

### Option 3: GitHub Actions + Notion API integration

**Implementation surface.** ~500 lines across:
- GitHub Actions workflow YAML
- Notion API integration script (Python or TypeScript)
- Markdown conversion logic for Notion → standard markdown
- Webhook or polling mechanism to detect "ready to sync" Notion pages
- OAuth or API token management
- Error reporting back to Notion or Slack

**Tatsuya workflow.**

```
1. Complete Engine session, save to Notion (unchanged)
2. In Notion, add a "Ready to sync" property tag to the page
3. Wait ~5-15 minutes for CI/CD pipeline trigger and execution
4. Receive Slack notification (or similar) when commit completes
5. Verify on GitHub web interface or local git pull
```

**Institutional pros.**
- Tatsuya manual involvement essentially zero per evaluation.
- Visibly fully-automated to business partner and external observers.

**Institutional cons (severe).**
- **Notion API dependency** creates institutional lock-in to a third-party
  commercial service. Future Notion API rate limit changes, pricing changes,
  or deprecations directly impact VERDICT operations.
- **Notion → markdown conversion logic** is the single largest institutional
  risk. Notion's internal representation differs from standard markdown in
  several ways (table syntax, code block fencing, embedded media). Any
  conversion bug introduces silent corruption of Engine output verbatim
  preservation — exactly the institutional integrity violation the
  framework is designed to prevent.
- **Debugging via remote logs** (GitHub Actions web UI) is significantly
  slower than debugging local bash or Python tool output.
- **CI/CD setup and maintenance** burden is non-trivial. GitHub Actions
  syntax changes, action deprecations, and secret management all require
  periodic operator attention.
- **Over-engineering relative to scale.** VERDICT roadmap has 36 more
  evaluations. Building a 500-line CI/CD pipeline for ~36 invocations is
  poor ROI when a 50-line bash script accomplishes the same outcome with
  better institutional safety properties.

**Institutional risk profile.** High. Recommended against at VERDICT's
current scale and institutional maturity stage. Reconsider only after
VERDICT reaches v1.0 framework status (estimated post-100 platforms) and
the operator team grows beyond Tatsuya alone (institutional process
sustainability becomes a different problem at multi-operator stage).

---

## 4. Phased Implementation Roadmap

### Phase 0: Manual Step 1-6 — 062-064 batch (this session's pilot batch)

The 062-064 batch executes Step 1-6 manually per the current
`docs/operations_session_sop.md` Section 2.2. This is intentional and
serves three institutional purposes:

1. Validate the Option C pilot architecture end-to-end with a known-manual
   sync step, isolating the Option C variable (state externalization via
   GitHub fetch) from the sync-automation variable.
2. Generate empirical data on actual error patterns in manual execution to
   inform the Option 1 bash script design (defensive error handling).
3. Establish Tatsuya's cognitive baseline for the workflow before
   introducing automation; this baseline supports future ROI measurement.

### Phase 1: Option 1 bash script — 065-070 batch (next 6 platforms)

After 062-064 batch deploy completes, the Option 1 bash script (committed
alongside this proposal at `operations-tools/sync_evaluation.sh`) is used
for the next 6 evaluations. Pilot success criteria:

| Criterion | Target | Measurement |
|-----------|--------|-------------|
| Tatsuya time per sync | ≤ 5 minutes | Wall-clock from "Cmd+C in Notion" to "HTTP/2 200 confirmation" |
| Error rate | < 10% requiring manual intervention | Count of failed runs over 6 invocations |
| Cognitive load | Subjectively reduced | Tatsuya self-assessment |
| Engine verbatim integrity | 100% | File-content diff vs Notion source |

### Phase 1 rollback criteria
Revert to manual Step 1-6 if any of:
- Engine verbatim integrity is compromised (any byte-level divergence)
- Error rate exceeds 25%
- Tatsuya time per sync exceeds 8 minutes due to error handling

### Phase 2: Option 2 Python tool — 071-100 batch (final 30 platforms)

If Phase 1 succeeds, Phase 2 introduces the Option 2 Python tool with batch
processing and pre-commit validation. This represents the steady-state tool
for VERDICT's remaining roadmap.

Phase 2 pilot success criteria:

| Criterion | Target | Measurement |
|-----------|--------|-------------|
| Tatsuya time per batch (3 evaluations) | ≤ 5 minutes | Wall-clock |
| Validation catches at least 1 structural defect | ≥ 1 over 30 batches | Logged validation rejections |
| Engine verbatim integrity | 100% | File-content diff |
| Test coverage of validation logic | ≥ 80% line coverage | pytest coverage report |

### Phase 3: Strategy Project formal review — post-100 platforms

After the 100-platform roadmap completes, conduct a formal Strategy Project
review of:
- Whether Option 3 (CI/CD + Notion API) is justified for VERDICT v0.4 → v1.0
- Whether the operator team has grown to where multi-operator workflow
  considerations apply
- Whether the operations sync workflow should be open-sourced for external
  evaluators (transparency strategy decision)

---

## 5. Institutional Trade-off Analysis

| Trade-off | Option 1 | Option 2 | Option 3 |
|-----------|----------|----------|----------|
| Lines of code | ~50 | ~150 | ~500 |
| Implementation time | 2-3 hours | 4-6 hours | 20+ hours |
| Engine verbatim integrity risk | Lowest | Low (validation only) | Highest (Notion conversion) |
| Notion lock-in risk | None | None | High |
| Audit transparency | Highest | High | Medium |
| Tatsuya time per evaluation | ~3 min | ~1.5 min (batched) | ~30 sec |
| Business-partner reviewability | Highest | High | Medium |
| Long-term maintenance | Minimal | Low | High |
| Failure debugging | Local terminal | Local terminal | Remote CI logs |
| Recommended phase | Phase 1 | Phase 2 | Reject (or post-100 reconsider) |

---

## 6. Decision Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-05-12 | Codify this proposal as design document | Tatsuya surfaced the manual sync friction during 062-064 candidate selection session; proactive documentation while context is fresh |
| 2026-05-12 | Implement Option 1 bash script alongside this proposal | Phase 1 pilot infrastructure should be available immediately after this session closes; build now while context is still active |
| 2026-05-12 | Defer Option 2 Python tool to Phase 2 (post-Phase 1 pilot data) | Build Option 2 with empirical data from Option 1 usage; avoid theoretical over-engineering |
| 2026-05-12 | Reject Option 3 for current institutional stage | Over-engineering at VERDICT's roadmap scale; Notion API lock-in unacceptable; Engine verbatim preservation at risk |
| TBD (065 batch start) | Phase 1 pilot kickoff | Per Phase 1 success criteria above |
| TBD (070 batch complete) | Phase 1 pilot evaluation | Per Phase 1 success criteria above |
| TBD (071 batch start) | Phase 2 pilot kickoff | Conditional on Phase 1 success |
| TBD (100 batch complete) | Phase 3 Strategy Project review | Per Section 4 Phase 3 description |

---

## 7. Open Questions for Strategy Project Review

The following questions are out of scope for Operations Project and should be
formally reviewed in Strategy Project when relevant:

1. **Open-sourcing operations-tools/**. Should the `operations-tools/`
   directory (currently local-only on Tatsuya's machine) be committed to a
   public repository at zinova-lab/verdict-operations-tools? This impacts
   VERDICT's institutional transparency posture (silence-is-data principle
   applied to operations tooling itself) and external auditor reviewability.

2. **Notion replacement timing**. If VERDICT's institutional integrity
   requires zero third-party commercial dependencies, when should Notion be
   replaced with a self-hosted or plain-markdown working copy? The current
   automation proposal (Options 1-2) is Notion-portable; only Option 3 would
   create lock-in.

3. **Business-partner co-operator scenario**. If the business partner Tatsuya
   has referenced becomes a second VERDICT operator, the workflow
   assumptions change (single-operator institutional discipline becomes
   multi-operator process). The automation tool design should be revisited
   if this transition occurs before the 100-platform roadmap completes.

These questions are tracked here for institutional traceability; resolution
belongs to Strategy Project.

---

**Document version:** 1.0
**Phase 1 pilot start:** 065 batch
**Phase 2 pilot start:** 071 batch (conditional)
**Strategy Project review:** post-100 platforms
**Companion implementation:** `operations-tools/sync_evaluation.sh` (Option 1, committed alongside this document)

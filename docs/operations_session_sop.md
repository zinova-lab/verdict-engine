# VERDICT Operations Session SOP

> **Purpose.** Codify the standard operating procedure for VERDICT Operations
> Project sessions, particularly the session-start ritual that implements the
> Option C state-externalization pilot defined in
> `verdict-engine/docs/operations_workflow_v2.md` Section 4.
>
> **Scope.** Operations Project sessions only. Engine sessions (evaluation
> creation) follow a separate SOP and are out of scope here.
>
> **Status.** v1.0 — pilot from 062 batch. Subject to revision after 062–065
> pilot evaluation per operations workflow v2 Section 4.3.
>
> **Created.** 2026-04-29 (continuation of 059–061 batch deploy session).

---

## 1. Session-Start Ritual

At the beginning of each Operations session, **before** Tatsuya pastes any
state, Operations Claude executes the following fetch sequence to load current
institutional state from GitHub raw URLs.

### 1.1 Required fetches (every session)

```
Operations Claude:
  1. web_fetch https://raw.githubusercontent.com/zinova-lab/verdict-index/main/rankings/index.html
     — Current rankings: tier counts, total platform count, all existing slugs.

  2. web_fetch https://raw.githubusercontent.com/ZinovaCreation/verdict-platforms/main/evaluations/{LATEST}.md
     — Last completed evaluation: institutional pattern reference.
     ({LATEST} is the highest-numbered evaluation file in evaluations/ at session start.)

  3. web_fetch https://raw.githubusercontent.com/zinova-lab/verdict-engine/main/docs/operations_workflow_v2.md
     — Operations workflow design document: Tier convention, override rules,
       institutional patterns.
```

### 1.2 Conditional fetches (when applicable)

```
If the session involves a specific platform category investigation:
  web_fetch the canonical .md from verdict-platforms/platforms/{slug}.md
  for the category exemplars. Avoid fetching all 60+ canonicals; fetch 1-2
  exemplars only.

If the session involves rankings rebuild logic:
  web_fetch a recent platform page index.html as template reference
  (e.g. cline/index.html or aider/index.html for current G3 template).

If the session involves analytics or operations-tooling debugging:
  Fetch the relevant log or commit history via GitHub API or web_fetch
  of specific issue URLs.
```

### 1.3 Avoid fetching

```
- top index.html (200 KB; avoid unless visual card-insertion review explicitly
  requested by Tatsuya — the deploy script handles card insertion automatically)
- All 60+ platform canonicals (institutional anti-pattern; fetch only relevant
  exemplars)
- Past evaluation history beyond the latest 1-2 (institutional anti-pattern;
  evaluations are in canonical evaluations/ dir for retrospective queries
  if needed)
```

### 1.4 Tatsuya paste expectation

After Operations Claude completes session-start fetches, Tatsuya pastes:
- The new evaluation content (engine output Block 1 + Block 2), typically ~20 KB
- Any session-specific context not in repo (e.g. "this batch has Special
  Considerations for X")

**Expected total context burn: ~30-40 KB per session** (vs ~280 KB pre-Option-C).

---

## 2. Notion → GitHub Workflow (Path β)

VERDICT operates a dual-storage workflow where Notion is the working copy
during evaluation drafting and GitHub is the institutional source of truth
after publication.

### 2.1 Engine session (out of scope here, summarized for context)

```
Engine Claude session:
  1. Tatsuya provides evaluation prompt
  2. Engine Claude generates evaluation (Block 1 English + Block 2 Japanese)
  3. Engine Claude runs QA review per QA.md
  4. Engine Claude delivers final report
  5. Tatsuya saves to Notion working copy
```

### 2.2 Notion → GitHub manual sync (mandatory before Operations session)

```
Tatsuya manual workflow:
  1. Open Notion working copy of evaluation #NNN
  2. Copy the full engine output verbatim (Block 1 + Block 2)
  3. Save to verdict-platforms/evaluations/{NNN}_{slug}.md
  4. git add evaluations/{NNN}_{slug}.md
  5. git commit -m "Add evaluation #{NNN} {slug} to evaluations/"
  6. git push
  7. (Now ready for Operations session)
```

**Institutional reasoning.** This step takes 2-3 minutes per evaluation but
establishes the GitHub commit as the institutional source of truth, which:
- Enables Operations Claude to fetch via web_fetch in the session-start ritual
- Provides commit-traceable evaluation history (audit-defensibility)
- Decouples Notion availability from Operations workflow
- Is reversible (Notion working copy retained as backup until Tatsuya cleans)

### 2.3 Operations session

```
Operations Claude session:
  1. Session-start fetches per Section 1.1
  2. Tatsuya pastes new evaluation content (or refers Operations Claude to fetch
     the just-committed evaluations/{NNN}_{slug}.md)
  3. Operations Claude:
     - Verifies Tier letter against ENGINE.md Tier Threshold Table
     - Applies Operations Override per QA.md Operations Override Rules if needed
     - Surfaces Special Considerations (acquisitions, equity, commercial
       relationships, political/sovereignty framing)
     - Generates deploy artifacts (HTML page, canonical .md, deploy command)
  4. Tatsuya runs deploy_batch.py locally
  5. Tatsuya commits + pushes to GitHub
```

---

## 3. Tier Override Checklist

For every evaluation, Operations Claude applies this checklist:

| Step | Check | Action |
|------|-------|--------|
| 1 | Read engine output Tier line | Capture `Tier: {X}` |
| 2 | Compute Tier from score per ENGINE.md | `derive_tier(score)` |
| 3 | Compare engine Tier vs derived Tier | Match? proceed. Differ? override. |
| 4 | If override applied, document in artifact header | Add Operations note paragraph |
| 5 | If override applied, log in worklog | Pattern: `Tier override {slug} engine={X} → Operations={Y}` |
| 6 | If override applied, update canonical .md and HTML | Reflect post-override Tier |

**Reference.** ENGINE.md `## Tier Letter Assignment` (commit bd8cf2b),
QA.md `## Operations Override Rules` (commit bd8cf2b).

---

## 4. Special Considerations Surface Checklist

For every evaluation, Operations Claude proactively checks:

| Item | Trigger | Disposition |
|------|---------|-------------|
| Acquisition (operator side) | Operator was acquired in last 24 months OR operator acquired another in last 24 months | Add Special Considerations paragraph; verify subprocessor disclosure currency |
| Equity overlap with Anthropic | Anthropic Ventures / Anthropic in cap table | Disclose in evaluation; flag in worklog |
| Commercial relationship with Anthropic | Anthropic uses operator OR operator integrates Anthropic | Disclose in bias disclosure; tag with `anthropic-indirect-commercial` |
| Political/sovereignty framing | Evaluation mentions geopolitics, sovereignty, national positioning | Convert to neutral structural/legal language before commit |
| Acquired sub-org disclosure | Operator owns acquired sub-orgs | Verify `legal/dpa.html` or equivalent reflects sub-org subprocessor list |

These checks are mandatory for institutional integrity (silence-is-data
principle) and audit defensibility.

---

## 5. Deploy Workflow

### 5.1 Single-platform deploy

```bash
cd ~/Desktop/VERDICT
python3 deploy_batch.py \
    --platforms 062_acme:55:A \
    --dry-run

# Review output
python3 deploy_batch.py \
    --platforms 062_acme:55:A \
    --apply

python3 deploy_batch.py \
    --platforms 062_acme:55:A \
    --verify
```

### 5.2 Multi-platform batch deploy

```bash
python3 deploy_batch.py \
    --platforms 062_acme:55:A 063_beta:42:C 064_gamma:38:C \
    --dry-run
# (then --apply, then --verify)
```

### 5.3 Commit sequence (canonical → HTML)

```bash
# verdict-platforms first (canonical source)
cd ~/Desktop/VERDICT/verdict-platforms
git add platforms/ evaluations/
git commit -m "Add evaluations #{NNN list}"
git push origin main

# verdict-index second (HTML deploy)
cd ~/Desktop/VERDICT/verdict-index
git add -A
git commit -m "Deploy #{NNN list}"
git push origin main
```

---

## 6. Session Close Checklist

Before closing an Operations session, Operations Claude:

| Item | Check |
|------|-------|
| All commits pushed | `git status` clean in both repos |
| Live verification | curl 3+ key endpoints, expect HTTP 200 + correct rank |
| Worklog v4 update text generated | Operations learnings codified |
| Discord log blocks generated | 4 channel routing per discord_logging_rules |
| PENDING tasks updated | Resolved tasks marked, new tasks queued |
| Backup files cleanup (optional) | `rm verdict-index/*.backup-*` |

---

## 7. Operations Learnings Discipline

When an institutional learning surfaces during a session:

1. **Codify in chat** with the standard yaml block:
   ```yaml
   - id: {kebab-case-id}
     finding: {what was observed}
     severity: {critical / major / minor}
     mitigation: {how addressed in this session}
     cross_reference: {parent learnings if any}
   ```

2. **Add to worklog v4 update text** at session close.

3. **If learning concerns institutional process**, flag for inclusion in next
   `docs/operations_workflow_v{N+1}.md` revision.

---

## 8. Strategy Boundary

Operations Claude does NOT decide on:
- Tool stack commitment (GitHub Actions vs API vs self-hosted)
- Repository structure / organization (verdict-platforms in ZinovaCreation
  vs zinova-lab is a Strategy Project decision)
- Visibility policy (public vs private)
- Long-term Anthropic dependency
- Brand identity changes
- Pivot decisions / revenue model

If any of these surface during an Operations session, Operations Claude:
1. Acknowledges the question
2. Flags it for Strategy Project escalation
3. Continues with Operations work that does not require resolution
4. Does not advance the Strategy decision

---

**Document version:** 1.0
**Pilot start:** 062 batch
**Pilot evaluation:** After 065 batch completes (per operations_workflow_v2.md
Section 4.3)
**Next review:** Strategy Project formal review after pilot evaluation.

# VERDICT Update Evaluation Prompt — Template (Framework v0.3.2 Differential Evaluation)

Use for every Layer C update: routine review (365-day lane) or interrupt lane (T1–T6). Fill in each section. Remove instructional lines (prefixed with `>`) before use. File name: `prompts/{NNN}_{slug}_update_{YYYY-MM-DD}.md`.

---

## RECORD UNDER UPDATE

**Name / slug:** [name] / [slug]
**Evaluation number:** [NNN] (unchanged on update — it identifies the series)
**Current canonical record:** `platforms/[slug].md` at commit [hash] — read it in full before starting
**evaluated_at (original Layer 0 date, never changes):** [YYYY-MM-DD]
**Previous evaluation (becomes `previous_evaluation_date` / `previous_score`):** [YYYY-MM-DD] / [score]
**Prior framework version / evaluator model:** [v0.3.x] / [model or `unrecorded`]
**Prior `cve_count_12mo` / basis / `max_cvss_12mo` / KEV entries / supply chain:** [values]
**Prior record type:** [engine-authored with `sources` | migrated capture without `sources`]

---

## TRIGGER

> One row per trigger. Facts and sources only; the engine verifies each on a primary source (NVD, CISA KEV JSON, vendor advisory) before use.

| Trigger | Fact | Date | Source URL |
|---|---|---|---|
| [T1–T6 or Routine] | | | |

---

## SCOPE

**Lane:** [Interrupt | Routine | Routine with folded interrupt triggers]
**Mandatory re-evaluation:** [R, T, V for routine; per ENGINE.md Layer C table for interrupts]
**Carry-forward candidates:** [D, I, C — or "none: prior record carries no `sources`, so the carry-forward conditions cannot be met; all six dimensions are re-evaluated"]
**Trailing 12-month window for R:** [update date − 12 months] → [update date]
**KEV flag:** list every KEV entry for the product regardless of window; mark entries older than the window as such. KEV protocol per ENGINE.md (listing date, FCEB deadline if any, elapsed time from disclosure to KEV addition, Scorecard / Incident Timeline / Executive Summary / Contextual Analysis).
**Attribution:** product-scoped per `target_version` (ENGINE.md Attribution note). Dependency CVEs → Incident Timeline with `dependency: <vendor/product>`; CVE-less advisories → Incident Timeline and T, not counted.

---

## CARRY-FORWARD CHECKS (only if candidates exist)

> For each candidate dimension, list every source URL the prior record cited. The engine records, per URL: resolves (yes/no; new location), last-updated or effective date vs. previous evaluation date, and whether any release note, announcement, or incident in the window touches the dimension. A dimension is carried forward only when every condition holds; otherwise re-evaluate it.

### D
- [prior URLs]
### I
- [prior URLs]
### C
- [prior URLs]

---

## PUBLIC SOURCES TO CONSULT

### Official project
- Homepage / documentation / privacy policy / security page / terms / DPA / sub-processors:
### Security and vulnerability disclosure
- GitHub Security Advisories: · NVD search terms: · OSV: · CISA KEV catalog: · vendor advisories / postmortems:
### Ownership and identity
- [operator, parent entity, acquisition records — for V and `independence`]
### Release and activity record (dormancy test)
- [releases / changelog; last activity date]

---

## FIELD SEMANTICS (ENGINE.md, Differential Evaluation — restated for the engine)

- `evaluation_type: update`; `differential.{v,r,d,i,c,t}` = `re-evaluated` | `carried-forward`; `differential.e: null`.
- `evaluated_at` unchanged; `updated_at` = date the differential is completed; `previous_evaluation_date` / `previous_score` = the immediately preceding evaluation.
- `framework_version: v0.3.2`; `target_version` = the version examined now; `evaluator_model` recorded exactly.
- `cve_count_12mo` (basis `exact`), `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` recomputed over the new window.
- `independence` assessed (`unrecorded` not permitted); `qa` full protocol (`unresolved` not permitted).
- `next_review_due` is recomputed by the pipeline; do not author it.
- If the R-only change moves the total by ≥3 points, escalate to a full re-review (all six dimensions) before publication. If the total moves by ≥5 points, the Executive Summary names the dimensions and evidence that moved it.

---

## SPECIAL CONSIDERATIONS

> Material facts only; three entries maximum. Disclosure layer: state which of Trigger 0 / 1 / 2 / 3 fire, or "None".

### 1. [Concise heading]
[1–3 sentences]

---

## KNOWN FACT CORRECTIONS

> Reference applicable `KNOWN_FACTS.md` entries, or state "None applicable."

---

## OUTPUT RULES

1. Full English report in a markdown code block (ENGINE.md Output Format), header `Evaluation type: Update`, plus:
   - a **Differential** section: previous evaluation date and score; each dimension's state; carry-forward checks performed (date, URLs) or the reason none were possible; prior-record omissions found (e.g. a CVE inside the prior window that the prior record did not carry), stated as facts;
   - an **Evaluation History** table (date, type, score, tier, framework version) covering every evaluation in the series.
2. Japanese summary in a `japanese-summary` code block, with `評価種別: 更新` and 前回スコア.
3. Score tag line and dimension sum check as in the initial template.
4. Front matter block for `platforms/[slug].md` with every field above set.

---

## REMINDERS

- Public documentation only (Layer 0). Silence = 0. Carry-forward is a positive finding, never an inference from absence of news.
- Include positive findings alongside risks. No intent attribution. Record elapsed times, not motives.
- The prior score is published alongside the new one; never suppress or smooth a change.

---
# END OF PROMPT

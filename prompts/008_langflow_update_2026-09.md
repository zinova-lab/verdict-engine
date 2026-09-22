# VERDICT Update Evaluation Prompt — #008 Langflow (update, 2026-09)

Framework v0.3.2 Differential Evaluation. Pilot update #1 (ReviewCadence-001); folds the immediate-lane T2 events triaged in LayerC-Triage-001 (2026-09-22).

---

## RECORD UNDER UPDATE

**Name / slug:** Langflow / langflow
**Evaluation number:** 008 (unchanged)
**Current canonical record:** `platforms/langflow.md` at ZinovaCreation/verdict-platforms `1143559` — read in full before starting. It is a migrated capture: fragmentary body, no `sources`, `target_version` absent, `evaluator_model: unrecorded`, `independence: unrecorded`, and a recorded Source Divergence between the live card dimension set (V 5 / R 4 / D 4 / I 5 / C 4 / T 6, sum 28, published total 30) and the Notion v2 revision set (V 8 / R 8 / D 3 / I 5 / C 2 / T 4, sum 30). The record states that resolution is a re-evaluation; this update is that re-evaluation.
**evaluated_at (never changes):** 2026-03-13
**Previous evaluation (→ `previous_evaluation_date` / `previous_score`):** 2026-03-24 / 30
**Evaluation History so far (from the record):** 2026-03-13 Initial (Layer 0) 33 / Tier D / v0.3.1 → 2026-03-24 Update 30 / Tier D / v0.3.1 (R re-evaluated); provenance correction 2026-09-22 restored `evaluated_at` to 2026-03-13
**Prior framework version / evaluator model:** v0.3.1 / unrecorded
**Prior R fields:** `cve_count_12mo: null` (basis `conflicting`: criterion table 2 vs card 6), `max_cvss_12mo: null`, KEV entries: CVE-2025-3248 (added 2025-05-05) in front matter; CVE-2026-33017 cited as KEV in body text; `supply_chain_compromise_12mo: false`
**Prior record type:** migrated capture without `sources`

---

## TRIGGER

| Trigger | Fact | Date | Source URL (engine verifies on the primary source) |
|---|---|---|---|
| Routine (pilot) | Base date 2026-03-24; routine review under ReviewCadence-001 | 2026-09 | — |
| T2 | CVE-2025-34291 (CORS/credential chain → account takeover → RCE; CVSS 3.1 8.8; published 2025-12-05) added to CISA KEV | 2026-05-21 | https://osv.dev/vulnerability/CVE-2025-34291 ; KEV JSON |
| T2 | CVE-2026-55255 (cross-tenant IDOR on /api/v1/responses; fixed 1.9.1; published scores conflict — 6.1 in THN/KEV reporting vs 9.9 in Sysdig) added to CISA KEV | 2026-07-07 | https://www.sysdig.com/blog/understanding-langflow-cve-2026-55255-and-why-higher-cvss-vulnerabilities-arent-always-the-most-exploited ; https://thehackernews.com/2026/07/cisa-adds-4-actively-exploited-adobe.html ; KEV JSON |
| T2 | CVE-2026-0770 (RCE via validate endpoint exec_globals) added to CISA KEV | 2026-07-21 | KEV JSON; NVD |
| T2 | CVE-2026-9198 (KEV vendorProject "IBM", product Langflow; reported as unauthenticated RCE chaining /api/v1/auto_login and /api/v1/validate/code in Langflow OSS 1.0.0–1.10.0 — engine to confirm the ID↔description mapping on NVD) added to CISA KEV | 2026-08-04 | KEV JSON (only source at triage); NVD |

Additional CVEs reported as exploited in the window but not confirmed KEV at triage: CVE-2026-33017 (RCE via /api/v1/build_public_tmp, <1.9.0), CVE-2026-21445, CVE-2026-5027, CVE-2026-3357 (Langflow Desktop 1.6.0–1.8.2, FAISS deserialization — desktop product; scope decision below). Engine enumerates the full trailing-12-month set from NVD/GHSA/OSV; the list above is not the count.

---

## SCOPE

**Lane:** Routine with folded interrupt triggers (T2 ×4). Runs first in the pilot order.
**Mandatory re-evaluation:** R, T, V (routine) — and, because the prior record carries no `sources`, the carry-forward conditions cannot be met for D, I, C. **All six dimensions are re-evaluated.** `differential` = `re-evaluated` for v, r, d, i, c, t; `e: null`.
**Trailing 12-month window for R:** [update date − 12 months] → [update date].
**KEV flag:** list every Langflow KEV entry regardless of window (CVE-2025-3248 added 2025-05-05 is older than the window — mark it as such; then 34291, 55255, 0770, 9198, and CVE-2026-33017 if the KEV JSON confirms it). For each: KEV listing date, FCEB deadline (BOD 22-01 dueDate field), elapsed time from initial disclosure to KEV addition.
**Attribution / target:** Langflow OSS (github.com/langflow-ai/langflow) as distributed via PyPI `langflow` — bind `target_version` to the latest release on the update date. Langflow Desktop and IBM-hosted offerings are the same operator's other surfaces: record Desktop-only CVEs (e.g. CVE-2026-3357) in the Incident Timeline with the surface named, and count them in `cve_count_12mo` only if `target_version` is defined to include Desktop — decide and state the scope explicitly in the report. KEV vendorProject "IBM" is consistent with the recorded operator; no T5.

---

## PUBLIC SOURCES TO CONSULT

### Official project
- Homepage: https://www.langflow.org (engine to verify) · Documentation: https://docs.langflow.org (engine to verify) · Repository: https://github.com/langflow-ai/langflow · PyPI: https://pypi.org/project/langflow/
- Privacy policy / terms / DPA / sub-processors: DataStax and IBM legal pages that govern Langflow (engine to locate; record which entity's documents apply to the OSS product vs. hosted offerings)
- Security policy: repository SECURITY.md; IBM PSIRT / DataStax security pages (engine to verify)
### Security and vulnerability disclosure
- GitHub Security Advisories: https://github.com/langflow-ai/langflow/security/advisories (dry-run count: 29 advisories in 12 months; paginate)
- NVD search terms: "Langflow", "langflow-ai", "IBM Langflow"
- OSV: https://osv.dev/list?q=langflow
- CISA KEV catalog JSON: https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json
- Exploitation reports: Sysdig (CVE-2026-55255, agentic ransomware via CVE-2025-3248), Trend Micro / Flodrix (CVE-2025-3248), others the engine finds
### Ownership and identity
- Logspace → DataStax → IBM (DataStax acquisition completed 2025; record states "IBM Acquired · Aug 2025" — engine to verify the completion date and IBM's stated stewardship of Langflow on IBM/DataStax pages). Set `independence` and `parent_entity` accordingly (IBM is the parent; Langflow is not an independent entity).
### Release and activity record
- GitHub releases / tags; last activity date (dormancy test — expected active).

---

## FIELD SEMANTICS

Per `_template_update.md` and ENGINE.md Differential Evaluation. Specifically for this record: `cve_count_basis: exact`; `evaluator_model` recorded; `independence` set; `qa` all `pass`; `selection_basis` absent (pre-frame record — do not add). The Source Divergence section of the prior record is superseded by this evaluation's Scorecard; state the resolution in the Differential section without re-litigating which prior set was "correct".

---

## SPECIAL CONSIDERATIONS

### 1. Structural issues criterion — recurring code-execution root cause
Multiple 2025–2026 CVEs concern Python code passed to exec()/eval() or unauthenticated access to code-executing endpoints (validate/code, build endpoints). The engine evaluates the "same root cause recurring" criterion on the evidence and records elapsed times (first report → patch) without attributing motive.

### 2. Score change explanation
Because all six dimensions are re-evaluated against a fragmentary prior record, the total may move by ≥5 points in either direction. The Executive Summary must name the dimensions and evidence responsible. `previous_score: 30` is published alongside.

### 3. Disclosure layer
Triggers 0 / 1 / 2 / 3: None (IBM is not an Anthropic equity-holder; no known IBM–Anthropic material relationship — engine to state "None" after checking KNOWN_FACTS.md Anthropic Equity-Holder Records).

---

## KNOWN FACT CORRECTIONS

None applicable (no Langflow / DataStax / IBM entry in `KNOWN_FACTS.md`).

---

## OUTPUT RULES

Per `_template_update.md`: full English report (`Evaluation type: Update`) with Differential section and Evaluation History table (2026-03-13 initial 33 · 2026-03-24 update 30 · this update); Japanese summary; score tag line; complete front matter for `platforms/langflow.md` (`evaluated_at: 2026-03-13`, `updated_at: <completion date>`, `previous_evaluation_date: 2026-03-24`, `previous_score: 30`, `framework_version: v0.3.2`).

---

## REMINDERS

Public documentation only. Silence = 0. Positive findings alongside risks (e.g. advisory publication posture, patch availability). No intent attribution. The prior score is published, not smoothed.

---
# END OF PROMPT

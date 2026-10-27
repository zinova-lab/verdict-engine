# VERDICT Update Evaluation Prompt — #025 Composio

File: `prompts/025_composio_update_2026-10-27.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine`, pinned commit supplied at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | Composio |
| Slug | `composio` |
| Evaluation number | #025 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/composio.md` @ b62983f |
| Previous evaluation | 2026-03-30 · 46/85 (Layer 0) · Tier B · framework v0.3.1 · migrated capture |
| Recorded operator | Composio Inc. (San Francisco) |
| Recorded facts to re-verify | SOC 2 Type II + ISO 27001:2022; published DPA with sub-processor list; credential isolation architecture; recorded incident facts: CVE-2024-8864 (eval() code injection) and CVE-2025-56427 (directory traversal in the SDK; vendor recorded as non-responsive to disclosure). Recorded `cve_count_12mo: 1`, `max_cvss_12mo: null`. |

## TRIGGER

**T5 (interrupt lane, quarterly sweep)** — change of privacy policy publicly dated after the base. Fired by the quarterly sweep dry run 2026-10-27 (`docs/operations_sweep_procedure.md`; observations base `verdict-platforms` b62983f). Sweep rows are machine-matched candidates; attribution judgment belongs to this evaluation. T5 mandatory re-check: V, D; `independence` / `parent_entity` re-assessed; `KNOWN_FACTS.md` entry candidate when a published fact has become incorrect — subsumed by the full re-evaluation set in SCOPE except the KNOWN_FACTS staging, which stands on its own.

Sweep observations (2026-10-27):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| T5 | page-date | https://composio.dev/privacy | policy page dated 2026-10-17 > base 2026-03-30 | `evaluated_at=2026-03-30`, no update |
| T1 | repo-ghsa | GitHub security advisories (mapped repo) | 0 published advisories in trailing 12 months | — |
| T1 | nvd-keyword (working layer, non-product-scoped) | NVD query "Composio" | 2 CVEs mention "Composio" (120-day window) | cve_count_12mo=1 — candidates only; verify product scope per item |

No KEV match. Related-CVE candidate outside the sweep rows and NOT in the canonical record: CVE-2024-8953 — reported in the same eval() code-injection pattern as recorded CVE-2024-8864; handled under PUBLIC SOURCES TO CONSULT. Batch: batch 1 pilot 2 of 2 (SweepFormat-001) — T5-bearing pilot validating the template's T5 fold-in.

## SCOPE

- **T5 scope**: read the current privacy policy, ToS data clauses, DPA and sub-processor list in full (evaluation sequence step 4) and compare against the recorded D facts; re-assess `independence` / `parent_entity`.
- Beyond the T5 scope, **full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T)**. See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- The routine R/T/V re-check is folded into this interrupt update (review interval elapsed; ReviewCadence-002). Moot under full re-evaluation; recorded here as basis.
- The R-only escalation rule does not apply (already a full re-review).

## CARRY-FORWARD CHECKS

The base record is a migrated capture without per-dimension sources, so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, no per-dimension sources`.

## PUBLIC SOURCES TO CONSULT

- https://composio.dev/privacy (the T5 basis; dated 2026-10-17), the ToS data clauses, the DPA, and the sub-processor list (D criteria).
- Vendor security/compliance pages and official documentation for the recorded SOC 2 Type II and ISO 27001:2022 claims — re-verify against the vendor's official documentation, not recycled statements (QA §1).
- GitHub repository: security advisories (0 in the trailing window per the sweep), LICENSE and repository structure for Criterion-VSource-001 — Composio is an OSS SDK plus a hosted cloud: apply the full-OSS / open-core / source-available distinction to the complete evaluated product including the hosted control plane, and name the license of each part relied on.
- NVD and the CISA KEV catalog per ENGINE.md step 3:
  - CVE-2025-56427 — in the record; apply window entry per Attribution-CVE-002 from this update's date.
  - CVE-2024-8864 — in the record; 2024 disclosure, outside the trailing window: Incident Timeline history and the R structural-issues assessment, not the count.
  - CVE-2024-8953 — **related-CVE candidate, not in the canonical record**: reported as the same eval() code-injection pattern as CVE-2024-8864. Confirm in-session that it exists and is product-scoped to Composio (Attribution-CVE-001) before using it anywhere; if confirmed, it belongs to the Incident Timeline history and the R structural-issues (recurrence) assessment — never the trailing-12-month count (2024 disclosure). If not confirmed, omit it.
  - The 2 nvd-keyword candidates from the sweep are non-product-scoped: verify product scope per item before any enters the three R fields.
- PyPI / npm package pages and supply chain searches per step 3a (SDK/package vendor).
- MIT AI Agent Index and other third-party evaluations (step 5).
- If a policy page cannot be read in-session (client-side rendering), flag it; the operator pastes the page text in a follow-up message — re-score before delivery.

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-03-30 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-03-30, 46 |
| `evaluation_number` | #025, unchanged |
| `framework_version`, `target_version` | the framework version in force and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed (T5 mandatory); `unrecorded` not permitted in an update |
| `qa`, `evaluator_model` | full protocol result (`unresolved` not permitted; `flagged` allowed); model recorded exactly |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active, so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #025 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags.
- **Operator of record (ENGINE.md step 2)** — verify the recorded Composio Inc. (San Francisco) against the vendor's own current legal/company page; the public record wins over the recorded line. Record any correction with source in the Contextual Analysis.
- The recorded "vendor non-responsive to disclosure" finding is subject to QA §2 language rules: record elapsed time and outcomes; no intent attribution.
- The eval() code-injection recurrence question bears on the R structural-issues criterion; assess it on the confirmed record (CVE-2024-8864 plus CVE-2024-8953 only if confirmed per PUBLIC SOURCES TO CONSULT).

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No Composio entry exists at base. T5 basis applies: stage a KNOWN_FACTS entry candidate when a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_025_composio_update.md` — full English report (header type Update; Differential section with previous date/score and per-dimension state; Evaluation History table covering 2026-03-30 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/composio.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations.

Block 2 (Japanese summary) is an operator deliverable and is not committed to `evaluations/` (EvalFileScope-001).

## REMINDERS

- **Attribution-CVE-001** — product scope bound to `target_version`. CVE-less advisories (GHSA/PYSEC) are NOT counted in `cve_count_12mo`; dependency CVEs go to the Incident Timeline with the `dependency: <vendor/product>` marker only.
- **Attribution-CVE-002** — window entry by first public disclosure date; retroactive CVEs excluded from count/max and recorded as `retroactive CVE — first disclosed <id> <date>`; CVSS source order NVD v3.1 → CNA v3.1 → CISA-ADP v3.1 → CNA v3.0 → CNA v4.0, version stated; where a stated base score differs from its vector-computed score, record the computed score and note the stated value.
- **Criterion-VSource-001** — full OSS / open core / source-available distinction for V source code disclosure.
- Score movement ≥ 5 points: the Executive Summary names the dimensions and evidence that moved it.
- Full QA protocol (`QA.md`) before delivery, including the fresh-chat attestation line (QA 1.2: Type D stateless — nothing precedes the framework documents and this prompt).
- Apply ENGINE.md / QA.md / KNOWN_FACTS.md as loaded at invocation; apply, do not restate.

# END OF PROMPT

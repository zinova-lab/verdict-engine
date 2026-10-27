# VERDICT Update Evaluation Prompt — #028 Langroid

File: `prompts/028_langroid_update_2026-10-27.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine`, pinned commit supplied at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | Langroid |
| Slug | `langroid` |
| Evaluation number | #028 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/langroid.md` @ b62983f |
| Previous evaluation | 2026-03-31 · 34/85 (Layer 0) · Tier D · framework v0.3.1 · migrated capture |
| Recorded operator | `Prasad Chalasani (CMU) · Individual` (record original, verbatim) |
| Recorded R facts | `cve_count_12mo: 1`, `max_cvss_12mo: 9.4` (CVE-2026-25481, Critical RCE in TableChatAgent; recurring code injection pattern in the same component; maintainer self-published the CVE with fix available at disclosure; 48-hour response commitment; T 8/10) |

## TRIGGER

**T1 (interrupt lane, immediate)** — repo GHSA set diverges from the recorded R facts. Fired by the quarterly sweep dry run 2026-10-27 (`docs/operations_sweep_procedure.md`; observations base `verdict-platforms` b62983f). Sweep rows are machine-matched candidates; attribution judgment belongs to this evaluation. A CVE-less advisory with published severity ≥ 7.0 fires T1 (Attribution-CVE-001). Mandatory re-check: R — subsumed by the full re-evaluation set in SCOPE.

Sweep observations (2026-10-27):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| T1 | repo-ghsa | https://github.com/langroid/langroid/security/advisories | 15 published advisories in trailing 12 months; max CVSS 10.0 | cve_count_12mo=1, max_cvss_12mo=9.4 |
| T1 | nvd-keyword (working layer, non-product-scoped) | NVD query "Langroid" | 6 CVEs mention "Langroid" (120-day window) | — candidates only; verify product scope per item |

No KEV match. No T5 page-date signal. Batch: batch 1 pilot 1 of 2 (SweepFormat-001).

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- The routine R/T/V re-check is folded into this interrupt update (review interval elapsed; ReviewCadence-002). Moot under full re-evaluation; recorded here as basis.
- The R-only escalation rule does not apply (this is already a full re-review).

## CARRY-FORWARD CHECKS

The base record is a migrated capture without per-dimension sources, so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, no per-dimension sources`.

## PUBLIC SOURCES TO CONSULT

- https://github.com/langroid/langroid/security/advisories — the T1 basis set: triage every advisory for window entry (Attribution-CVE-002) and CVE presence (Attribution-CVE-001: CVE-less advisories are not counted in `cve_count_12mo`; they go to the Incident Timeline and are considered under T).
- NVD per ENGINE.md step 3 (`langroid CVE`, `langroid vulnerability 2026`, etc.) and the CISA KEV catalog. The 6 nvd-keyword candidates from the sweep are non-product-scoped: verify product scope per item before any enters the three R fields.
- PyPI `langroid` package page and supply chain searches per step 3a (SDK/package vendor).
- Repository README, LICENSE, release notes/changelog (V criteria; Criterion-VSource-001 — name the license of each part relied on).
- Privacy/data-handling documentation if any exists for the library and any hosted components (D). Silence is data: unconfirmed scores 0.
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-03-31 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-03-31, 34 |
| `evaluation_number` | #028, unchanged |
| `framework_version`, `target_version` | the framework version in force and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed; `unrecorded` not permitted in an update |
| `qa`, `evaluator_model` | full protocol result (`unresolved` not permitted; `flagged` allowed); model recorded exactly |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active, so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #028 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags.
- **Operator of record (ENGINE.md step 2)** — the record carries an individual operator, verbatim `Prasad Chalasani (CMU) · Individual`. Verify the current operator in-session; the public record wins over the recorded line; do not infer a legal entity where none is named. Record any correction with source in the Contextual Analysis.
- The recorded maintainer-response facts (self-published CVE with fix at disclosure; 48-hour response commitment) are re-verified, not assumed. Record elapsed time and outcomes; no intent attribution (QA §2).
- The recorded recurring code-injection pattern in TableChatAgent bears on the R structural-issues criterion; re-assess against the full trailing-window advisory set.

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No Langroid entry exists at base. Stage a KNOWN_FACTS entry candidate only if a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_028_langroid_update.md` — full English report (header type Update; Differential section with previous date/score and per-dimension state; Evaluation History table covering 2026-03-31 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/langroid.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations.

Block 2 (Japanese summary) is an operator deliverable and is not committed to `evaluations/` (EvalFileScope-001).

## REMINDERS

- **Attribution-CVE-001** — product scope bound to `target_version`. CVE-less advisories (GHSA/PYSEC) are NOT counted in `cve_count_12mo`; dependency CVEs go to the Incident Timeline with the `dependency: <vendor/product>` marker only.
- **Attribution-CVE-002** — window entry by first public disclosure date; retroactive CVEs excluded from count/max and recorded as `retroactive CVE — first disclosed <id> <date>`; CVSS source order NVD v3.1 → CNA v3.1 → CISA-ADP v3.1 → CNA v3.0 → CNA v4.0, version stated; where a stated base score differs from its vector-computed score, record the computed score and note the stated value.
- **Criterion-VSource-001** — full OSS / open core / source-available distinction for V source code disclosure.
- Score movement ≥ 5 points: the Executive Summary names the dimensions and evidence that moved it.
- Full QA protocol (`QA.md`) before delivery, including the fresh-chat attestation line (QA 1.2: Type D stateless — nothing precedes the framework documents and this prompt).
- Apply ENGINE.md / QA.md / KNOWN_FACTS.md as loaded at invocation; apply, do not restate.

# END OF PROMPT

# VERDICT Update Evaluation Prompt — #042 Cursor

File: `prompts/042_cursor_update_2026-10-31.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ 84b2fa9 — ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.
Batch: batch 1 (Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — Tranche A 5 of 6.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | Cursor |
| Slug | `cursor` |
| Evaluation number | #042 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/cursor.md` @ e9a717f (record last changed b12b6a0 (rank write-back only)) — read it in full before starting |
| Previous evaluation | 2026-04-03 · 47/85 (Layer 0) · Tier B · framework v0.3.1 · migrated capture (site-level `sources` only: changelog, data-use, docs, enterprise, privacy, security, trust center) |
| Recorded operator | `Anysphere · $29.3B` (display string); `independence: independent`; `target_version: 2.6.21 (latest stable as of evaluation date)` |
| Recorded R fields | `cve_count_12mo: 3` (basis `exact`), `max_cvss_12mo: 8.6`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; R 8/20, D 11/15 |
| Recorded facts to re-verify | 3 MCP-related CVEs (CVSS 8.6 highest) described as a structural trust-model pattern; "94+ inherited Chromium CVEs" (Electron build); SOC 2 Type II; Privacy Mode zero-retention + no training; Workspace Trust disabled by default; enterprise SSO / SCIM / RBAC. The record names no CVE IDs — a prior-record omission to state in the Differential section. |

## TRIGGER

**T5 (interrupt lane, quarterly sweep)** — change of privacy policy publicly dated after the base. Fired by the quarterly sweep 2026-10-27 (`docs/operations_sweep_procedure.md` v1.2.3). T5 mandatory re-check: V, D; `independence` / `parent_entity` re-assessed; `KNOWN_FACTS.md` entry candidate when a published fact has become incorrect — subsumed by the full re-evaluation set in SCOPE except the KNOWN_FACTS staging, which stands on its own. No T1 row: the product is proprietary and has no mapped repository for GHSA; the trailing-12-month CVE set is enumerated on NVD (see PUBLIC SOURCES).

Sweep observations (2026-10-27; SweepFormat-001; observations base `verdict-platforms` e9a717f; recorded values are the base record's):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| T5 | page-date | https://cursor.com/privacy | policy page dated 2026-10-11 > base 2026-04-03 | `evaluated_at: 2026-04-03`, no update |
| T1 | nvd-keyword (working layer, non-product-scoped) | NVD query "Cursor" | 87 CVEs mention "Cursor" (119-day window) — the term is generic | `cve_count_12mo: 3` — candidates only; verify product scope per item (Anysphere / Cursor IDE CPE or vendor advisory) |

No KEV match. No repo-GHSA basis (no repository map). No dormancy signal (hosted / desktop product with an active changelog).

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- Routine lane: not due (365-day interval, ReviewCadence-002; sweep 2026-10-27: none of the batch-1 records is due within 100 days). R, T and V are re-evaluated here regardless, as part of the full set; recorded as basis.
- The R-only escalation rule does not apply (already a full re-review).
- This update also resolves the migrated `qa` state (QAConvention-001 → full protocol result).
- **T5 scope**: read https://cursor.com/privacy (dated 2026-10-11) in full with https://cursor.com/data-use, the terms, DPA and sub-processor list, and compare against the recorded D facts (Privacy Mode, zero retention, no training, sub-processor transparency).
- **Attribution**: Cursor-scoped CVEs are those whose affected product is the Cursor IDE (Anysphere) as bound by `target_version`. Chromium / Electron / VS Code-upstream CVEs are dependency CVEs → Incident Timeline with `dependency: <vendor/product>` and Contextual Analysis; they do not enter the three R fields. Record the recorded "94+ Chromium CVEs" claim as a dependency-class statement if it is re-confirmed, with the Electron version shipped.


## CARRY-FORWARD CHECKS

The base record carries `sources` as a site- / organization-level URL list with no per-dimension citations, so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22; precedent #031 prompt of 2026-09-24). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, site-level sources only`.

## PUBLIC SOURCES TO CONSULT

- https://cursor.com/privacy (the T5 basis; dated 2026-10-11), https://cursor.com/data-use, terms of service, DPA, sub-processor list, https://cursor.com/security, https://trust.cursor.com/ (base `homepage`; Trust Center content may be client-rendered or gated — state what could be read; OperatorInput-001).
- NVD per ENGINE.md step 3 (`Cursor IDE CVE`, `Anysphere CVE`, `Cursor vulnerability 2026`) and the CISA KEV JSON; vendor advisories at https://cursor.com/changelog and the security page. The 87 nvd-keyword candidates are overwhelmingly unrelated ("cursor" is a generic term): verify product scope per item by CPE / affected product.
- Third-party research that disclosed the recorded MCP CVEs (Check Point, Oasis, BackSlash and others as located in-session) — for disclosure dates, fix versions and elapsed times; the vendor's own bulletin for each (SourceCoverage-001).
- https://cursor.com/changelog and release notes for V (target version on the update date; Electron / VS Code base versions) and for the recorded Workspace Trust default.
- https://cursor.com/enterprise and https://cursor.com/docs — I and C re-evaluation (agent mode approvals, permission model, sandboxing of agent terminal execution, Privacy Mode scope).
- Operator of record: Anysphere's own legal pages (terms / privacy name the legal entity — Anysphere, Inc. appears in public references; confirm on the vendor's pages); funding and valuation statements from the parties to the rounds for the disclosure layer.
- Certifications claimed (SOC 2 Type II) — re-verify against the vendor's official documentation; SOC 2 report availability (publicly available vs customers-only) decides the V score.
- Supply chain searches per step 3a (desktop installer distribution, extension marketplace, npm packages published by the vendor).
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-04-03 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-04-03, 47 |
| `evaluation_number` | #042, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed; `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active (sweep 2026-10-27: no dormancy signal), so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #042 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set"). Cursor's product-level use of Anthropic models is a non-trigger (model-provider relationship); record it in the product-level paragraph, separate from any corporate-level disclosure (ENGINE.md, distinct-paragraphs rule). Read Anysphere's round statements for any set member with lead / strategic designation or a USD 100M+ position.
- **Operator of record (ENGINE.md step 2)** — the recorded line is a valuation display string. Set `operator` to the legal entity named on the vendor's own legal pages; `independence` re-assessed.
- The recorded "structural trust model pattern" across the MCP CVEs bears on the R structural-issues criterion; re-assess on the confirmed Cursor-scoped set.

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No Cursor entry exists at base. T5 basis applies: stage a KNOWN_FACTS entry candidate when a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_042_cursor_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state and prior-record omissions stated as facts; Evaluation History table covering 2026-04-03 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/cursor.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it).

Block 2 (Japanese summary) is an operator deliverable and is not committed to `evaluations/` (EvalFileScope-001).

## REMINDERS

- **Attribution-CVE-001** — product scope bound to `target_version`. CVE-less advisories (GHSA/PYSEC) are NOT counted in `cve_count_12mo`; dependency CVEs go to the Incident Timeline with the `dependency: <vendor/product>` marker only; a dependency CVE exploited against deployments is not a supply chain compromise unless the vendor's own package, account or build pipeline was compromised.
- **Attribution-CVE-002** — window entry by first public disclosure date; retroactive CVEs excluded from count/max and recorded as `retroactive CVE — first disclosed <id> <date>`; CVSS source order NVD v3.1 → CNA v3.1 → CISA-ADP v3.1 → CNA v3.0 → CNA v4.0, version stated; where a stated base score differs from its vector-computed score, record the computed score and note the stated value.
- **Criterion-VSource-001** — full OSS / open core / source-available distinction for V source code disclosure; name the license of each part relied on.
- **OperatorOfRecord-001** — the operator of record is the legal entity named on the vendor's own current legal or company pages; prompt lines, repository accounts, package metadata and copyright notices are starting points only; infer no entity where none is named.
- **SourceCoverage-001 / OperatorInput-001** — consult the vendor's own security or incident bulletins (homepage blog, /security, /trust, status page); a page the session tools cannot read is stated as unread, never scored as silence; operator-supplied rendered text is recorded with its retrieval date in the Differential section.
- Score movement ≥ 5 points: the Executive Summary names the dimensions and evidence that moved it.
- Full QA protocol (`QA.md`) before delivery, including the fresh-chat attestation line (QA 1.2: Type D stateless — nothing precedes the framework documents and this prompt).
- Apply ENGINE.md / QA.md / KNOWN_FACTS.md as loaded at invocation; apply, do not restate.

# END OF PROMPT

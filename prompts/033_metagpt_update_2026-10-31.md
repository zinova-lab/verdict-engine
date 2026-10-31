# VERDICT Update Evaluation Prompt — #033 MetaGPT

File: `prompts/033_metagpt_update_2026-10-31.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ 84b2fa9 — ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.
Batch: batch 1 (Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — Tranche A 4 of 6.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | MetaGPT |
| Slug | `metagpt` |
| Evaluation number | #033 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/metagpt.md` @ e9a717f (record last changed 633a9da) — read it in full before starting |
| Previous evaluation | 2026-03-31 · 23/85 (Layer 0) · Tier D · framework v0.3.1 · migrated capture (site-level `sources` only: repo, releases) |
| Recorded operator | `DeepWisdom · Shenzhen, China` (display string); `independence: independent`; `target_version: v0.8.2 (PyPI) / v1.1 (GitHub main)` |
| Recorded R fields | `cve_count_12mo: 4` (basis `exact`), `max_cvss_12mo: 9.8`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; R 4/20, D 0/15, T 1/10 |
| Recorded facts to re-verify | four CVEs in the trailing window including two CVSS 9.8 Critical RCEs (deserialization + code injection) recorded as unpatched; vendor recorded as "unresponsive to multiple disclosure attempts"; no privacy policy, no certifications; ICLR 2024 publication. The record names no CVE IDs — a prior-record omission to state in the Differential section. |

## TRIGGER

**Scheduled batch-1 differential — no interrupt trigger observed.** The quarterly sweep 2026-10-27 produced no public-layer row for this record (no repo-GHSA advisories at the mapped repository, no KEV match, no T5 page-date signal). The update runs under the batch-1 definition (LayerC-Triage-001: `cve_count_12mo > 0` in a migrated capture) as authorized by Strategy (Batch1-TrancheA-Authorize-2026-10-31-A1): the recorded CVE set was captured without IDs or per-dimension sources and is re-verified in full. Lane recorded as `Routine (batch-1 scheduled; interval not elapsed)` in the Differential section.

Sweep observations (2026-10-27; SweepFormat-001; observations base `verdict-platforms` e9a717f; recorded values are the base record's):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| — | repo-ghsa | https://github.com/FoundationAgents/MetaGPT/security/advisories | no published advisories in trailing 12 months | `cve_count_12mo: 4`, `max_cvss_12mo: 9.8` — the recorded CVEs were not published as repository advisories; locate them on NVD / third-party CNAs |
| — | nvd-keyword (working layer, non-product-scoped) | NVD query "MetaGPT" | 5 CVEs mention "MetaGPT" (119-day window) | candidates only; verify product scope per item |

No KEV match. No dormancy signal (repository activity observed; confirm in-session).

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- Routine lane: not due (365-day interval, ReviewCadence-002; sweep 2026-10-27: none of the batch-1 records is due within 100 days). R, T and V are re-evaluated here regardless, as part of the full set; recorded as basis.
- The R-only escalation rule does not apply (already a full re-review).
- This update also resolves the migrated `qa` state (QAConvention-001 → full protocol result).
- The absence of repository advisories alongside four recorded CVEs is itself a T finding (CVE publication posture: who published the CVEs — a third-party CNA such as VulDB or huntr, not the vendor?). Record the CNA for each CVE.


## CARRY-FORWARD CHECKS

The base record carries `sources` as a site- / organization-level URL list with no per-dimension citations, so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22; precedent #031 prompt of 2026-09-24). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, site-level sources only`.

## PUBLIC SOURCES TO CONSULT

- NVD per ENGINE.md step 3 (`MetaGPT CVE`, `MetaGPT vulnerability 2026`, `DeepWisdom`, `geekan`) — enumerate the trailing-12-month set with IDs, CNA, CVSS source (Attribution-CVE-002 order) and patch status; the CISA KEV JSON. The 5 nvd-keyword candidates are non-product-scoped: verify product scope per item.
- https://github.com/FoundationAgents/MetaGPT (formerly geekan/MetaGPT — record the rename with date), /security, /releases, LICENSE (MIT), SECURITY.md if present, issues referencing the CVEs (patch status, maintainer responses — record dates and outcomes, QA §2).
- PyPI `metagpt` release history (recorded `v0.8.2` vs GitHub main `v1.1`) — re-bind `target_version`; supply chain searches per step 3a.
- Operator of record: DeepWisdom's own legal / company pages (https://www.deepwisdom.ai or as located in-session), the MetaGPT docs site, the MGX product pages if the hosted product is within scope — infer no legal entity where none is named (OperatorOfRecord-001).
- Privacy policy / terms for any hosted surface (recorded D 0/15 and "no privacy policy" — re-verify; silence is data).
- Vendor security or incident bulletins (blog, /security) — SourceCoverage-001; "none located" is a valid recorded result.
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-03-31 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-03-31, 23 |
| `evaluation_number` | #033, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed; `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active (sweep 2026-10-27: no dormancy signal), so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #033 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set").
- **Operator of record (ENGINE.md step 2)** — the recorded line is a display string; set `operator` to the legal entity named on the vendor's own pages, or record the publishing name and state that no legal entity is named.
- The recorded "vendor unresponsive" finding is subject to QA §2: record disclosure dates, elapsed time and patch status with sources; no intent attribution. The recorded "unpatched" status is re-verified per CVE on the update date.
- The two recorded Critical RCEs (deserialization + code injection) bear on the R structural-issues criterion; assess recurrence on the confirmed set.

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No MetaGPT entry exists at base. Stage a KNOWN_FACTS entry candidate only if a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_033_metagpt_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state and prior-record omissions stated as facts; Evaluation History table covering 2026-03-31 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/metagpt.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it).

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

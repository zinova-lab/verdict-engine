# VERDICT Update Evaluation Prompt — #051 Browser Use

File: `prompts/051_browser-use_update_2026-11-06.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ the commit that adds this prompt — the Tranche B set, base 94ada9d, which also carries SupplyChain-Criterion-001 / -001a and Convention-CVEReserved-001 / -001b; ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) per the Operations invocation guide delivered with this set (README_APPLY); not restated in this prompt.
Batch: batch 1 (scope 27; Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — Tranche B 10 of 14.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | Browser Use |
| Slug | `browser-use` |
| Evaluation number | #051 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/browser-use.md` @ 612fb99 (record last changed 9eab0a5) — read it in full before starting |
| Previous evaluation | 2026-04-07 · 40/85 (Layer 0) · Tier C · framework v0.3.1 · migrated capture (site-level `sources`: homepage, pricing docs, repository) |
| Recorded operator | `Browser Use Inc. · Y Combinator W25` (card) / `Browser Use (SF)` (meta); `independence: independent`; `target_version: browser-use (Python library, current production; cloud.browser-use.com cloud offering)` |
| Recorded R fields | `cve_count_12mo: 1` (basis `exact`), `max_cvss_12mo: 9.3`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; V 14 · R 9 · D 4 · I 4 · C 3 · T 6 |
| Recorded facts to re-verify | CVE-2025-47241 (CVSS 9.3): `allowed_domains` bypass, patched in v0.1.45; MIT-licensed Python library; Y Combinator W25, USD 17M seed (Felicis); cloud terms recorded as carrying a broad usage-data clause. |

## TRIGGER

**Scheduled batch-1 differential (Tranche B).** The record entered batch 1 under LayerC-Triage-001 (recorded `cve_count_12mo: 1`, basis `exact`) at the quarterly sweep 2026-10-27 (`docs/operations_sweep_procedure.md` v1.2.3); Strategy fixed batch 1 at 27 records (Batch1-TrancheA-Authorize-2026-10-31-A1). Lane recorded as `Routine (batch-1 scheduled; interval not elapsed)` in the Differential section unless a sweep row fires an interrupt trigger.

**Sweep observations (2026-10-27; SweepFormat-001 public layer) are not reproduced in this prompt.** Operations supplies this slug's public-layer rows (lane / basis / source / observed / recorded) together with the CISA KEV JSON check as Message 3 operator input; the Differential section records them as operator input with their date (OperatorInput-001). Rows are machine-matched candidates; attribution judgment belongs to this evaluation. A T1, T2 or T5 row is applied as a fired trigger with its mandatory re-check; a KEV row on a dependency CVE does not fire T2 (Attribution-CVE-001). Working-layer nvd-keyword counts, if supplied, are candidates only — verify product scope per item.

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- Routine lane: not due (365-day interval, ReviewCadence-002). R, T and V are re-evaluated here regardless, as part of the full set; recorded as basis.
- The R-only escalation rule does not apply (already a full re-review).
- This update also resolves the migrated `qa` state (QAConvention-001 → full protocol result).
- **Product scope**: the browser-use library (github.com/browser-use/browser-use, PyPI `browser-use`) and Browser Use Cloud — state which surfaces `target_version` binds; score D on the cloud's own documents.
- **CVE-2025-47241**: confirm its first public disclosure date for window entry under the new window.

## CARRY-FORWARD CHECKS

The base record is a migrated capture without per-dimension citations (`sources` is a site-level list (homepage, pricing docs, repository)), so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, site-level sources only`.

## PUBLIC SOURCES TO CONSULT

- https://github.com/browser-use/browser-use — /security/advisories, SECURITY.md, LICENSE, releases.
- Browser Use Cloud legal pages: terms (the usage-data clause read in full), privacy policy, DPA and sub-processors if published; documentation for domain restrictions, sensitive-data handling and human confirmation (I, C).
- Funding statements of the parties to the seed round (Trigger2-Designation-001).
- Supply chain searches per step 3a (PyPI `browser-use`, npm SDK if published).
- Vendor security or incident bulletins (SourceCoverage-001): fetch directly any trust, security or status URL named in SECURITY.md, the docs or the legal pages; web search is the fallback, not the gate (SourceCoverage-002). "None located" is a valid recorded result.
- NVD per ENGINE.md step 3 and the CISA KEV catalog; when the KEV JSON feed is unreadable in-session, use the catalog's vendor filter and per-CVE trackers and record that Operations supplies the JSON check (catalogVersion, entry count, per-CVE result) at Message 3 as operator input.
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-04-07 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-04-07, 40 |
| `evaluation_number` | #051, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact`. A counted CVE ID whose CVE List record is not published carries "CVE List record: RESERVED as of YYYY-MM-DD; counted on CNA-advisory basis (Convention-CVEReserved-001)" |
| `supply_chain_compromise_12mo` | recomputed over the window; true only on public confirmation that an unauthorized write occurred to the vendor's own package, account, build pipeline or distribution endpoint (SupplyChain-Criterion-001 / -001a), with the confirming source cited; a vulnerability that would permit such a write is scored under R's CVE criteria and recorded as "vulnerability only; no publicly confirmed write (SupplyChain-Criterion-001a)" |
| `independence`, `parent_entity` | re-assessed against the schema enum (`independent` / `parent` / `subsidiary`); `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen: author it only if the in-session dormancy test (ENGINE.md Layer C) finds 12 consecutive months without public release, commit or changelog activity for the target as bound by `target_version`; otherwise omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #051 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). A differential applies the disclosure layer in force (forward-only clause), whatever the series number. Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set").
- **Operator of record (ENGINE.md step 2)** — the card and meta lines differ; set `operator` to the legal entity on the vendor's own legal pages, or record the publishing name and state that none is named.
- The cloud usage-data clause bears on D (AI training use, data minimization): quote it under the 15-word limit and score what it states.

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No Browser Use entry exists at base. Stage a KNOWN_FACTS entry candidate only if a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_051_browser-use_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state, carry-forward checks or the reason none were possible, and prior-record omissions stated as facts; Evaluation History table covering 2026-04-07 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/browser-use.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it; no KEV wording for a dependency CVE).

Block 2 (Japanese summary) is an operator deliverable and is not committed to `evaluations/` (EvalFileScope-001).

## REMINDERS

- **Attribution-CVE-001** — product scope bound to `target_version`. CVE-less advisories (GHSA/PYSEC) are NOT counted in `cve_count_12mo`; dependency CVEs go to the Incident Timeline with the `dependency: <vendor/product>` marker only; a dependency CVE exploited against deployments is not a supply chain compromise unless the vendor's own package, account or build pipeline was compromised (SupplyChain-Criterion-001 / -001a).
- **Convention-CVEReserved-001** — an advisory that carries a CNA-assigned CVE ID is not CVE-less: the ID counts when the CNA's advisory and CNA CVSS vector are published, whatever the CVE List / NVD state; bare RESERVED is silence; REJECTED is removed with the rejection recorded; DISPUTED stays counted, the dispute is recorded and the disputing party's position represented, source-cited, without adjudication; the as-of note accompanies each counted ID whose CVE List record is not published.
- **SupplyChain-Criterion-001 / -001a** — an unauthorized write to the vendor's own package, account, build pipeline or distribution endpoint is a compromise whether or not a payload reached users; "Responded ≤7d" runs from the compromise (or its public confirmation) to containment as stated by the vendor; a vulnerability that would permit such a write, without public confirmation that a write occurred, is not a compromise; a blocked or attempted write is not a write.
- **Attribution-CVE-002** — window entry by first public disclosure date; retroactive CVEs excluded from count/max and recorded as `retroactive CVE — first disclosed <id> <date>`; CVSS source order NVD v3.1 → CNA v3.1 → CISA-ADP v3.1 → CNA v3.0 → CNA v4.0, version stated; where a stated base score differs from its vector-computed score, record the computed score and note the stated value.
- **Criterion-VSource-001** — full OSS / open core / source-available distinction for V source code disclosure; name the license of each part relied on.
- **OperatorOfRecord-001** — the operator of record is the legal entity named on the vendor's own current legal or company pages; prompt lines, repository accounts, package metadata and copyright notices are starting points only; infer no entity where none is named.
- **SourceCoverage-001 / -002 / OperatorInput-001** — consult the vendor's own security or incident bulletins; fetch named trust / security / status URLs directly; a page the session tools cannot read is stated as unread, never scored as silence; operator-supplied rendered text is recorded with its retrieval date in the Differential section. A document released only on request or through a contact flow is not public (Absolute Rules 1–2) and is not operator input.
- Comparative and superlative claims carried in the base record ("highest … in this index", "first …", "only …") are not carried forward: state the platform's own facts (Absolute Rule 7, QA §2).
- Score movement ≥ 5 points: the Executive Summary names the dimensions and evidence that moved it.
- Full QA protocol (`QA.md`) before delivery, including the fresh-chat attestation line (QA 1.2: Type D stateless — nothing precedes the framework documents and this prompt).
- Apply ENGINE.md / QA.md / KNOWN_FACTS.md as loaded at invocation; apply, do not restate.

# END OF PROMPT

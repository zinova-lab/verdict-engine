# VERDICT Update Evaluation Prompt — #065 Weaviate

File: `prompts/065_weaviate_update_2026-11-06.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ the commit that adds this prompt — the Tranche B set, base 94ada9d, which also carries SupplyChain-Criterion-001 / -001a and Convention-CVEReserved-001 / -001b; ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) per the Operations invocation guide delivered with this set (README_APPLY); not restated in this prompt.
Batch: batch 1 (scope 27; Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — Tranche B 12 of 14.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | Weaviate |
| Slug | `weaviate` |
| Evaluation number | #065 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/weaviate.md` @ 612fb99 (record last changed 633a9da) — read it in full before starting |
| Prior evaluation report | `verdict-platforms/evaluations/065_weaviate.md` @ 612fb99 — per-dimension citations; the carry-forward basis |
| Previous evaluation | 2026-05-15 · 62/85 (Layer 0) · Tier A · framework v0.3.1-final (alias of v0.3.1) · engine-era record, `qa` pass ×3, `evaluator_model: unrecorded` |
| Recorded operator | `Weaviate B.V.` (Amsterdam, NL); `independence: independent`; `target_version: Weaviate Database 1.33.x / 1.34.0` |
| Recorded R fields | `cve_count_12mo: 2` (basis `exact`), `max_cvss_12mo: 8.7`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; V 16 · R 14 · D 13 · I 6 · C 6 · T 7 |
| Recorded facts to re-verify | CVE-2025-67818 (backup ZipSlip path traversal; CVSS v4.0 8.7 / v3.1 7.2) and CVE-2025-67819 (shard-movement path traversal; v3.1 4.9), fixed in 1.30.20 / 1.31.19 / 1.32.16 / 1.33.4; BSD 3-Clause core; SOC 2 Type II and ISO 27001:2022; DPA v1.4 (February 2026) stating no model training without documented customer instruction; OSS telemetry on by default; generative modules in-process without a documented egress allowlist; audit evidence gated behind the trust portal. **Prior-record point to state as a fact**: the recorded `max_cvss_12mo: 8.7` is the CVSS v4.0 score; the Attribution-CVE-002 source order (2026-09-25, after the base) ranks a v3.1 score ahead of v4.0. |

## TRIGGER

**Scheduled batch-1 differential (Tranche B).** The record entered batch 1 under LayerC-Triage-001 (recorded `cve_count_12mo: 2`, basis `exact`) at the quarterly sweep 2026-10-27 (`docs/operations_sweep_procedure.md` v1.2.3); Strategy fixed batch 1 at 27 records (Batch1-TrancheA-Authorize-2026-10-31-A1). Lane recorded as `Routine (batch-1 scheduled; interval not elapsed)` in the Differential section unless a sweep row fires an interrupt trigger.

**Sweep observations (2026-10-27; SweepFormat-001 public layer) are not reproduced in this prompt.** Operations supplies this slug's public-layer rows (lane / basis / source / observed / recorded) together with the CISA KEV JSON check as Message 3 operator input; the Differential section records them as operator input with their date (OperatorInput-001). Rows are machine-matched candidates; attribution judgment belongs to this evaluation. A T1, T2 or T5 row is applied as a fired trigger with its mandatory re-check; a KEV row on a dependency CVE does not fire T2 (Attribution-CVE-001). Working-layer nvd-keyword counts, if supplied, are candidates only — verify product scope per item.

## SCOPE

- **Lane:** `Routine (batch-1 scheduled; interval not elapsed)` unless a sweep row supplied at Message 3 fires an interrupt trigger, which then adds its mandatory re-check (ENGINE.md Layer C table).
- **Mandatory re-evaluation:** R, T, V (routine scope). `differential.r`, `.t`, `.v` = `re-evaluated`.
- **Carry-forward candidates:** D, I, C — the prior report carries per-dimension citations, so the four conditions can be tested (CARRY-FORWARD CHECKS).
- **Escalation:** if the change in R alone moves the total by 3 points or more, every dimension is re-evaluated with no carry-forward before publication (ENGINE.md score-change rule; precedent #064 update).
- The base `qa` state is a full protocol result (pass ×3); this update records its own full protocol result.
- **Product scope**: Weaviate Database (github.com/weaviate/weaviate) and Weaviate Cloud as bound by `target_version`; client libraries and modules count only where named as the affected product.
- **R fields**: recompute `max_cvss_12mo` under the Attribution-CVE-002 source order; both recorded CVEs (December 2025) fall inside the new window.

## CARRY-FORWARD CHECKS

The prior evaluation report `verdict-platforms/evaluations/065_weaviate.md` @ 612fb99 carries per-dimension citations (the published `platforms/weaviate.md` has no Full Evaluation embed; the report is the carry-forward basis — read it in full). For each candidate dimension, check the URLs below, which are the ones the prior report cited for that dimension, and record per URL in the Differential section: resolves (yes/no; new location), last-updated or effective date vs. 2026-05-15, and whether any release note, announcement or incident in the window touches the dimension (conditions 1–4). Carry a dimension forward only when every condition holds; otherwise re-evaluate it. If the full re-review rule is triggered (SCOPE), record the checks for the audit trail and re-evaluate all six (precedent: #064 update, 2026-09-25).

### D
- https://weaviate.io/dpa
- https://weaviate.io/subprocessors
- https://docs.weaviate.io/deploy/configuration/telemetry

### I
- https://docs.weaviate.io/weaviate/configuration/rbac
- https://docs.weaviate.io/weaviate/configuration/rbac/manage-users
- https://docs.weaviate.io/agents
- https://weaviate.io/service/service-schedule

### C
- https://docs.weaviate.io/deploy/configuration
- https://docs.weaviate.io/weaviate/tutorials/rbac
- https://weaviate.io/blog/weaviate-multi-tenancy-architecture-explained

## PUBLIC SOURCES TO CONSULT

- https://github.com/weaviate/weaviate/security/advisories, SECURITY.md, LICENSE (BSD 3-Clause), releases.
- NVD records for CVE-2025-67818 / CVE-2025-67819 and any later ID; CNA and score versions.
- Weaviate security / trust portal and status page (T; state what is gated).
- Weaviate legal pages: privacy policy, terms, service schedule, DPA, sub-processors; imprint / company page for the operator of record.
- Funding statements of the parties (Trigger2-Designation-001) for the disclosure layer.
- Supply chain searches per step 3a (PyPI `weaviate-client`, npm `weaviate-client`, container images).
- Vendor security or incident bulletins (SourceCoverage-001): fetch directly any trust, security or status URL named in SECURITY.md, the docs or the legal pages; web search is the fallback, not the gate (SourceCoverage-002). "None located" is a valid recorded result.
- NVD per ENGINE.md step 3 and the CISA KEV catalog; when the KEV JSON feed is unreadable in-session, use the catalog's vendor filter and per-CVE trackers and record that Operations supplies the JSON check (catalogVersion, entry count, per-CVE result) at Message 3 as operator input.
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-05-15 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-05-15, 62 |
| `evaluation_number` | #065, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact`. A counted CVE ID whose CVE List record is not published carries "CVE List record: RESERVED as of YYYY-MM-DD; counted on CNA-advisory basis (Convention-CVEReserved-001)" |
| `supply_chain_compromise_12mo` | recomputed over the window; true only on public confirmation that an unauthorized write occurred to the vendor's own package, account, build pipeline or distribution endpoint (SupplyChain-Criterion-001 / -001a), with the confirming source cited; a vulnerability that would permit such a write is scored under R's CVE criteria and recorded as "vulnerability only; no publicly confirmed write (SupplyChain-Criterion-001a)" |
| `independence`, `parent_entity` | re-assessed against the schema enum (`independent` / `parent` / `subsidiary`); `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen: author it only if the in-session dormancy test (ENGINE.md Layer C) finds 12 consecutive months without public release, commit or changelog activity for the target as bound by `target_version`; otherwise omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #065 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). A differential applies the disclosure layer in force (forward-only clause), whatever the series number. Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set"). Read the funding statements of the parties to each round for set members at lead / strategic designation, a board seat or a USD 100M+ position. The base record's product-level paragraph (the `generative-anthropic` module) remains a separate product-level paragraph, re-verified.
- **Operator of record (ENGINE.md step 2)** — confirm Weaviate B.V. on the vendor's own legal pages; `independence` re-assessed.
- Audit evidence gated behind the trust portal is stated as gated; a document released only on request is not public data (Absolute Rules 1–2).

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No Weaviate entry exists at base. Stage a KNOWN_FACTS entry candidate only if a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_065_weaviate_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state, carry-forward checks or the reason none were possible, and prior-record omissions stated as facts; Evaluation History table covering 2026-05-15 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/weaviate.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it; no KEV wording for a dependency CVE).

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

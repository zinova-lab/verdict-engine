# VERDICT Update Evaluation Prompt — #062 LangSmith

File: `prompts/062_langsmith_update_2026-10-31.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ 84b2fa9 — ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.
Batch: batch 1 (Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — Tranche A 6 of 6.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | LangSmith |
| Slug | `langsmith` |
| Evaluation number | #062 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/langsmith.md` @ e9a717f (record last changed 633a9da) — read it in full before starting |
| Previous evaluation | 2026-05-12 · 55/85 (Layer 0) · Tier A · framework v0.3.1-final (alias of v0.3.1) · engine-era record published as a summary capture: `qa` pass, `evaluator_model: unrecorded`, `sources` site-level only (no Full Evaluation embed, no per-dimension citations) |
| Recorded operator | `LangChain, Inc.` (Delaware C-corporation, San Francisco); `independence: independent`; `target_version: null` |
| Recorded R fields | `cve_count_12mo: 5` (basis `exact`), `max_cvss_12mo: null`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; R 9/20, T 7/10 |
| Recorded facts to re-verify | five vulnerabilities in the recorded window: "AgentSmith" CVSS 8.8 (Prompt Hub proxy provider URL — no CVE ID in the record), CVE-2026-25750 CVSS 8.5 (Studio baseUrl account takeover), CVE-2026-25528 CVSS 6.4 (SDK distributed-tracing SSRF), CVE-2026-40190 CVSS 5.6 (lodash prototype pollution — a dependency-class finding), CVE-2026-41182 (streaming-event redaction bypass); three share a URL-validation root cause; SOC 2 Type II (extended to LangGraph Platform / LangSmith Deployment August 2025), GDPR, HIPAA at Enterprise tier, US / EU regions, self-hosted Enterprise, no-training commitment in the Pricing FAQ; Trust Center gated behind authenticated request. **Prior-record inconsistencies to state as facts in the Differential section**: `max_cvss_12mo: null` beside a count of 5 and a recorded 8.8 / 8.5; the count of 5 includes a CVE-less item (AgentSmith) and a dependency item (lodash), which under Attribution-CVE-001 are not counted; the record names four CVE IDs. |

## TRIGGER

**T5 (interrupt lane, quarterly sweep)** — change of terms of service publicly dated after the base. Fired by the quarterly sweep 2026-10-27 (`docs/operations_sweep_procedure.md` v1.2.3). T5 mandatory re-check: V, D; `independence` / `parent_entity` re-assessed; `KNOWN_FACTS.md` entry candidate when a published fact has become incorrect — subsumed by the full re-evaluation set in SCOPE except the KNOWN_FACTS staging, which stands on its own. The privacy-policy page carries a visible date of 2024-04-28 with an HTTP Last-Modified header of 2026-10-22: the visible page date governs the T5 test (no fire on that page); record both and compare the text against the recorded D facts regardless. No T1 row: the sweep had no repository map for this record; the engine enumerates GHSA for github.com/langchain-ai/langsmith-sdk itself (see PUBLIC SOURCES).

Sweep observations (2026-10-27; SweepFormat-001; observations base `verdict-platforms` e9a717f; recorded values are the base record's):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| T5 | page-date | https://www.langchain.com/terms-of-service | page dated 2026-06-02 > base 2026-05-12 (Last-Modified 2026-10-22) | `evaluated_at: 2026-05-12`, no update |
| T5 | page-date | https://www.langchain.com/privacy-policy | page dated 2024-04-28 (Last-Modified 2026-10-22) — no fire on page date | — |
| T1 | nvd-keyword (working layer, non-product-scoped) | NVD query "LangSmith" | 1 CVE mentions "LangSmith" (119-day window) | candidates only; verify product scope |

No KEV match. No dormancy signal (hosted product with a public changelog).

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- Routine lane: not due (365-day interval, ReviewCadence-002; sweep 2026-10-27: none of the batch-1 records is due within 100 days). R, T and V are re-evaluated here regardless, as part of the full set; recorded as basis.
- The R-only escalation rule does not apply (already a full re-review).
- This update also resolves the migrated `qa` state (QAConvention-001 → full protocol result).
- **T5 scope**: read the terms of service (dated 2026-06-02), the privacy policy, the DPA and the sub-processor list in full and compare against the recorded D facts; re-assess `independence` / `parent_entity`.
- **Product scope**: LangSmith platform (SaaS US / EU, self-hosted Enterprise) and the SDKs published from github.com/langchain-ai/langsmith-sdk. LangChain framework advisories belong to #011 and LangGraph library advisories to #046; LangGraph Platform / LangSmith Deployment is the hosted part shared with #046 — state which series carries a given hosted-platform advisory and avoid double-counting (record the allocation rule used).
- **R fields**: recompute `cve_count_12mo` on CVE-bearing, product-scoped items only (Attribution-CVE-001); set `max_cvss_12mo` from the counted set (Attribution-CVE-002 source order); AgentSmith (CVE-less, if still so) → Incident Timeline and T; lodash CVE-2026-40190 → Incident Timeline with `dependency: lodash/lodash` unless the vendor's own package was the affected product per NVD.


## CARRY-FORWARD CHECKS

The base record is an engine-era summary capture: `sources` is a site-level URL list and the published file carries no Full Evaluation embed, so no per-dimension citation can be re-checked and carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22). Record the determination per dimension in the report's Differential section: `re-evaluated — summary capture, site-level sources only`. The operator copy of the #062 report, if it exists in `evaluations/`, may be read for context but is not a carry-forward basis unless it carries per-dimension URLs that resolve and meet all four conditions — state what was used.

## PUBLIC SOURCES TO CONSULT

- https://www.langchain.com/terms-of-service (the T5 basis; dated 2026-06-02), https://www.langchain.com/privacy-policy, DPA, sub-processor list, the Pricing FAQ no-training statement, https://trust.langchain.com/ (gated Trust Center — state what could be read; OperatorInput-001).
- https://github.com/langchain-ai/langsmith-sdk/security/advisories, https://github.com/langchain-ai/langsmith-sdk (LICENSE: MIT), releases — the SDK advisory set; triage for window entry (Attribution-CVE-002), CVE presence and product scope.
- NVD per ENGINE.md step 3 (`LangSmith CVE`, `langsmith-sdk vulnerability 2026`) and the CISA KEV JSON; the 1 nvd-keyword candidate: verify product scope.
- Recorded items: CVE-2026-25750, CVE-2026-25528, CVE-2026-40190, CVE-2026-41182 (NVD records; CNA; disclosure dates; fix versions) and AgentSmith (third-party research disclosure, 2025 — locate the researcher publication and any later CVE assignment).
- https://changelog.langchain.com/ and the vendor's security bulletins / blog (SourceCoverage-001) for disclosure dates and fix timing; https://status.smith.langchain.com/ and https://eu.status.smith.langchain.com/ for incident disclosures (T).
- https://docs.langchain.com/langsmith — data handling, regions, self-hosted Enterprise, Sandboxes status (I, C); certification claims (SOC 2 Type II scope, HIPAA at Enterprise) re-verified against the vendor's official documentation.
- Operator of record: the vendor's own legal pages (`LangChain, Inc.`); funding statements for the disclosure layer; align the operator spelling with #011 / #046.
- Supply chain searches per step 3a (PyPI `langsmith`, npm `langsmith`).
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-05-12 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-05-12, 55 |
| `evaluation_number` | #062, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed; `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active (sweep 2026-10-27: no dormancy signal), so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #062 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set"). The record states "independent of Anthropic at every layer; indirect commercial relationship via Claude framework support" — re-verify; framework support for Claude is a product-level non-trigger (separate paragraph).
- **Operator of record (ENGINE.md step 2)** — confirm `LangChain, Inc.` on the vendor's own legal pages; `independence` re-assessed.
- The recorded URL-validation root-cause recurrence across Prompt Hub / SDK / Studio bears on the R structural-issues criterion; re-assess on the confirmed LangSmith-scoped set.

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No LangSmith entry exists at base. T5 basis applies: stage a KNOWN_FACTS entry candidate when a published fact has become incorrect. See the #011 prompt on the operator-spelling intake rule.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_062_langsmith_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state and prior-record omissions stated as facts; Evaluation History table covering 2026-05-12 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/langsmith.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it).

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

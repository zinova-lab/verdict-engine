# VERDICT Update Evaluation Prompt — #011 LangChain

File: `prompts/011_langchain_update_2026-10-31.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ 84b2fa9 — ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.
Batch: batch 1 (Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — Tranche A 2 of 6.

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | LangChain |
| Slug | `langchain` |
| Evaluation number | #011 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/langchain.md` @ e9a717f (record last changed 633a9da) — read it in full before starting |
| Previous evaluation | 2026-03-25 · 49/85 (Layer 0) · Tier B · framework v0.3.1 · migrated capture (no `sources`) |
| Recorded operator | `Independent · Sequoia / IVP · $1.25B Unicorn (Oct 2025)` (display string); `independence: unrecorded` |
| Recorded R fields | `cve_count_12mo: 3` (basis `exact`), `max_cvss_12mo: 9.3`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; R 8/20, T 7/10 |
| Recorded facts to re-verify | CVE-2025-68664 "LangGrinch" (CVSS 9.3, langchain-core serialization injection; recorded as patched in 20 days); "LiteLLM dependency exposure"; SOC 2 Type II for LangSmith and LangGraph Platform, HIPAA BAA, self-service GDPR DPA, explicit no-training policy. The other two CVEs of the recorded count are not named in the record — a prior-record omission to state in the Differential section. |

## TRIGGER

**T1 (interrupt lane, immediate)** — repo GHSA set diverges from the recorded R facts. Fired by the quarterly sweep 2026-10-27 (`docs/operations_sweep_procedure.md` v1.2.3). Sweep rows are machine-matched candidates; attribution judgment belongs to this evaluation. Mandatory re-check: R — subsumed by the full re-evaluation set in SCOPE.

Sweep observations (2026-10-27; SweepFormat-001; observations base `verdict-platforms` e9a717f; recorded values are the base record's):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| T1 | repo-ghsa | https://github.com/langchain-ai/langchain/security/advisories | 9 published advisories in trailing 12 months; max CVSS 9.3 | `cve_count_12mo: 3`, `max_cvss_12mo: 9.3` |
| T1 | nvd-keyword (working layer, non-product-scoped) | NVD query "LangChain" | 13 CVEs mention "LangChain" (119-day window) | candidates only; verify product scope per item |

No KEV match. No T5 page-date signal for this record (the operator's shared ToS page carries a 2026-06-02 date — see the #062 LangSmith prompt; re-read it here for D as well). No dormancy signal.

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- Routine lane: not due (365-day interval, ReviewCadence-002; sweep 2026-10-27: none of the batch-1 records is due within 100 days). R, T and V are re-evaluated here regardless, as part of the full set; recorded as basis.
- The R-only escalation rule does not apply (already a full re-review).
- This update also resolves the migrated `qa` state (QAConvention-001 → full protocol result).
- **Product scope**: the evaluated target is the LangChain framework packages published from github.com/langchain-ai/langchain (`langchain`, `langchain-core`, `langchain-community` and partner packages in that monorepo). LangGraph (#046) and LangSmith (#062) are separate VERDICT series under the same operator: do not double-count their advisories here, and do not count LangChain advisories there. Bind `target_version` to the package set and versions examined.


## CARRY-FORWARD CHECKS

The base record is a migrated capture without per-dimension sources, so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, no per-dimension sources`.

## PUBLIC SOURCES TO CONSULT

- https://github.com/langchain-ai/langchain/security/advisories — the T1 basis set: triage every advisory for window entry (Attribution-CVE-002), CVE presence (Attribution-CVE-001) and package scope (monorepo: which package is affected).
- NVD per ENGINE.md step 3 (`langchain CVE`, `langchain-core vulnerability 2026`) and the CISA KEV JSON. The 13 nvd-keyword candidates are non-product-scoped (the term matches LangGraph, LangSmith and third-party integrations): verify product scope per item.
- CVE-2025-68664 (LangGrinch): NVD, the GHSA, and the vendor's own security bulletin for disclosure date, fix version and elapsed time (R patch response speed; T incident disclosure speed).
- The recorded "LiteLLM dependency exposure": dependency CVEs → Incident Timeline with `dependency: BerriAI/litellm` only; supply chain searches per step 3a for the vendor's own PyPI / npm packages.
- Operator of record: https://www.langchain.com/ legal pages — https://www.langchain.com/terms-of-service (page dated 2026-06-02 per the sweep), https://www.langchain.com/privacy-policy, DPA and sub-processor list; https://trust.langchain.com/ (Trust Center access may be gated — state what could be read).
- Certifications claimed in the record (SOC 2 Type II for LangSmith / LangGraph Platform, HIPAA BAA) — re-verify against the vendor's official documentation and assess which apply to the LangChain framework itself versus the hosted products (V independent certification is scored on the evaluated product).
- Repository LICENSE (MIT) and release notes / changelog for V; Criterion-VSource-001 (the framework is OSS; name the license of each part relied on).
- Funding statements (Series B, October 2025 — the record's "$1.25B" line) from the parties to the round, for the disclosure layer (Trigger2-Designation-001).
- Vendor security or incident bulletins (blog, /security, status page) — SourceCoverage-001.
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-03-25 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-03-25, 49 |
| `evaluation_number` | #011, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed; `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active (sweep 2026-10-27: no dormancy signal), so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #011 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set"). LangChain's investors named in the record (Sequoia, IVP) are not in the set; read the October 2025 round statements for any set member with lead / strategic designation or a USD 100M+ position.
- **Operator of record (ENGINE.md step 2)** — the recorded line is a funding display string. The #046 and #062 records carry `LangChain Inc.` / `LangChain, Inc.`; confirm the legal entity on the vendor's own legal pages for this record and use one consistent spelling across the three series (state the spelling source).
- The recorded "patched in 20 days" and the ~847M-downloads figure are re-verified from primary sources, not carried; record elapsed times and outcomes only (QA §2).

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No LangChain entry exists at base. If the operator correction recurs across the three LangChain-operated series (#011, #046, #062), it is a KNOWN_FACTS candidate (intake rule, same entity); stage it in the Differential section.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_011_langchain_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state and prior-record omissions stated as facts; Evaluation History table covering 2026-03-25 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/langchain.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it).

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

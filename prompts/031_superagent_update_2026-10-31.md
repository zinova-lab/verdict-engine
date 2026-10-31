# VERDICT Update Evaluation Prompt — #031 Superagent

File: `prompts/031_superagent_update_2026-10-31.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ 84b2fa9 — ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.
Batch: batch 1 (Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — T1-immediate 4 of 5 — supersedes `prompts/031_superagent_update_2026-09-24.md` (drafted before `_template_update.md`; its trigger basis is stale and it was never executed).

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | Superagent |
| Slug | `superagent` |
| Evaluation number | #031 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/superagent.md` @ e9a717f (record last changed 15e03d8) — read it in full before starting |
| Previous evaluation | 2026-03-31 · 42/85 (Layer 0) · Tier C · framework v0.3.1 · migrated capture (site-level `sources` only: docs, organization, repo, releases, homepage, about, legal) |
| Recorded operator | `Superagent · Gothenburg, Sweden` (display string, not a legal entity name); `independence: independent`; `target_version: Superagent (superagent.sh; github.com/superagent-ai/superagent, post-pivot)` |
| Recorded R fields | `cve_count_12mo: 0` (basis `exact`), `max_cvss_12mo: null`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; R 14/20, T 4/10 ("No SECURITY.md") |
| Recorded facts to re-verify | pivot to AI agent security (Guard / Redact / Scan APIs, AI Firewall, Safety Agent, VibeKit); YC W24; two-person team; MIT license; "zero CVEs"; no SECURITY.md at base. |

## TRIGGER

**T1 (interrupt lane, immediate)** — repo GHSA set diverges from the recorded R facts (one High advisory against a recorded count of 0). Fired by the quarterly sweep 2026-10-27 (`docs/operations_sweep_procedure.md` v1.2.3); first observed at the 2026-09-22 dry run and carried in the superseded 2026-09-24 prompt. Sweep rows are machine-matched candidates; attribution judgment belongs to this evaluation. A CVE-less advisory with published severity ≥ 7.0 fires T1 (Attribution-CVE-001). Mandatory re-check: R — subsumed by the full re-evaluation set in SCOPE.

Known advisory from the superseded prompt (re-verify in-session; do not carry): GHSA-pw7h-8x4q-fwwh — "Safety Agent automatically fetches attacker-controlled URLs, enabling SSRF", npm `@superagent-ai/safety-agent`, affected ≥ 0.1.3 ≤ 0.1.6, CWE-918, CVSS 3.1 8.6 (High), no CVE assigned at the 2026-09-24 drafting, published 2026-08-13 by the maintainer as reporter; the advisory page listed "Patched versions 0.0.7", inconsistent with the affected range — read the npm release history and the repository to identify the actual fixed version and state what the advisory page shows.

Sweep observations (2026-10-27; SweepFormat-001; observations base `verdict-platforms` e9a717f; recorded values are the base record's):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| T1 | repo-ghsa | https://github.com/superagent-ai/superagent/security/advisories | 1 published advisory in trailing 12 months; max CVSS 8.6 | `cve_count_12mo: 0`, `max_cvss_12mo: null` |

No KEV match. No T5 page-date signal. No nvd-keyword row (none reported for this slug). No dormancy signal.

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- Routine lane: not due (365-day interval, ReviewCadence-002; sweep 2026-10-27: none of the batch-1 records is due within 100 days). R, T and V are re-evaluated here regardless, as part of the full set; recorded as basis.
- The R-only escalation rule does not apply (already a full re-review).
- This update also resolves the migrated `qa` state (QAConvention-001 → full protocol result).
- **Product scope / disambiguation**: the evaluated target is the `superagent-ai` organization's packages (npm `@superagent-ai/*`, the `vibekit` packages, PyPI `superagent-py` if still published) as bound by `target_version` on the update date — state which surfaces are in scope (Guard / Redact / Scan APIs, AI Firewall, Safety Agent, VibeKit). The unrelated npm HTTP client `superagent` (visionmedia / ladjs) and its dependency advisories (e.g. form-data CVE-2026-12143) are out of scope.
- **Attribution of the advisory**: published under github.com/superagent-ai/superagent → product-scoped. If still CVE-less, it is not counted in `cve_count_12mo` (stays 0, basis `exact`) and does not set `max_cvss_12mo` (stays null, with 8.6 stated in the body); it is recorded in the Incident Timeline, considered under T (CVE publication posture: the operator issues repository advisories) and used for the R patch-response-speed and structural-issues criteria. If a CVE has been assigned, count it and fill `max_cvss_12mo` per Attribution-CVE-002.


## CARRY-FORWARD CHECKS

The base record carries `sources` as a site- / organization-level URL list with no per-dimension citations, so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22; precedent #031 prompt of 2026-09-24). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, site-level sources only`.

## PUBLIC SOURCES TO CONSULT

- https://github.com/superagent-ai/superagent/security/advisories (the T1 basis set) and https://github.com/superagent-ai/superagent/security (SECURITY.md presence — record the change from the prior "No SECURITY.md" finding with the file's first-commit date if visible).
- https://www.npmjs.com/package/@superagent-ai/safety-agent and sibling packages — release history for the fixed version; OSV https://osv.dev/list?q=%40superagent-ai ; NVD search terms "superagent-ai", "Superagent AI"; the CISA KEV JSON.
- https://www.superagent.sh/ · https://www.superagent.sh/about · https://www.superagent.sh/legal (terms, privacy, DPA) · https://docs.superagent.sh/ · https://docs.superagent.sh/mcp — V, D, I, C on the current product set.
- https://github.com/superagent-ai/superagent (LICENSE: MIT) · https://github.com/superagent-ai/vibekit · https://github.com/superagent-ai — Criterion-VSource-001 (OSS components vs hosted APIs: name the license of each part).
- Operator of record: the legal entity and jurisdiction (Sweden / US) on the vendor's own legal page; YC W24 record; funding statements for the disclosure layer; founders are not named in the report beyond what the vendor's pages state (QA §2, no ad hominem).
- Supply chain searches per step 3a (npm `@superagent-ai/*` provenance).
- Vendor security or incident bulletins (blog, /security, status page) — SourceCoverage-001.
- https://github.com/superagent-ai/superagent/releases and npm publish dates — dormancy test (expected active).
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-03-31 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-03-31, 42 |
| `evaluation_number` | #031, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed; `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active (sweep 2026-10-27: no dormancy signal), so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #031 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set").
- **Operator of record (ENGINE.md step 2)** — the recorded line is a display string; set `operator` to the legal entity named on the vendor's own legal page, or record the publishing name and state that no legal entity is named.
- DisplayHonesty-001: "Zero CVEs" may remain in display text only as a CVE statement with the advisory fact beside it; never publish it alone.

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No Superagent entry exists at base. Stage a KNOWN_FACTS entry candidate only if a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_031_superagent_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state and prior-record omissions stated as facts; Evaluation History table covering 2026-03-31 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/superagent.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it).

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

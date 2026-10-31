# VERDICT Update Evaluation Prompt — #037 AutoGPT

File: `prompts/037_autogpt_update_2026-10-31.md`
Framework: VERDICT v0.3.2 (`zinova-lab/verdict-engine` @ 84b2fa9 — ENGINE.md / QA.md / KNOWN_FACTS.md as pinned at invocation)
Invocation: Type D (stateless fresh chat) — the invocation procedure lives in the repository README and is not restated in this prompt.
Batch: batch 1 (Strategy ruling Batch1-TrancheA-Authorize-2026-10-31-A1) — T1-immediate 5 of 5 (batch-1 supplement: `cve_count_basis: unrecorded`, LayerC-Triage-001).

## RECORD UNDER UPDATE

| Field | Value |
|---|---|
| Platform | AutoGPT |
| Slug | `autogpt` |
| Evaluation number | #037 (series identifier; unchanged on update) |
| Evaluation type | Update (Differential Evaluation per ENGINE.md) |
| Base record | `verdict-platforms/platforms/autogpt.md` @ e9a717f (record last changed 15e03d8) — read it in full before starting |
| Previous evaluation | 2026-03-31 · 36/85 (Layer 0) · Tier C · framework v0.3.1 · migrated capture (site-level `sources` only: homepage, repo, releases, security page) |
| Recorded operator | `Determinist Ltd · UK`; `independence: independent`; `target_version: AutoGPT Platform beta v0.6.52 (github.com/Significant-Gravitas/AutoGPT)` |
| Recorded R fields | `cve_count_12mo: null` (basis `unrecorded` — the original published "6 confirmed GHSAs" in advisory units, no CVE-unit count), `max_cvss_12mo: null`, `cisa_kev.present: false`, `supply_chain_compromise_12mo: false`; R 4/20, T 10/10 |
| Recorded facts to re-verify | six self-published security advisories with patches, two Critical SSRF, recurring SSRF pattern (3 of 6), cross-user data leak via WebSockets (patched); licensing: Polyform Shield for the Platform with MIT for parts (recorded category "Source-Available"); 183k stars; $12M funded. No advisory or CVE IDs are named in the record — a prior-record omission to state in the Differential section. |

## TRIGGER

**T1 (interrupt lane, immediate)** — repo GHSA set diverges from the recorded R facts (34 advisories, max CVSS 10.0, against a null count with basis `unrecorded`). Fired by the quarterly sweep 2026-10-27 (`docs/operations_sweep_procedure.md` v1.2.3). Sweep rows are machine-matched candidates; attribution judgment belongs to this evaluation. A CVE-less advisory with published severity ≥ 7.0 fires T1 (Attribution-CVE-001). Mandatory re-check: R — subsumed by the full re-evaluation set in SCOPE. This update also replaces the migrated `unrecorded` basis with an exact CVE-unit count (IncidentCount-001).

Sweep observations (2026-10-27; SweepFormat-001; observations base `verdict-platforms` e9a717f; recorded values are the base record's):

| lane | basis | source | observed | recorded |
|---|---|---|---|---|
| T1 | repo-ghsa | https://github.com/Significant-Gravitas/AutoGPT/security/advisories | 34 published advisories in trailing 12 months; max CVSS 10.0 | `cve_count_12mo: null` (basis `unrecorded`), `max_cvss_12mo: null` |
| T1 | nvd-keyword (working layer, non-product-scoped) | NVD query "AutoGPT" | 1 CVE mentions "AutoGPT" (119-day window) | candidates only; verify product scope |

No KEV match. No T5 page-date signal. No dormancy signal.

## SCOPE

- **Full re-evaluation of all six Layer 0 dimensions (V, R, D, I, C, T).** See CARRY-FORWARD CHECKS: no dimension qualifies for carry-forward. E remains Layer 1+ (null at Layer 0).
- Routine lane: not due (365-day interval, ReviewCadence-002; sweep 2026-10-27: none of the batch-1 records is due within 100 days). R, T and V are re-evaluated here regardless, as part of the full set; recorded as basis.
- The R-only escalation rule does not apply (already a full re-review).
- This update also resolves the migrated `qa` state (QAConvention-001 → full protocol result).
- **Product scope**: the AutoGPT Platform (backend / frontend under `autogpt_platform/`), the classic agent and Forge, and the published packages / Docker images, as bound by `target_version` on the update date; advisories against the archived classic code paths are recorded with their affected component. Triage all 34 advisories: CVE-bearing vs CVE-less (count only the former), window entry by first public disclosure (Attribution-CVE-002), duplicates across GHSA / CVE for one flaw counted once.
- The recorded SSRF recurrence bears on the R structural-issues criterion; re-assess on the confirmed set.


## CARRY-FORWARD CHECKS

The base record carries `sources` as a site- / organization-level URL list with no per-dimension citations, so carry-forward conditions 1–4 (ENGINE.md, Differential Evaluation) cannot be positively satisfied for any dimension (convention 2026-09-22; precedent #031 prompt of 2026-09-24). Carrying forward is a positive finding that cited evidence is unchanged — never an inference from the absence of news. Record the determination per dimension in the report's Differential section: `re-evaluated — migrated capture, site-level sources only`.

## PUBLIC SOURCES TO CONSULT

- https://github.com/Significant-Gravitas/AutoGPT/security/advisories — the T1 basis set (34): triage every advisory for window entry, CVE presence, affected component and fix version; https://github.com/Significant-Gravitas/AutoGPT/security (SECURITY.md, reporting policy).
- NVD per ENGINE.md step 3 (`AutoGPT CVE`, `Significant-Gravitas vulnerability 2026`) and the CISA KEV JSON; the 1 nvd-keyword candidate: verify product scope.
- https://github.com/Significant-Gravitas/AutoGPT (LICENSE files: Polyform Shield 1.0.0 for `autogpt_platform/`, MIT elsewhere — Criterion-VSource-001: source-available (non-OSI) scores 2; name the license of each part relied on) and https://github.com/Significant-Gravitas/AutoGPT/releases for `target_version`.
- https://agpt.co/ — privacy policy, terms, DPA, security page, hosted Platform (cloud beta) data handling (D); operator legal pages (Determinist Ltd — confirm the legal entity and UK registration on the vendor's pages; Companies House is a public registry record for the V identity criterion).
- Platform docs — agent execution controls, approvals, credentials handling, sandboxing (I, C); telemetry defaults (D).
- Supply chain searches per step 3a (Docker images, PyPI / npm packages published by the vendor).
- Vendor security or incident bulletins (blog, /security, status page) — SourceCoverage-001; the vendor's own advisories are the primary T evidence.
- Funding statements ($12M — from the parties to the round) for the disclosure layer.
- MIT AI Agent Index and other third-party evaluations (step 5).

## FIELD SEMANTICS

| Field | Rule |
|---|---|
| `evaluated_at` | 2026-03-31 — never changes |
| `updated_at` | completion date of this differential |
| `previous_evaluation_date`, `previous_score` | 2026-03-31, 36 |
| `evaluation_number` | #037, unchanged |
| `framework_version`, `target_version` | the framework version in force (v0.3.2) and the product version examined on the update date; bind CVE/KEV attribution to `target_version` |
| `cve_count_12mo`, `max_cvss_12mo`, `cisa_kev`, `supply_chain_compromise_12mo` | recomputed over the trailing 12 months from the update date; `cve_count_basis: exact` |
| `independence`, `parent_entity` | re-assessed; `unrecorded` not permitted in an update |
| `qa` | full protocol result (`unresolved` not permitted; `flagged` allowed) |
| `evaluator_model` | `claude-fable-5-1` — the operator's model selection for batch 1 (Batch1-TrancheA-Authorize-2026-10-31-A1), written as supplied at invocation, not from the model's self-report (EvaluatorModel-Provenance-001) |
| `next_review_due` | pipeline-derived — do not hand-write |
| `dormant_since` | only when frozen; the target is active (sweep 2026-10-27: no dormancy signal), so omit the key (never write null) — UpdateTemplate-001 |
| `verdict.<dim>.note` | ≤ 80 characters — UpdateTemplate-001 |
| `selection_basis` | not required (series #037 predates #070) |

## SPECIAL CONSIDERATIONS

- **Disclosure layer (Triggers 0–3)** — check per ENGINE.md v0.3.2, including chain of control (Trigger2-ParentLevel-001) and designation reading of funding-round statements (Trigger2-Designation-001). Material set = {Amazon, Google, Microsoft, NVIDIA} (KNOWN_FACTS.md). Tags only for triggers that fire; a record with no firing trigger carries none of the trigger tags. Lightspeed Venture Partners is not in the set: a Lightspeed holding fires no trigger and the record is silent on it (KNOWN_FACTS.md, "Not in the set").
- **Operator of record (ENGINE.md step 2)** — confirm Determinist Ltd on the vendor's own legal pages; `independence` re-assessed.
- The recorded T 10/10 rested on six vendor-published advisories; re-score T on the current posture (34 advisories, disclosure speed per advisory, security policy text) — a high advisory count with vendor publication is a transparency fact and a resilience fact at once; score each criterion on its own rule.
- DisplayHonesty-001: display text must not derive a numeric CVE count from advisory units; publish the CVE-unit count and the advisory count separately.

## KNOWN FACT CORRECTIONS

Cross-check every entity mentioned in the draft against `KNOWN_FACTS.md` before delivery (QA §1; violations are Critical). No AutoGPT entry exists at base. Stage a KNOWN_FACTS entry candidate only if a published fact has become incorrect.

## OUTPUT RULES

Two-file delivery (standing format):

1. `verdict_037_autogpt_update.md` — full English report (header type Update; Differential section with previous date/score, per-dimension state and prior-record omissions stated as facts; Evaluation History table covering 2026-03-31 Initial and this Update; Bias Disclosure verbatim) + `japanese-summary` block + score tag line. The QA review block is emitted in-session, not written into the file.
2. `platforms/autogpt.md` full replacement text — title / summary paragraph / Layer 0 Score line / CISA KEV section (English only) / Bias Disclosure / Full Evaluation embed. Schema-derived values (`github` field shape, `next_review_due`, YAML anchors) are applied by Operations. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags to the new facts (DisplayHonesty-001: no "zero CVEs" wording without the advisory facts beside it).

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

# VERDICT Update Evaluation Prompt — #007 Flowise (update, 2026-09-25)

Framework v0.3.2 Differential Evaluation. Interrupt lane (T1 ×n, T5) with folded routine scope. Fourth in the LayerC-Triage-001 order (pilot 4). Drafted from the 2026-09-22 sweep dry run, which observed more than 100 GitHub Security Advisories published against `flowise` (npm) in the trailing 12 months (listing capped at `per_page` = 100; pagination not performed), while the record carries `cve_count_12mo: 12` with basis `lower_bound`.

---

## RECORD UNDER UPDATE

**Name / slug:** Flowise / flowise
**Evaluation number:** 007 (unchanged)
**Current canonical record:** `platforms/flowise.md` at ZinovaCreation/verdict-platforms `31152b1` (or later) — read in full before starting. It is a migrated capture: body carries the captured key finding ("March 2026 cluster: 6 CVEs patched in v3.0.13, including CVE-2025-55346 and CVE-2025-58434 (both CVSS 9.8). Structural pattern confirmed: authentication not enforced for critical functions across 4+ independent endpoints. No CISA KEV."), `qa` unresolved ×3, `evaluator_model: unrecorded`, `sources` absent (0 URLs), `homepage: null`, `github: null`, `target_version: null`, `tags: []`, `operator: Acquired by Workday (Aug 2025)`, `independence: unrecorded`, `parent_entity: null`. Only R is marked `re-evaluated` in `differential` (the 2026-03-24 update); V/D/I/C/T are `null`.
**evaluated_at (never changes):** 2026-03-13
**Previous evaluation (→ `previous_evaluation_date` / `previous_score`):** 2026-03-24 / 33
**Evaluation History so far:** 2026-03-13 Initial (Layer 0) 37 / Tier C / v0.3.1 · 2026-03-24 Update 33 / Tier D / v0.3.1 (provenance correction 2026-09-22 per StrategyApproval-001 clause (c); Evaluation History table already present in the body)
**Prior framework version / evaluator model:** v0.3.1 / unrecorded
**Prior R fields:** `cve_count_12mo: 12` (basis `lower_bound`), `max_cvss_12mo: 9.8`, KEV entries: none, `supply_chain_compromise_12mo: false`; R 4/20 (V 10 · D 4 · I 5 · C 4 · T 6)
**Prior record type:** migrated capture without `sources`

---

## TRIGGER

Facts and sources only; the engine verifies each on a primary source before use. The list is representative, not the count.

| Trigger | Fact | Date | Source URL (engine verifies on the primary source) |
|---|---|---|---|
| T5 | The FlowiseAI/Flowise repository was archived by the owner and is read-only ("This repository was archived by the owner on Aug 13, 2026"). Last npm release `flowise` 3.1.4 on 2026-07-29 (dist-tag `latest` on 2026-09-25). The record already names Workday as acquirer (Aug 2025) with `independence: unrecorded`. Engine verifies the archive notice, the acquisition on the Workday primary source, any successor repository or end-of-life / migration announcement, and the current legal entity; sets `operator`, `independence`, `parent_entity`; stages a `KNOWN_FACTS.md` entry candidate if a published fact has become incorrect. | archived 2026-08-13 | https://github.com/FlowiseAI/Flowise ; https://github.com/FlowiseAI/Flowise/security/advisories ; https://www.npmjs.com/package/flowise |
| T1 | GHSA-c9gw-hvqq-f33r: authenticated RCE via MCP adapters (unsafe serialization of stdio commands); affects `flowise` and `flowise-components` ≤ 3.0.13; patched 3.1.0; Critical; published by a Workday-affiliated maintainer account. | 2026-04-15 | https://github.com/FlowiseAI/Flowise/security/advisories/GHSA-c9gw-hvqq-f33r |
| T1 | GHSA-wg86-r78f-74mp: sandbox escape to RCE in the Custom Function / Custom Tool JavaScript sandbox (FlowiseAI/nodevm, a vm2 fork); elttam advisory, disclosed 2026-04-11; affects Flowise 3.1.1 / nodevm 3.9.25; the advisory states the default sandbox was later changed to E2B — engine reads the patched version, CVE ID (if any) and CVSS from the advisory. | disclosed 2026-04-11 | https://github.com/FlowiseAI/Flowise/security/advisories/GHSA-wg86-r78f-74mp |
| T1 | CVE-2026-46440 (GHSA-php6-83fg-gw3g): `checkBasicAuth` validates credentials in plaintext without rate limiting; CVSS 3.1 9.1 Critical; prior to 3.1.2; patched 3.1.2 (npm 2026-04-14). | published 2026-06-08 | https://github.com/FlowiseAI/Flowise/security/advisories/GHSA-php6-83fg-gw3g ; https://nvd.nist.gov/vuln/detail/CVE-2026-46440 |
| T1 | CVE-2026-46478 (GHSA-7j65-65cr-6644) and CVE-2026-46476 (GHSA-728h-4mwj-f2p4): mass-assignment in DatasetRow / CustomTemplate create-update allowing cross-workspace takeover; CVSS 3.1 8.8 High each; patched 3.1.2. Part of a CVE-2026-464xx batch published against 3.1.2 — engine enumerates the whole batch (CVE-2026-46443 credential data leak, ~7.5, is in it). | published 2026-06 | https://github.com/FlowiseAI/Flowise/security/advisories/GHSA-7j65-65cr-6644 ; https://github.com/FlowiseAI/Flowise/security/advisories/GHSA-728h-4mwj-f2p4 ; https://github.com/FlowiseAI/Flowise/security/advisories/GHSA-7g73-99r4-m4mj |
| T1 | CVE-2026-41264 (GHSA-3hjv-c53m-58jj): CSV Agent prompt-injection RCE, unauthenticated, ZDI-credited; affects 3.0.13; engine reads patched version and CVSS. | engine to read | https://github.com/advisories/GHSA-3hjv-c53m-58jj |
| T1 (in window, pre-dating the 2026-03-24 update) | GHSA-jv9m-vf54-chjj (WriteFileTool arbitrary file write, Critical, 2025-10-08), GHSA-j44m-5v8f-gc9c (ReadFileTool arbitrary file read, High, 2025-10-08), GHSA-35g6-rrw3-v6xc (file upload, High, 2025-10-06), GHSA-4fr9-3x69-36wv (XSS, Critical, 2025-10-03), and the March 2026 cluster fixed in 3.0.13 (incl. CVE-2025-55346, CVE-2025-58434, both 9.8) — engine confirms publication dates against the window and reconciles with the prior `cve_count_12mo: 12 (lower_bound)`. Advisories published 2025-09-12/13 (GHSA-wgpv-6j63-x5ph 9.8, GHSA-3gcm-f6qx-ff7p, GHSA-7944-7c6r-55vv, GHSA-99pg-hqvx-r4gf, GHSA-435c-mg9p-fv22, GHSA-hr92-4q35-4j3m) fall before a 2025-09-25 window start; state the placement by date. | 2025-10 → 2026-03 | https://github.com/FlowiseAI/Flowise/security/advisories |
| Routine (folded) | Published `next_review_due` 2026-06-22 has lapsed; v0.3.2 base-date routine (2026-03-24 + 365 d) not yet due. Folded because all six dimensions are re-evaluated anyway (see SCOPE). | 2026-09-25 | — |

---

## SCOPE

**Lane:** Interrupt (T1 ×n, T5) with folded routine triggers.
**Mandatory re-evaluation:** R (T1); V, D (T5). Because the prior record is a migrated capture with no `sources`, the carry-forward conditions cannot be positively verified for D, I, C; T and V are folded routine scope. **All six dimensions are re-evaluated.** `differential` = `re-evaluated` for v, r, d, i, c, t; `e: null`. This update also resolves the migrated `qa` state (full protocol, all `pass`), records `evaluator_model`, and fills `homepage`, `github` (repository URL per Schema-GithubField-001), `target_version`, `sources` and `tags`.
**Trailing 12-month window for R:** [update date − 12 months] → [update date].
**Enumeration (mandatory, paginated):** The sweep saw >100 advisories at the `per_page` cap. Enumerate the full set with pagination from at least two of: GitHub Advisory Database REST (`GET /advisories?ecosystem=npm&affects=flowise&per_page=100&page=N` until an empty page; repeat for `affects=flowise-components`), repository advisories (`GET /repos/FlowiseAI/Flowise/security-advisories?per_page=100&page=N`), OSV (`POST https://api.osv.dev/v1/query` with `{"package":{"name":"flowise","ecosystem":"npm"}}` following `next_page_token`; repeat for `flowise-components`), and the OSV / GitHub web listings as fallback. Record the enumeration method and page count in the Differential. `cve_count_12mo` = exact count of CVE-ID-bearing, product-scoped records published inside the window with basis `exact` only if the enumeration completed; otherwise the count reached with basis `lower_bound` and the reason. CVE-less GHSAs are recorded in the Incident Timeline and considered under T; they are not counted (Attribution-CVE-001). De-duplicate GHSA / CVE / OSV aliases before counting.
**KEV flag:** none expected; engine checks the KEV JSON for every CVE ID enumerated and for vendorProject/product "Flowise" / "FlowiseAI" / "Workday" and states the result.
**Attribution / target:** Flowise as distributed via npm `flowise` (server) and `flowise-components`, source github.com/FlowiseAI/Flowise — bind `target_version` to the latest release on the update date (3.1.4, 2026-07-29, unless a successor repository publishes a newer release; state the source). Flowise Cloud (cloud.flowiseai.com) is the operator's hosted surface: incident effects on it are recorded in the Contextual Analysis and as operator-side evidence under C / I, not scored as the target. Dependency CVEs (e.g. vm2 / nodevm lineage where the vulnerable package is a third party) → `dependency: <vendor/product>`; a vulnerability in FlowiseAI/nodevm (the operator's own fork) is product-scoped. CVE-less advisories → Incident Timeline and T, not counted.
**T5 check (archive / operator):** Verify (a) the archive notice and date on github.com/FlowiseAI/Flowise; (b) the Workday acquisition on Workday's newsroom or SEC filings and the current legal entity name; (c) whether a successor repository, product rename, or end-of-life statement exists (Workday newsroom, flowiseai.com, docs.flowiseai.com, npm README); (d) release / changelog activity after 2026-08-13. Set `operator` (legal entity, with the parent named per the #064 pattern, e.g. "Workday (via <entity>)"), `independence: subsidiary`, `parent_entity: Workday, Inc.` if confirmed. **Dormancy:** the archive is public evidence of repository inactivity from 2026-08-13; the frozen-state test (12 consecutive months without public release, commit or changelog activity, applied to the product's own release record) is not met on the update date — do not author `dormant_since`; state the date on which the test would first be met and route it to the routine lane. If a published fact has become incorrect (e.g. the operator string), fire T5 and stage a `KNOWN_FACTS.md` entry candidate in the report's Differential section (Engine ratifies separately; do not edit KNOWN_FACTS.md in the evaluation).

---

## PUBLIC SOURCES TO CONSULT

### Official project
- Repository (archived): https://github.com/FlowiseAI/Flowise · Releases: https://github.com/FlowiseAI/Flowise/releases · npm: https://www.npmjs.com/package/flowise , https://www.npmjs.com/package/flowise-components · Homepage / docs: https://flowiseai.com , https://docs.flowiseai.com (engine verifies whether these still resolve and whether they redirect to a Workday property) · Flowise Cloud: https://cloud.flowiseai.com
- Privacy policy / terms / DPA / sub-processors: engine locates on flowiseai.com or the applicable Workday legal pages and states which governs the product. If a legal page is client-side rendered and cannot be read, flag `[UNVERIFIED]` with the resolving URL and deliver; Tatsuya supplies the body for pre-publication re-scoring (ways-of-working convention).
- Telemetry: engine reads the current telemetry documentation and default (`DISABLE_FLOWISE_TELEMETRY` or successor), including the endpoint.
### Security and vulnerability disclosure
- GitHub Security Advisories (repository and database): https://github.com/FlowiseAI/Flowise/security/advisories · SECURITY.md presence (verify on the archived tree) · NVD search terms: "flowise", "flowiseai" · OSV: https://osv.dev/list?q=flowise · CISA KEV JSON (cisagov/kev-data mirror acceptable)
- Third-party advisories: elttam (GHSA-wg86-r78f-74mp), Trend Micro ZDI (CVE-2026-41264), any Workday security bulletin covering Flowise
### Ownership and identity
- Workday newsroom (acquisition announcement, Aug 2025) and any subsequent statement on Flowise's product status; corporate registration of the acquired entity; Workday 10-K / 10-Q mentions
### Release and activity record (dormancy test)
- https://github.com/FlowiseAI/Flowise/releases (last release before archive) · npm publish dates (3.1.4, 2026-07-29) · any successor repository

---

## FIELD SEMANTICS

Per `_template_update.md` and ENGINE.md Differential Evaluation. Specifically for this record: `cve_count_12mo` and `cve_count_basis` as in SCOPE (Enumeration); `max_cvss_12mo` = highest score on the CVSS version the report states (ENGINE.md reference standard is CVSS v3.1 via NVD; where only a v4.0 score exists, record it and say so); apply the −1 count penalty and the 0-point maximum-CVSS band if any CVSS 9.0+ exists (expected: CVE-2026-46440 9.1 and the 9.8 cluster); `supply_chain_compromise_12mo` recomputed; `evaluator_model` recorded; `qa` all `pass`; `selection_basis` absent (pre-frame record — do not add); `verdict.<dim>.note` ≤ 80 characters; omit `dormant_since`; `previous_evaluation_date: 2026-03-24`, `previous_score: 33`; `evaluation_type: update`; `differential` all `re-evaluated`, `e: null`; `homepage`, `github`, `target_version` filled; `sources` populated with every URL cited; `tags` populated (lowercase-hyphen; include `tier-<x>`, `archived-repository` if confirmed, `subsidiary` if confirmed). Replace the captured "March 2026 cluster" language in `finding`, `key_finding`, `meta_description`, `og_description`, the display / card tags and the body summary paragraph with the post-window facts; `key_finding` two sentences, ≤ ~630 characters. Evaluation History: three rows (2026-03-13 initial 37 · 2026-03-24 update 33 · this update).

---

## SPECIAL CONSIDERATIONS

### 1. Structural issues criterion
The prior record states "authentication not enforced for critical functions across 4+ independent endpoints" (March 2026 cluster). The 2026 advisories add a second class (mass-assignment across DatasetRow / CustomTemplate; cross-workspace takeover) and repeated sandbox / code-execution paths (CustomMCP `Function()` evaluation 2025-09, nodevm sandbox escape 2026-04, MCP stdio serialization 2026-04, CSV Agent Python evaluation). Evaluate "same root cause recurring" on the evidence per class; record first-report → patch elapsed times per CVE from the advisories and release tags (3.0.13, 3.1.0, 3.1.2 on npm). No motive attribution.

### 2. Archived repository and score-change explanation
An archived repository means no further advisories or fixes will be published under FlowiseAI/Flowise; state what this implies for T (CVE publication posture going forward) and R (patch record of the window stands as published) without predicting vendor behavior. R will move (count band, 9.0+ penalty, patch record); if the total moves by ≥5 points, the Executive Summary names the dimensions and evidence. `previous_score: 33` is published alongside.

### 3. Disclosure layer
Triggers 0 / 1 / 2 / 3: Trigger 1 does not fire (Workday is not in the material Anthropic equity-holder set {Amazon, Google, Microsoft, NVIDIA}). Engine checks Trigger 2 at the parent level per Trigger2-ParentLevel-001 (whether a set member is a material investor in Workday, Inc. — ≥ USD 100M position, board seat, or lead/strategic designation on the public record) and Trigger 3 (any non-arms-length channel between Flowise / Workday and a set member beyond standard marketplace or supplier relations), and states "None" or the trigger found. Product-level model-provider integrations (Claude as one of many LLM options) are not triggers.

---

## KNOWN FACT CORRECTIONS

None applicable (no Flowise / Workday entry in `KNOWN_FACTS.md` at drafting). A candidate entry may be staged by this update if the T5 check finds a published fact that has become incorrect (operator string, project status).

---

## OUTPUT RULES

Per `_template_update.md` and the #064 two-file delivery convention: (1) `verdict_007_flowise_update.md` — full English report (`Evaluation type: Update`; header lines for Disclosure layer and Evaluator model) with a Differential section (reason no carry-forward was possible; enumeration method and page count; prior-record omissions stated as facts, including any in-window CVE the prior `lower_bound` count did not carry; T5 findings) and an Evaluation History table (2026-03-13 initial 37 · 2026-03-24 update 33 · this update), followed by the Japanese summary (`評価種別: 更新`, 前回スコア) and the score tag line, QA block excluded; (2) `platforms/flowise.md` — complete front matter with every field above set and the body in the #064 structure (title / summary paragraph / Layer 0 Score line / CISA KEV section in English / Bias Disclosure with the disclosure-layer paragraph / Full Evaluation embedding the report). Schema-driven values (`next_review_due`, YAML anchor expansion) are applied by Operations.

---

## REMINDERS

Public documentation only. Silence = 0. Positive findings alongside risks (vendor-published advisories with CVSS vectors and credits, patched versions declared, sandbox default changed to E2B, self-hostable). No intent attribution — record the archive date and release dates, not reasons. The prior score is published, not smoothed.

---
# END OF PROMPT

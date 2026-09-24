# VERDICT Update Evaluation Prompt — #064 Guardrails AI (update, 2026-09-24)

Framework v0.3.2 Differential Evaluation. Interrupt lane (T3 + T1) with folded routine scope (R, T, V). Second in the LayerC-Triage-001 order (langflow → guardrails-ai → phidata → superagent). Drafted from the 2026-09-22 sweep dry run, which observed one Critical published advisory for `guardrails-ai/guardrails` inside the trailing 12 months while the record carries `cve_count_12mo: 0` and `supply_chain_compromise_12mo: false`.

---

## RECORD UNDER UPDATE

**Name / slug:** Guardrails AI / guardrails-ai
**Evaluation number:** 064 (unchanged — identifies the series)
**Current canonical record:** `platforms/guardrails-ai.md` at ZinovaCreation/verdict-platforms `942d628` — read in full before starting. Engine-authored record with `sources` (10 URLs, aggregate list, not per-dimension), `target_version: null`, `evaluator_model: unrecorded`, `independence: independent`, `qa` all `pass`, `framework_version: v0.3.1-final`.
**evaluated_at (original Layer 0 date, never changes):** 2026-05-12
**Previous evaluation (→ `previous_evaluation_date` / `previous_score`):** 2026-05-12 / 40
**Evaluation History so far:** 2026-05-12 Initial (Layer 0) 40 / Tier C / v0.3.1-final
**Prior framework version / evaluator model:** v0.3.1-final / unrecorded
**Prior R fields:** `cve_count_12mo: 0` (basis `exact`), `max_cvss_12mo: null`, KEV entries: none, `supply_chain_compromise_12mo: false`; R 17/20; display tag "0 CVEs · 12 Months"
**Prior record type:** engine-authored with `sources`

---

## TRIGGER

| Trigger | Fact | Date | Source URL (engine verifies on the primary source) |
|---|---|---|---|
| T3 | Supply chain compromise of the vendor's own package: malicious `guardrails-ai==0.10.1` published to PyPI (code injected into `guardrails/__init__.py`, downloads and executes a remote payload on import). Root cause per the operator: an employee's GitHub Personal Access Token was compromised, used to trigger a GitHub Action across ~30 repositories in the `guardrails-ai` organization, and deploy tokens extracted from the artifacts were used to publish to PyPI. Part of the 2026-05-11 coordinated npm/PyPI campaign (TanStack, Mistral AI, UiPath, OpenSearch, Guardrails AI). | 2026-05-11 ~18:00 PT (2026-05-12 UTC); advisory published 2026-05-12 | https://github.com/guardrails-ai/guardrails/security/advisories/GHSA-xmpw-2vmm-p4p6 ; https://github.com/guardrails-ai/guardrails/blob/main/SECURITY_ADVISORY.md ; https://github.com/guardrails-ai/guardrails/issues/1473 ; https://safedep.io/mass-npm-supply-chain-attack-tanstack-mistral/ |
| T1 | CVE-2026-45758 (CWE-506 Embedded Malicious Code) assigned to the same event; GHSA-xmpw-2vmm-p4p6 is its alias. CVSS: engine reads NVD / GitHub Advisory Database (may be unscored; if unscored with public exploitation reports, T1 timing is "immediate" regardless). | assignment date: engine to read from cvelistV5 / NVD | https://github.com/advisories/GHSA-xmpw-2vmm-p4p6 ; https://nvd.nist.gov/vuln/detail/CVE-2026-45758 |
| Routine (folded) | Published `next_review_due` 2026-08-10 (90-day cadence of the v0.3.1 record) has lapsed; the v0.3.2 base-date routine (2026-05-12 + 365 d) is not yet due. Engine decision: fold R, T, V into this interrupt update so that the record does not require a second update within months. | 2026-09-24 | — |

Also observed in the window (engine confirms attribution before use): PYSEC-2026-1431 (CVSS 3.1 5.9 / 4.0 8.2; XXE in RAIL documents) and PYSEC-2026-1432 (CVSS 3.1 8.8 / 4.0 8.6; eval-based arbitrary code execution, versions 0.2.9–0.5.10), both published by PyPA on 2026-07-07. Their descriptions match CVE-2024-6961 and CVE-2024-45858 (fixed in 0.5.10, September 2024). Engine reads the `aliases` field on OSV: if they alias the 2024 CVEs, they are re-publications of out-of-window vulnerabilities — record in the Incident Timeline as such, do not count, no T1. If either carries no CVE alias and describes a distinct vulnerability, apply Attribution-CVE-001 (CVE-less advisory: Incident Timeline + T, not counted; T1 at severity ≥7.0).

---

## SCOPE

**Lane:** Interrupt (T3, T1) with folded routine triggers.
**Mandatory re-evaluation:** R and T (T3, T1 per ENGINE.md Layer C table) plus V (folded routine). `differential.r`, `.t`, `.v` = `re-evaluated`.
**Carry-forward candidates:** D, I, C — the prior record carries `sources`, so the carry-forward conditions can be tested. Perform the checks below per dimension; carry forward only when every condition holds, otherwise re-evaluate. Note that the incident (credential rotation for Snowglobe / Guardrails Hub API keys, invalidated 2026-05-13 14:00 PT; Ray cluster and validator hub restored on rotated credentials) touches the operator-side surfaces scored under C and I; carry-forward condition 4 (no incident in the window touches the dimension) is expected to fail for at least C.
**Trailing 12-month window for R:** [update date − 12 months] → [update date].
**KEV flag:** CVE-2026-45758 and the 2024 CVEs are not expected in the KEV catalog; engine checks the KEV JSON by CVE ID and by vendorProject/product "Guardrails AI" and states the result.
**Attribution:** `target_version` = the Guardrails framework as distributed via PyPI `guardrails-ai` and github.com/guardrails-ai/guardrails, bound to the latest clean release on the update date (0.10.2 was published as the unaffected successor; engine verifies on PyPI and records the date). CVE-2026-45758 is product-scoped — the vendor's own package and publishing credentials were compromised — so it is counted in `cve_count_12mo` (basis `exact`) AND `supply_chain_compromise_12mo: true`. The March 2026 litellm PyPI removal already in the record is a dependency-availability event, not a compromise of a Guardrails artifact; keep it in the Incident Timeline with `dependency: BerriAI/litellm` and do not treat it as a supply chain compromise. Guardrails Hub, Pro and Snowglobe are the operator's other surfaces: record incident effects on them in the Contextual Analysis and under C / I as operator-side evidence.

---

## CARRY-FORWARD CHECKS

The prior `sources` list is aggregate. For each candidate dimension, check the URLs below (the ones the prior body relied on for that dimension), recording per URL: resolves (yes/no; new location), last-updated or effective date vs. 2026-05-12, and whether any release note, announcement, or incident in the window touches the dimension.

### D
- https://www.guardrailsai.com/legal/terms-of-use (DPA reference; no public DPA URL at prior evaluation)
- https://www.guardrailsai.com/ (privacy policy link, if any)
- https://www.guardrailsai.com/docs (telemetry / data statements)
### I
- https://www.guardrailsai.com/docs (validator execution model, stop / override controls)
- https://github.com/guardrails-ai/guardrails
### C
- https://hub.guardrailsai.com/ (validator distribution model — Python code executed with customer-process privileges; Hub-side review / signing / sandboxing)
- https://www.guardrailsai.com/docs
- https://github.com/guardrails-ai/guardrails/blob/main/SECURITY_ADVISORY.md (post-incident controls: PyPI Trusted Publishing, token scoping, artifact signing — engine records what the operator states it changed; do not infer)

---

## PUBLIC SOURCES TO CONSULT

### Official project
- Homepage: https://www.guardrailsai.com · Docs: https://www.guardrailsai.com/docs · Hub: https://hub.guardrailsai.com/ · Repository: https://github.com/guardrails-ai/guardrails · PyPI: https://pypi.org/project/guardrails-ai/ (release history: confirm 0.10.1 quarantine state, 0.10.2 publication date, and any later releases)
- Terms of Use: https://www.guardrailsai.com/legal/terms-of-use · Responsible disclosure blog: https://www.guardrailsai.com/blog/commitment-to-responsible-vulnerability · Trust center / SOC 2 / status page: engine to locate (none existed at prior evaluation)
### Security and vulnerability disclosure
- GitHub Security Advisories: https://github.com/guardrails-ai/guardrails/security/advisories · SECURITY.md presence at repository root (absent at prior evaluation; SECURITY_ADVISORY.md now exists — record both facts)
- NVD search terms: "guardrails-ai", "Guardrails AI" · OSV: https://osv.dev/list?q=guardrails-ai · CISA KEV JSON: https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json
- Campaign coverage (two or more independent sources for T4 check): SafeDep, Socket (issue #1473 report), Gurucul threat alert, others the engine finds
### Ownership and identity
- Guardrails AI, Inc. (Delaware C-corp; California entity 5678079 per the prior record) — engine re-confirms; no acquisition or rename expected (T5 check).
### Release and activity record (dormancy test)
- https://github.com/guardrails-ai/guardrails/releases ; PyPI release history — expected active.

---

## FIELD SEMANTICS

Per `_template_update.md` and ENGINE.md Differential Evaluation. Specifically for this record: `cve_count_12mo: 1` if CVE-2026-45758 is confirmed inside the window (basis `exact`); `max_cvss_12mo` = the NVD / CNA score if one exists, else `null` with the reason stated in the body; `supply_chain_compromise_12mo: true`; `evaluator_model` recorded; `independence` re-assessed; `qa` all `pass`; `selection_basis` absent (pre-frame record — do not add); `target_version` set (was `null`). `verdict.<dim>.note` ≤ 80 characters. Omit `dormant_since`. Replace the display / card tags "0 CVEs · 12 Months" with the post-incident facts; `key_finding` ≤ 630 characters.

---

## SPECIAL CONSIDERATIONS

### 1. Prior-record omission (state as fact in the Differential section)
The prior evaluation date (2026-05-12) coincides with the advisory publication date; the malicious release went up at 2026-05-11 18:00 PT, which is 2026-05-12 01:00 UTC. The prior record's `supply_chain_compromise_12mo: false`, R 17/20 and "0 CVEs · 12 Months" tags did not carry the event. Record the fact and the elapsed times; do not characterize the omission.

### 2. Supply chain criterion and elapsed times
R "Supply chain compromise (trailing 12 months)": score on the documented response — detection by third-party researchers within ~2 hours, PyPI quarantine, operator advisory within ~1 day, API-key invalidation 2026-05-13, clean 0.10.2 release (date to verify). "Responded ≤7d: 1" is the expected band; record each timestamp. The "Structural issues" criterion compares root causes: 2024 eval / XXE input-handling CVEs (fixed 0.5.10) versus a 2026 CI-credential compromise — evaluate on the evidence. Since the R-only change is likely to move the total by ≥3 points, the full re-review rule may be reached regardless of the carry-forward checks; if so, state it and re-evaluate all six.

### 3. Disclosure layer
Triggers 0 / 1 / 2 / 3: None (independent operator; Anthropic relationship is framework integration only — Claude is one of multiple supported LLM providers). Engine states "None" after checking KNOWN_FACTS.md Anthropic Equity-Holder Records.

---

## KNOWN FACT CORRECTIONS

None applicable (no Guardrails AI entry in `KNOWN_FACTS.md`).

---

## OUTPUT RULES

Per `_template_update.md`: full English report (`Evaluation type: Update`) with Differential section (carry-forward checks per D / I / C with date and URLs, or the reason a dimension was re-evaluated; prior-record omission stated as fact) and Evaluation History table (2026-05-12 initial 40 · this update); Japanese summary with `評価種別: 更新` and 前回スコア; score tag line; complete front matter for `platforms/guardrails-ai.md` (`evaluated_at: 2026-05-12`, `updated_at: <completion date>`, `previous_evaluation_date: 2026-05-12`, `previous_score: 40`, `framework_version: v0.3.2`, `evaluation_type: update`, `differential` set for all six with `e: null`).

---

## REMINDERS

Public documentation only. Silence = 0. Positive findings alongside risks (advisory publication within a day, named root cause, credential rotation, clean successor release). No intent attribution — record elapsed times, not motives. The prior score is published, not smoothed.

---
# END OF PROMPT

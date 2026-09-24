# VERDICT Update Evaluation Prompt — #031 Superagent (update, 2026-09-24)

Framework v0.3.2 Differential Evaluation. Interrupt lane (T1, CVE-less advisory) with folded routine scope. Fourth in the LayerC-Triage-001 order. Drafted from the 2026-09-22 sweep dry run, which observed one High published advisory for `superagent-ai/superagent` inside the trailing 12 months while the record carries `cve_count_12mo: 0`.

---

## RECORD UNDER UPDATE

**Name / slug:** Superagent / superagent
**Evaluation number:** 031 (unchanged)
**Current canonical record:** `platforms/superagent.md` at ZinovaCreation/verdict-platforms `942d628` — read in full before starting. It is a migrated capture: fragmentary body, `qa` unresolved ×3, `evaluator_model: unrecorded`, `sources` = eight site / organization-level URLs with no per-dimension citations; `operator: Superagent · Gothenburg, Sweden` (display string, not a legal entity name); `target_version: Superagent (superagent.sh; github.com/superagent-ai/superagent, post-pivot)`.
**evaluated_at (never changes):** 2026-03-31
**Previous evaluation (→ `previous_evaluation_date` / `previous_score`):** 2026-03-31 / 42
**Evaluation History so far:** 2026-03-31 Initial (Layer 0) 42 / Tier C / v0.3.1
**Prior framework version / evaluator model:** v0.3.1 / unrecorded
**Prior R fields:** `cve_count_12mo: 0` (basis `exact`), `max_cvss_12mo: null`, KEV entries: none, `supply_chain_compromise_12mo: false`; R 14/20; T 4/10 with the body stating "No SECURITY.md despite being a security company"
**Prior record type:** migrated capture (site-level `sources` only)

---

## TRIGGER

| Trigger | Fact | Date | Source URL (engine verifies on the primary source) |
|---|---|---|---|
| T1 | GHSA-pw7h-8x4q-fwwh: "Safety Agent automatically fetches attacker-controlled URLs, enabling SSRF" — npm `@superagent-ai/safety-agent`, affected ≥ 0.1.3 ≤ 0.1.6, CWE-918, CVSS 3.1 8.6 (High), **no CVE assigned** at drafting; published by the maintainer (homanp) as reporter. The advisory page lists "Patched versions 0.0.7", which is inconsistent with the affected range — engine reads the npm release history and the repository to identify the actual fixed version and states what the advisory page shows. | published 2026-08-13 | https://github.com/superagent-ai/superagent/security/advisories/GHSA-pw7h-8x4q-fwwh ; https://www.npmjs.com/package/@superagent-ai/safety-agent |
| Routine (folded) | Published `next_review_due` 2026-06-29 has lapsed; v0.3.2 base-date routine (2026-03-31 + 365 d) not yet due. Folded because all six dimensions are re-evaluated anyway (see SCOPE). | 2026-09-24 | — |

Engine enumerates the full trailing-12-month set from NVD / GHSA / OSV for the `superagent-ai` organization's packages (npm `@superagent-ai/*`, PyPI `superagent-py` if still published, the `vibekit` packages); the item above is not the count. Disambiguate from the unrelated npm HTTP client `superagent` (visionmedia / ladjs) and its dependency advisories (e.g. form-data CVE-2026-12143), which are out of scope.

---

## SCOPE

**Lane:** Interrupt (T1) with folded routine triggers.
**Mandatory re-evaluation:** R (T1). Because the prior record is a migrated capture with site-level `sources` only, the carry-forward conditions cannot be positively verified for D, I, C; T and V are folded routine scope. **All six dimensions are re-evaluated.** `differential` = `re-evaluated` for v, r, d, i, c, t; `e: null`. This update also resolves the migrated `qa` state.
**Trailing 12-month window for R:** [update date − 12 months] → [update date].
**KEV flag:** none expected; engine checks the KEV JSON and states the result.
**Attribution / target:** the advisory is published under github.com/superagent-ai/superagent, so `@superagent-ai/safety-agent` is inside the evaluated repository / product and is product-scoped. Per Attribution-CVE-001 a CVE-less advisory is **not counted** in `cve_count_12mo` (remains `0`, basis `exact`) and does not set `max_cvss_12mo` (remains `null`, with the advisory's 8.6 stated in the body); it is recorded in the Incident Timeline, considered under T (CVE publication posture: the operator issues repository advisories), and used as evidence for the R "Patch response speed" and "Structural issues" criteria (record the affected-range → fixed-version elapsed time). If a CVE is assigned before the update completes, count it and fill `max_cvss_12mo`. Bind `target_version` to the current product set as documented on superagent.sh and the repository on the update date (post-pivot: Guard / Redact / Scan APIs, AI Firewall, Safety Agent, VibeKit — state which surfaces are in scope).
**T5 check:** re-assess the legal entity (the record's `operator` is a display string), any incorporation or rename, and `independence` / `parent_entity`.

---

## PUBLIC SOURCES TO CONSULT

### Official project
- Homepage: https://www.superagent.sh/ · About: https://www.superagent.sh/about · Legal (terms, privacy, DPA): https://www.superagent.sh/legal · Docs: https://docs.superagent.sh/ · MCP docs: https://docs.superagent.sh/mcp
- Repositories: https://github.com/superagent-ai/superagent · https://github.com/superagent-ai/vibekit · organization: https://github.com/superagent-ai · npm: `@superagent-ai/safety-agent` and sibling packages
### Security and vulnerability disclosure
- Repository security page and SECURITY.md (now present — private reporting via GitHub Security Advisories; "Supported Versions" statement): https://github.com/superagent-ai/superagent/security — record the change from the prior "No SECURITY.md" finding with the file's first-commit date if visible
- GitHub Security Advisories: https://github.com/superagent-ai/superagent/security/advisories · NVD search terms: "superagent-ai", "Superagent AI" · OSV: https://osv.dev/list?q=%40superagent-ai · CISA KEV JSON
### Ownership and identity
- Legal entity and jurisdiction (Sweden / US), YC W24 record, founders (Alan Zabihi, Ismail Pelaseyed) — for V and `independence`
### Release and activity record (dormancy test)
- https://github.com/superagent-ai/superagent/releases ; npm publish dates — expected active (organization activity observed September 2026).

---

## FIELD SEMANTICS

Per `_template_update.md` and ENGINE.md Differential Evaluation. Specifically for this record: `cve_count_12mo: 0` (basis `exact`) unless a CVE is assigned to GHSA-pw7h-8x4q-fwwh or another product-scoped CVE is found; `max_cvss_12mo: null` in that case; `supply_chain_compromise_12mo` recomputed; `evaluator_model` recorded; `qa` all `pass`; `selection_basis` absent (pre-frame record — do not add); `operator` set to the legal entity name. `verdict.<dim>.note` ≤ 80 characters. Omit `dormant_since`. Update `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags ("Zero CVEs" may remain true as a CVE statement only if the advisory is disclosed alongside it; do not publish "Zero CVEs" without the advisory fact next to it — DisplayHonesty-001).

---

## SPECIAL CONSIDERATIONS

### 1. Self-reported advisory
The advisory reporter is the maintainer. Record it as a disclosure-posture fact under T (repository advisories issued, private reporting channel documented) and score the R criteria on the timeline — affected versions 0.1.3–0.1.6, fixed version and its npm publish date, advisory publication 2026-08-13 — without inferring how the issue was found.

### 2. Product scope after the pivot
The evaluated surface has changed since the initial evaluation (agent framework → agent security products). State the in-scope surfaces in the Executive Summary so the score is not read as a rating of the retired framework.

### 3. Disclosure layer
Triggers 0 / 1 / 2 / 3: None expected (independent operator; Y Combinator is not an Anthropic equity-holder). Engine states "None" or the trigger found after checking KNOWN_FACTS.md Anthropic Equity-Holder Records. VibeKit runs Claude Code among other coding agents — a product-integration relationship, disclosed in the Bias Disclosure second paragraph, not a trigger.

---

## KNOWN FACT CORRECTIONS

None applicable (no Superagent entry in `KNOWN_FACTS.md`).

---

## OUTPUT RULES

Per `_template_update.md`: full English report (`Evaluation type: Update`) with Differential section (reason no carry-forward was possible; SECURITY.md change recorded; any prior-record omission stated as fact) and Evaluation History table (2026-03-31 initial 42 · this update); Japanese summary with `評価種別: 更新` and 前回スコア; score tag line; complete front matter for `platforms/superagent.md` (`evaluated_at: 2026-03-31`, `updated_at: <completion date>`, `previous_evaluation_date: 2026-03-31`, `previous_score: 42`, `framework_version: v0.3.2`, `evaluation_type: update`, `differential` all `re-evaluated`, `e: null`).

---

## REMINDERS

Public documentation only. Silence = 0. Positive findings alongside risks (advisory issued with fixed version, SECURITY.md added, private reporting channel). No intent attribution. The prior score is published, not smoothed.

---
# END OF PROMPT

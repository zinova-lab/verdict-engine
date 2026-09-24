# VERDICT Update Evaluation Prompt — #032 Phidata (Agno) (update, 2026-09-24)

Framework v0.3.2 Differential Evaluation. Interrupt lane (T1 ×3) with folded routine scope. Third in the LayerC-Triage-001 order. Drafted from the 2026-09-22 sweep dry run, which observed three High-or-above published advisories for `agno-agi/agno` inside the trailing 12 months while the record carries `cve_count_12mo: 0`.

---

## RECORD UNDER UPDATE

**Name / slug:** Phidata (Agno) / phidata
**Evaluation number:** 032 (unchanged)
**Current canonical record:** `platforms/phidata.md` at ZinovaCreation/verdict-platforms `942d628` — read in full before starting. It is a migrated capture: fragmentary body ("Zero CVEs. Self-hosted data sovereignty. HITL as architecture primitive. Telemetry default ON."), `qa` unresolved ×3, `evaluator_model: unrecorded`, `sources` = five organization-level URLs (docs intro, GitHub org, two repositories, agno.com) with no per-dimension citations.
**evaluated_at (never changes):** 2026-03-31
**Previous evaluation (→ `previous_evaluation_date` / `previous_score`):** 2026-03-31 / 38
**Evaluation History so far:** 2026-03-31 Initial (Layer 0) 38 / Tier C / v0.3.1
**Prior framework version / evaluator model:** v0.3.1 / unrecorded
**Prior R fields:** `cve_count_12mo: 0` (basis `exact`), `max_cvss_12mo: null`, KEV entries: none, `supply_chain_compromise_12mo: false`; R 14/20
**Prior record type:** migrated capture (organization-level `sources` only)

---

## TRIGGER

| Trigger | Fact | Date | Source URL (engine verifies on the primary source) |
|---|---|---|---|
| T1 | CVE-2026-35002 (GHSA-77rh-m34w-rv36, PYSEC-2026-256): arbitrary code execution — `field_type` in a FunctionCall passed to `eval()`; affects Agno < 2.3.24; fixed 2.3.24; CNA VulnCheck; CVSS 4.0 9.3 (Critical); NVD v3.1 score reported as 9.8 by secondary sources — engine reads NVD; finder credited to Palo Alto Networks. | published 2026-04-02 | https://osv.dev/vulnerability/CVE-2026-35002 ; https://github.com/advisories/GHSA-77rh-m34w-rv36 ; https://nvd.nist.gov/vuln/detail/CVE-2026-35002 |
| T1 | CVE-2026-10105 (GHSA-82m5-3pcp-hccq, PYSEC-2026-2333): SQL injection in the ClickHouse vector database backend (`delete_by_metadata()` f-string interpolation); affects 2.6.5; fixed 2.6.6; CVSS 4.0 8.7 (High). | published: engine to read from NVD / cvelistV5 | https://nvd.nist.gov/vuln/detail/CVE-2026-10105 ; https://github.com/agno-agi/agno/issues/7866 ; https://github.com/agno-agi/agno/pull/7883 |
| T1 | CVE-2025-64168 (GHSA-vw84-hprm-cxmm, PYSEC-2026-1077): race condition — `session_state` persisted to the wrong session under high concurrency, cross-user exposure; affects 2.0.0 – < 2.2.2; fixed 2.2.2; CVSS 3.1 7.1 (High). GHSA publication date and NVD publication date (reported as 2026-04-02) are to be read from the primary sources; if the GHSA was published before 2026-03-31 it also fell inside the prior record's window. | engine to confirm | https://github.com/agno-agi/agno/security/advisories/GHSA-vw84-hprm-cxmm ; https://nvd.nist.gov/vuln/detail/CVE-2025-64168 |
| Routine (folded) | Published `next_review_due` 2026-06-29 has lapsed; v0.3.2 base-date routine (2026-03-31 + 365 d) not yet due. Folded because all six dimensions are re-evaluated anyway (see SCOPE). | 2026-09-24 | — |

Additional item for window placement: CVE-2025-8665 (Medium 6.3; "agno-agi agno up to 1.7.5"; published 2025-09-18). Whether it falls inside the trailing window depends on the update date (window start = update date − 12 months); state the decision by date. It fell inside the prior record's window (2025-03-31 → 2026-03-31) — record that as a prior-record omission fact. Engine enumerates the full trailing-12-month set from NVD / GHSA / OSV (search "agno", "agno-agi", "phidata"); the list above is not the count.

---

## SCOPE

**Lane:** Interrupt (T1 ×3) with folded routine triggers.
**Mandatory re-evaluation:** R (T1). Because the prior record is a migrated capture whose `sources` are organization-level pointers rather than per-dimension citations, the carry-forward conditions cannot be positively verified for D, I, C; and T, V are folded routine scope. **All six dimensions are re-evaluated.** `differential` = `re-evaluated` for v, r, d, i, c, t; `e: null`. This update also resolves the migrated `qa` state (full protocol, all `pass`).
**Trailing 12-month window for R:** [update date − 12 months] → [update date].
**KEV flag:** none expected; engine checks the KEV JSON for CVE-2026-35002, CVE-2026-10105, CVE-2025-64168, CVE-2025-8665 and vendorProject "Agno" and states the result.
**Attribution / target:** Agno as distributed via PyPI `agno` and github.com/agno-agi/agno — bind `target_version` to the latest release on the update date. The legacy `phidata` package / repository (github.com/agno-agi/phidata) is the same operator's predecessor artifact: CVEs assigned against `phidata` versions are recorded in the Incident Timeline with the package named and counted only if `target_version` is defined to include the legacy package — decide and state the scope explicitly. Dependency CVEs → `dependency: <vendor/product>`; CVE-less advisories → Incident Timeline and T, not counted.
**T5 check (rename / operator):** the record names `operator: Phidata Inc.` and carries the `rebranded` tag; the product and site are Agno. Engine verifies the current legal entity name on agno.com legal pages / terms and sets `operator`, `independence`, `parent_entity` accordingly. If a published fact in the record has become incorrect (for example the legal name), fire T5 and stage a `KNOWN_FACTS.md` entry candidate in the report's Differential section (Engine ratifies separately; do not edit KNOWN_FACTS.md in the evaluation).

---

## PUBLIC SOURCES TO CONSULT

### Official project
- Homepage: https://www.agno.com/ · Docs: https://docs.agno.com (engine to verify; prior record cites docs.phidata.com/introduction) · Repository: https://github.com/agno-agi/agno · Legacy: https://github.com/agno-agi/phidata · PyPI: https://pypi.org/project/agno/ and https://pypi.org/project/phidata/
- Privacy policy / terms / DPA / sub-processors: engine to locate on agno.com (prior record: "No privacy policy on agno.com"); AgentOS / hosted control-plane documentation if any (in-scope only to the extent publicly documented)
- Telemetry: prior record states "Telemetry enabled by default (model usage to api.phidata.com)" — engine re-reads the current telemetry documentation and default, including the endpoint now in use
### Security and vulnerability disclosure
- GitHub Security Advisories: https://github.com/agno-agi/agno/security/advisories · SECURITY.md presence (absent at prior evaluation) · NVD search terms: "agno", "agno-agi", "phidata" · OSV: https://osv.dev/list?q=agno · CISA KEV JSON
- Third-party advisories: VulnCheck (CVE-2026-35002, CVE-2026-10105), Palo Alto Networks research if published
### Ownership and identity
- Legal entity behind Agno (Phidata Inc. → ?); funding; no parent expected
### Release and activity record (dormancy test)
- https://github.com/agno-agi/agno/releases — expected active (2.x cadence).

---

## FIELD SEMANTICS

Per `_template_update.md` and ENGINE.md Differential Evaluation. Specifically for this record: `cve_count_12mo` = exact count of product-scoped CVEs published inside the window (basis `exact`); `max_cvss_12mo` = highest score on the CVSS version the report states (ENGINE.md reference standard is CVSS v3.1 via NVD; where only a v4.0 score exists, record it and say so); apply the −1 count penalty and the 0-point maximum-CVSS band if any CVSS 9.0+ exists (CVE-2026-35002); `supply_chain_compromise_12mo` recomputed; `evaluator_model` recorded; `qa` all `pass`; `selection_basis` absent (pre-frame record — do not add). `verdict.<dim>.note` ≤ 80 characters. Omit `dormant_since`. Replace "Zero CVEs" in `finding`, `key_finding`, `meta_description`, `og_description` and the display / card tags with the post-window facts.

---

## SPECIAL CONSIDERATIONS

### 1. Structural issues criterion
Three distinct root causes are on record (eval() of attacker-influenced input; SQL string interpolation; session-state race). Evaluate "same root cause recurring" on the evidence; record first-report → patch elapsed times per CVE from the advisories and release tags. No motive attribution.

### 2. Score change explanation
R will move by ≥3 points (count and maximum-CVSS bands both change), which triggers the full re-review rule independently of the migrated-capture reasoning above; if the total moves by ≥5 points, the Executive Summary names the dimensions and evidence. `previous_score: 38` is published alongside.

### 3. Disclosure layer
Triggers 0 / 1 / 2 / 3: None expected (independent operator; no Amazon / Google / Microsoft / NVIDIA equity or channel relationship known). Engine states "None" or the trigger found after checking KNOWN_FACTS.md Anthropic Equity-Holder Records and the operator's funding record.

---

## KNOWN FACT CORRECTIONS

None applicable (no Phidata / Agno entry in `KNOWN_FACTS.md`). A candidate entry may be staged by this update if the T5 check finds a published fact that has become incorrect.

---

## OUTPUT RULES

Per `_template_update.md`: full English report (`Evaluation type: Update`) with Differential section (reason no carry-forward was possible; prior-record omissions stated as facts, including CVE-2025-8665 and any GHSA published before 2026-03-31) and Evaluation History table (2026-03-31 initial 38 · this update); Japanese summary with `評価種別: 更新` and 前回スコア; score tag line; complete front matter for `platforms/phidata.md` (`slug: phidata` unchanged, `evaluated_at: 2026-03-31`, `updated_at: <completion date>`, `previous_evaluation_date: 2026-03-31`, `previous_score: 38`, `framework_version: v0.3.2`, `evaluation_type: update`, `differential` all `re-evaluated`, `e: null`).

---

## REMINDERS

Public documentation only. Silence = 0. Positive findings alongside risks (repository advisories with fixed versions, self-hosted data model, HITL primitives). No intent attribution. The prior score is published, not smoothed.

---
# END OF PROMPT

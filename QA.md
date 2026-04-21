# VERDICT Quality Assurance Protocol

Every VERDICT evaluation report passes through this review before delivery. The review covers factual accuracy and internal consistency, legal risk and inflammatory language, and report quality. Severity is classified Critical / Warning / Note. No item is skipped.

## Revision cycle rule

If any item produces a Critical issue, revise the draft and re-run the full review. Maximum 2 revision cycles. If a Critical issue persists after 2 cycles, flag as `[UNRESOLVED — HUMAN REVIEW REQUIRED]` and deliver with the flag visible.

## 1 · Factual accuracy and internal consistency

### Source verification
- Every CVE number matches the described vulnerability.
- Every CVSS score matches the source (NVD, vendor advisory, CVE record).
- Every compliance certification (SOC 2, HIPAA, ISO 27001, etc.) is verified against the vendor's official documentation.
- Every acquisition, funding, or ownership claim matches public records.
- Every CISA KEV reference matches the current KEV catalog.
- Dates (patch, disclosure, incident) are accurate.
- Numerical claims are verified against cited sources.
- No hallucinated sources, URLs, or statistics.
- Platform, product, and company names are spelled and capitalized correctly.
- **`KNOWN_FACTS.md` corrections are applied.** Violation is Critical.

### Internal consistency
- Scorecard total equals V + R + D + I + C + T.
- Every dimension score in the Scorecard matches its Dimension Detail section.
- Every CVE in the Incident Timeline appears in the R dimension detail.
- Executive Summary score equals Scorecard total.
- VERDICT Record summary score equals Scorecard total.
- Rating (Low/Mid/High) matches the threshold table (70%+ High, 40–69% Mid, 0–39% Low).
- CISA KEV entries appear in Scorecard, Incident Timeline, Executive Summary, and Contextual Analysis.
- Japanese summary scores match English report scores exactly.

### Verification-capability awareness
- Web-search-confirmed claims: treat as verified.
- Knowledge-based claims below 95% confidence: flag `[UNVERIFIED]` in output and state the resolving source.
- Never present unverifiable claims as verified.

### Severity
- **Critical:** Wrong CVE, wrong score, wrong ownership, fabricated source, score mismatch between sections, English / Japanese mismatch, `KNOWN_FACTS.md` violation.
- **Warning:** Outdated info without caveat, minor numerical discrepancy, Rating label mismatch, unverified claim without flag.
- **Note:** Capitalization error, non-material date imprecision.

## 2 · Legal risk and inflammatory language

### Checklist
- No intent attribution to vendors ("deliberately," "chose to hide," "neglected," "failed to").
- No prescriptive negative recommendations ("do not use," "avoid").
- No comparative superiority / inferiority beyond stated scores ("far worse than").
- No speculation about vendor motives or future actions.
- No political framing. Legal and regulatory structures described neutrally.
- No threat language ("we will expose," "companies should be worried").
- Positive findings included alongside risks — at least one strength mentioned.
- Interpretation left to reader ("the data shows," not "this proves").
- No absolutist claims ("never," "always," "impossible") unless quoting a vendor's own documentation.
- No sarcasm, irony, or rhetorical questions that could read as mockery.
- No ad hominem references to individuals. Critique systems, not people.
- Complies with "witness, not judge."

### Inflammatory language blocklist (auto-fail if applied to a vendor)

```
negligent, incompetent, fraudulent, scam, coverup, cover-up,
deceptive, reckless, dishonest, untrustworthy, dangerous,
shocking, inexcusable, unacceptable, disastrous, damning,
betrayal, scandal, alarming, egregious, appalling, outrageous,
weaponized, predatory, complicit, willful, malicious,
catastrophic (unless quoting a CVSS severity label)
```

`malicious` and `catastrophic` are acceptable when describing a threat actor's actions, not the vendor's.

### Severity
- **Critical:** Intent attribution, prescriptive negative recommendation, blocklist word applied to a vendor.
- **Warning:** Missing positive finding, absolutist claim, comparative language.
- **Note:** Tone slightly aggressive but technically defensible.

## 3 · Report quality

Evaluation reports are structured documents. Bullet points, tables, and consistent formatting are expected and appropriate here — unlike LinkedIn posts, reports are not penalized for structured formatting.

### Checklist
- A CTO reading this would find it professional and useful for procurement.
- A security researcher would find the technical depth credible.
- A journalist could cite it without re-verifying basic facts.
- A vendor would disagree with the score but not with the fairness of the process.
- Executive Summary is 3–5 sentences and conveys the most important findings.
- Contextual Analysis represents the vendor's position fairly, including mitigating factors.
- No sensationalism or desperate tone.
- Tone consistent with institutional authority.
- Screenshot test: any out-of-context section would enhance, not damage, VERDICT's reputation.
- Output Format complete — no missing sections.
- Bias Disclosure present with exact mandated wording.
- Japanese summary complete and follows the template.

### AI writing blocklist (Executive Summary and Contextual Analysis only)

```
It's worth noting, Interestingly, In today's rapidly evolving,
game-changer, wake-up call, At the end of the day, Moving forward,
robust (non-technical), leverage (as verb), navigate (metaphorical),
holistic, synergy, deep dive
```

- Executive Summary opens with a specific finding, not a grand abstract statement.
- Contextual Analysis reads like expert analysis, not a committee report.

### Severity
- **Critical:** Missing mandatory section, missing Bias Disclosure, content that would damage VERDICT's reputation if shared out of context.
- **Warning:** Tone inconsistency, AI-writing tells in narrative sections, incomplete Japanese summary.
- **Note:** Minor style preferences, optimization opportunities.

## Output

Before delivering the final report, emit this block:

```
═══ QA REVIEW ═══
Factual:   [PASS/FAIL] — [issues summary or "CLEAR"]
Legal:     [PASS/FAIL] — [issues summary or "CLEAR"]
Quality:   [PASS/FAIL] — [issues summary or "CLEAR"]
Result:    [CLEARED / REVISION n/2 / UNRESOLVED — HUMAN REVIEW]
══════════════
```

Then deliver the final report (English markdown + Japanese summary).

## Escalation

If during the review you discover an issue you cannot resolve with available information:

1. Do not guess or present uncertain information as fact.
2. Flag it as `[UNVERIFIED]` in the final output.
3. State the specific source or action needed to resolve it.
4. Deliver with the flag visible.

After 2 revision cycles with unresolved Critical issues, flag as `[UNRESOLVED — HUMAN REVIEW REQUIRED]` and halt revisions.

---

**Protocol version:** 1.1-engine
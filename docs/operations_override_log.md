# VERDICT Operations Override Log

> **Purpose.** Canonical institutional registry of all Operations Override
> events under VERDICT framework. An Operations Override occurs when the
> engine-output Tier text differs from the threshold-derived Tier per
> ENGINE.md `## Tier Letter Assignment` (codified 2026-04-29, commit bd8cf2b),
> and Operations applies the threshold-derived Tier as the canonical
> assignment per QA.md `## Operations Override Rules`.
>
> **Authority.** This registry is the institutional audit trail for all
> Operations Override events. Each entry is appended at deploy time; entries
> are immutable once recorded (corrections, if needed, are appended as
> subsequent entries rather than rewriting prior ones).
>
> **Cross-references.**
> - ENGINE.md `## Tier Letter Assignment` — canonical Tier threshold table
> - QA.md `## Operations Override Rules` — codified override procedure
> - docs/operations_session_sop.md Section 3 — Tier override checklist
> - Canonical platform .md per platform — per-platform `tier_override_rationale` field
>
> **Created.** 2026-05-12 by Operations session (062-064 batch deploy session).
> **Inaugural entries.** Backfilled for prior Operations Overrides in the
> 2026-04 evaluation cycle to establish full institutional traceability.

---

## Registry

| Date | Eval # | Platform | Score | Engine Tier | Operations Tier | Direction | Notes |
|------|--------|----------|-------|-------------|-----------------|-----------|-------|
| 2026-04-28 | #059 | E2B | 46 | C | B | upward | Score 46 ∈ B band [45-54]. Engine output C was below threshold-derived band. |
| 2026-04-29 | #061 | Mistral La Plateforme | 55 | B | A | upward | Score 55 ∈ A band [55-64], lower boundary. Precedent: AWS Bedrock Agents (55 = A). |
| 2026-05-12 | #062 | LangSmith | 55 | B | A | upward | Score 55 ∈ A band [55-64], lower boundary. Consistent with #061 application. |
| 2026-05-12 | #064 | Guardrails AI | 40 | B | C | downward | Score 40 ∈ C band [35-44]. **First downward Operations Override in VERDICT history.** Recorded as institutional precedent for symmetric (upward + downward) application of Operations Override Rules. |

---

## Directional Statistics (as of 2026-05-12)

| Direction | Count | Platforms |
|-----------|------:|-----------|
| Upward (engine Tier below threshold-derived Tier) | 3 | #059 E2B, #061 Mistral La Plateforme, #062 LangSmith |
| Downward (engine Tier above threshold-derived Tier) | 1 | #064 Guardrails AI |
| No override (engine Tier = threshold-derived Tier) | 60 | All other platforms in current 64-platform evaluation set |
| **Total Operations Overrides** | **4** | — |

---

## Institutional Notes

### Symmetric directional application principle

Operations Override Rules are applied symmetrically regardless of direction
(upward or downward). The principle is consistent application of
ENGINE.md `## Tier Letter Assignment` thresholds; the direction of override
is a consequence of the score-versus-threshold relationship, not an
independent decision variable.

The 2026-05-12 application to #064 Guardrails AI establishes the institutional
precedent that downward overrides are applied with identical procedure as
upward overrides, completing the symmetric application of the rule.

### Recording convention

- Each entry is appended chronologically by deploy date.
- The `Notes` column records: score-versus-band relationship, any relevant
  precedent cross-reference, and any other institutionally relevant context.
- Entries are immutable. If an entry contains a factual error, a subsequent
  entry records the correction; the original is not edited.

### Future entry pattern

Future Operations Override events follow this entry pattern:

```
| YYYY-MM-DD | #NNN | <Platform> | <Score> | <Engine Tier> | <Operations Tier> | <upward|downward> | <Score band relationship + precedent reference if any> |
```

### Visibility

This registry is committed to the public verdict-engine repository at
docs/operations_override_log.md and is accessible to all external auditors,
researchers, vendors, and observers. Canonical platform .md files reference
their Operations Override events via the `tier_override_rationale` YAML
frontmatter field; this registry provides the cross-platform institutional
view that individual platform .md files do not.

---

**Registry version:** 1.0
**Inaugural commit:** [populated upon commit hash issuance]
**Next entry trigger:** Any future Operations Override event during deploy.

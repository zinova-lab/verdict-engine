# VERDICT Known Fact Corrections

The evaluation engine must apply these corrections in every report. Violations are Critical failures in the factual-accuracy review.

This document accumulates facts that have been incorrectly stated in past evaluations, in vendor marketing materials, or in recycled public sources. When an entity listed below appears in an evaluation, the corrected information here is authoritative and supersedes other sources.

## Entries

### Manus AI / Butterfly Effect Pte. Ltd.

- **Operator:** Butterfly Effect Pte. Ltd. (Singapore-registered).
- **Status:** Independent startup. Not acquired by any company.
- **Team context:** Engineering team based in Beijing / Wuhan; corporate entity registered in Singapore.
- **Do NOT state:** "acquired by Meta," "Meta-owned," "Meta subsidiary," or any other acquisition claim.
- **Do NOT state:** "$2B+ valuation" or "$2B acquisition" — these are unverified rumors.
- **Approved funding language:** "$500M+ funding" (conservative, publicly documented).
- **Approved comparison phrasing:** "closed-source, Singapore-registered (Butterfly Effect Pte. Ltd.), Chinese founding team"
- **Root cause of prior error:** Early evaluation drafts contained an unverified acquisition rumor not caught during QA. Japanese summaries for evaluations #051, #053, and #054 contained the error; HTML was corrected 2026.04.07.

*(Future entries are appended below as corrections are identified and resolved.)*

## How to add an entry

Each entry uses this structure:
- **Entity name** (operator / product / family).
- **Operator** — legal entity and jurisdiction.
- **Status** — ownership, acquisition history, relevant structural facts.
- **Team / corporate context** — any nuance distinguishing operation from registration.
- **Do NOT state** — explicit list of incorrect claims to reject.
- **Approved language** — the phrasing the engine uses in reports.
- **Root cause** — what caused the prior error, documented for learning.

Entries are added when: a published evaluation contains an error requiring correction; a recurring misstatement in public sources is identified; or a vendor response documents a factual correction with supporting evidence.

## Review cadence

During the factual-accuracy review (see `QA.md`, section 1), the engine cross-checks every entity mentioned in the draft against this document before delivery.

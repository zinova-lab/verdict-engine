# VERDICT Evaluation Prompt — Template

Fill in each section. Remove instructional lines (prefixed with `>`) before use.

---

## PLATFORM UNDER EVALUATION

**Name:** [platform name]
**Owner:** [legal entity + jurisdiction + independence status]
**Category:** [e.g., AI Coding Agent / Workflow Automation / Browser Agent]
**Primary product surfaces:** [list product forms — CLI, web app, SDK, cloud service, self-hosted — and the distribution channel for each]
**Product URL:**
**GitHub:**
**Documentation:**

---

## EVALUATION SCOPE

Evaluate [platform] under VERDICT Framework v0.3.1 (Layer 0, public documentation only).
Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

---

## KNOWN PUBLIC SOURCES

> List every public URL the engine should consult. Group by category.

### Official project
- Homepage:
- Documentation:
- Privacy policy:
- Security page:
- Terms of service:

### Package distribution (if applicable)
- PyPI / npm / Homebrew / GitHub Releases:

### Security and vulnerability disclosure
- GitHub SECURITY.md:
- GitHub Security Advisories:
- CVE database (NVD) search terms:
- OSV database: https://osv.dev/
- Bug bounty / VDP URL (if any):

### Community signals
- GitHub stars, forks, contributor count
- Security-tagged issues
- Release cadence

### Behavioral model
> Describe what the platform actually does — file system access, network access, command execution, auto-commit behavior, credential handling.

---

## EVALUATION FOCUS AREAS

> For each dimension, list the specific questions the engine must answer from public sources. Be concrete; do not restate the framework.

### V — Verifiability
- [dimension-specific questions]

### R — Resilience
- [dimension-specific questions]

### D — Data Conduct
- [dimension-specific questions]

### I — Identity & Control
- [dimension-specific questions]

### C — Containment
- [dimension-specific questions]

### T — Transparency
- [dimension-specific questions]

---

## SPECIAL CONSIDERATIONS

> Use only for material facts that affect scoring or phrasing — supply chain context, maintainer structure, architectural distinctiveness. No commentary or speculation. Three entries maximum.

### 1. [Concise heading]
[1–3 sentences]

---

## KNOWN FACT CORRECTIONS

> Reference any entries in `KNOWN_FACTS.md` that apply to this platform. If none, state "None applicable."

---

## OUTPUT RULES

1. Full English report in a markdown code block (see `ENGINE.md` Output Format).
2. Japanese summary in a `japanese-summary` code block.
3. Score tag line:
```
   Score: XX/85
   V: XX/20, R: XX/20, D: XX/15, I: XX/10, C: XX/10, T: XX/10
   Dimensions verified: V+R+D+I+C+T = XX
```
4. Tier classification (S / A / B / C / D) and category label.

---

## REMINDERS

- Public documentation only (Layer 0).
- Silence = 0.
- Include positive findings alongside risks.
- No intent attribution.
- Structural or maintainer context noted neutrally, not as excuse.

---
# END OF PROMPT
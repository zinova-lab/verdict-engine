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


## Anthropic Equity-Holder Records (Framework v1.1 Reference)

These facts establish the **material Anthropic equity-holders set** referenced in ENGINE.md framework v1.1 materiality framework. Inclusion criterion: publicly-disclosed equity commitment of USD 1 billion or greater (whether closed or subject to closing conditions). The set is used by framework v1.1 Triggers 1 and 2 to determine when Special Considerations disclosure is required.

The set as of 2025-11-18 contains four members: Amazon, Google, Microsoft, NVIDIA. Future additions require Strategy ratification before incorporation into evaluations.

### NVIDIA — strategic equity commitment in Anthropic

**Fact**: NVIDIA committed to invest up to USD 10 billion in Anthropic, subject to closing conditions, as part of a strategic partnership announced on 2025-11-18.

**Primary source**: NVIDIA Corporation, Form 10-Q for the quarterly period ended 2025-10-26 (FY2026 Q3), filed with the U.S. Securities and Exchange Commission. The filing states: "In November 2025, we entered into an agreement, subject to certain closing conditions, to invest up to $10 billion in Anthropic."

**Source URL**: https://www.sec.gov/Archives/edgar/data/0001045810/000104581025000230/nvda-20251026.htm

**Concurrent disclosures**:
- Anthropic official announcement (2025-11-18): https://www.anthropic.com/news/microsoft-nvidia-anthropic-announce-strategic-partnerships
- NVIDIA Newsroom (2025-11-18): https://blogs.nvidia.com/blog/microsoft-nvidia-anthropic-announce-partnership/

**Related commitments**: NVIDIA and Anthropic announced concurrent technology partnership including Anthropic's adoption of NVIDIA architecture and joint optimization of NVIDIA architectures for Anthropic workloads.

### Microsoft — strategic equity commitment in Anthropic

**Fact**: Microsoft committed to invest up to USD 5 billion in Anthropic as part of the same 2025-11-18 strategic partnership announcement.

**Primary source**: Microsoft official corporate blog (2025-11-18).

**Source URL**: https://blogs.microsoft.com/blog/2025/11/18/microsoft-nvidia-and-anthropic-announce-strategic-partnerships/

**Concurrent disclosures**:
- Anthropic official announcement (2025-11-18): https://www.anthropic.com/news/microsoft-nvidia-anthropic-announce-strategic-partnerships
- Press coverage: CNBC (2025-11-18), Capacity (2025-11-18)

**Related commitments**: Anthropic committed to purchase USD 30 billion of Azure compute capacity, with contracted additional compute capacity up to 1 gigawatt. Anthropic's Claude models become available on Microsoft Azure, making Claude the only frontier model available across all three major cloud platforms (AWS, Google Cloud, Azure).

### Amazon — strategic equity position in Anthropic

**Fact**: Amazon holds a strategic equity position in Anthropic, with publicly-disclosed investment totaling USD 8 billion across multiple commitments (initial USD 4 billion announced 2023-09 and expanded USD 4 billion announced 2024-03 and subsequent rounds).

**Primary source**: Amazon press release (2024-03-27) and subsequent Anthropic announcements.

**Source URL**: https://www.aboutamazon.com/news/company-news/amazon-anthropic-ai-investment

**Related commitments**: Anthropic uses AWS as primary cloud provider; Anthropic adopted AWS Trainium and Inferentia chips for training and inference. AWS Bedrock provides managed access to Claude models.

### Google — strategic equity position in Anthropic

**Fact**: Google (via Alphabet Inc.) holds a strategic equity position in Anthropic, with publicly-disclosed investment exceeding USD 2 billion (announced 2023-10, with subsequent additional commitments reported through 2024–2025).

**Primary source**: Multiple Anthropic and Google Cloud public announcements; reported in major financial press.

**Source URL**: https://www.anthropic.com/news (refer to dated announcements 2023-10 and subsequent)

**Related commitments**: Anthropic uses Google Cloud as a strategic cloud provider; Claude models are available on Google Cloud Vertex AI.

### Anthropic valuation context (as of 2025-11-18)

**Fact**: Following the NVIDIA and Microsoft equity commitments announced 2025-11-18, Anthropic's valuation was reported in the range of USD 350 billion, approximately double its valuation in the September 2025 funding round.

**Primary sources**:
- CNBC (2025-11-18): https://www.cnbc.com/2025/11/18/anthropic-ai-azure-microsoft-nvidia.html
- Press coverage including The Motley Fool (2025-11-24)

**Note**: Valuation figures are reported, not formally disclosed in SEC filings (Anthropic is privately held). The figure is included as a contextual reference for the materiality framework but is not itself a triggering fact.

### Reference for framework v1.1 application

When applying framework v1.1 triggers (see ENGINE.md), evaluators verify whether the evaluated platform's parent entity (Trigger 1) or cap-table investor (Trigger 2) appears in the material Anthropic equity-holders set defined above. The set is canonical as of the date indicated; additions to the set occur only through Strategy ratification.

For commercial relationships not falling under Triggers 1, 2, or 3 (e.g., a platform that merely uses NVIDIA GPUs for inference, or is distributed on AWS Marketplace under standard terms), no Anthropic-equity-holder disclosure is required, even if the platform's vendor relationships involve set members. These are explicitly non-triggering relationships per ENGINE.md framework v1.1.

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

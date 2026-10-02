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

### Anthropic, PBC — evaluator identity (Framework v0.3.2 Trigger 0)

- **Operator:** Anthropic PBC, registered address 548 Market St, PMB 90375, San Francisco, CA 94104 (United States); data controller for users outside the European Region. The European Region controller is Anthropic Ireland, Limited (Dublin).
  Source: Anthropic Privacy Policy, section 9 "Contact Information" — https://www.anthropic.com/legal/privacy (verified 2026-09-21; archived edition effective 2026-07-08 at https://www.anthropic.com/legal/archive/21d66aa9-68f6-4356-ba01-2825b0f81805 carries the same entity and address; site footer "© 2026 Anthropic PBC").
- **Corporate form:** Delaware public benefit corporation.
  Sources: Harvard Law School Forum on Corporate Governance, "Anthropic Long-Term Benefit Trust" (2023-10-28), authored by Anthropic's outside counsel — https://corpgov.law.harvard.edu/2023/10/28/anthropic-long-term-benefit-trust/ ; U.S. federal entity registration (legal name ANTHROPIC, PBC; state of incorporation DE; HQ San Francisco) as mirrored at https://www.highergov.com/awardee/anthropic-pbc-782300426 (SAM.gov mirror; secondary).
- **Status:** Provider of VERDICT's evaluation tooling. Any product developed or operated by Anthropic PBC fires ENGINE.md Trigger 0 (evaluator identity), which always co-fires Trigger 2 (material Anthropic equity-holders are by definition material investors in the evaluated platform).
  Sources: ENGINE.md Bias Disclosure verbatim text ("This evaluation uses Claude (Anthropic) as its tooling …") — https://github.com/zinova-lab/verdict-engine/blob/main/ENGINE.md ; recorded `evaluator_model` values in canonical platform files (e.g. `claude-opus-4-7` in https://github.com/ZinovaCreation/verdict-platforms/blob/main/platforms/aider.md).
- **Product family (non-exhaustive; the operator test is decisive, not this list):** Claude (consumer and enterprise apps, claude.ai), Claude Code, Claude Cowork, Claude in Chrome, and the Claude Platform (API / developer platform), as listed on Anthropic's site — https://claude.com/product/overview , https://claude.com/product/claude-code , https://claude.com/platform/api . MIT AI Agent Index 2025 entries `claude` and `claude-code` are in this family (https://aiagentindex.mit.edu/2025/claude , https://aiagentindex.mit.edu/2025/claude-code).
- **Approved language:** the evaluator-identity paragraph defined verbatim in ENGINE.md (fixed under EvaluatorIdentity-001; any change requires a new ratification).
- **Do NOT state:** that the evaluation is independent of the operator, or that the evaluator relationship is limited to market competition.
- **Root cause:** Entry created 2026-09-19 (EvaluatorIdentity-001; sources added 2026-09-21 per StrategyApproval-001 clause (a)) ahead of the MIT AI Agent Index queue reaching these entries; no prior published error.

### Agno / Agno Inc. (formerly Phidata / Phidata Inc.)

- **Operator:** Agno Inc., registered in New York, United States; 169 Madison Ave STE 2420, New York, NY 10016; support@agno.com (Terms of Service, last updated 2025-01-21, opening clause and §24; Privacy Notice §16). Consistent with the site copyright "© 2026 Agno Inc." and the repository LICENSE.
  Sources: https://os.agno.com/legal/tos ; https://os.agno.com/legal/privacy ; https://github.com/agno-agi/agno/blob/main/LICENSE
- **Status:** Independent; no parent entity. One recorded funding round (Seed, USD 5.4M, 2024-08-29; investors include GreatPoint Ventures) per CB Insights (secondary; profile retained under the former name at /company/phidata). No Amazon / Google / Microsoft / NVIDIA equity, board or channel relationship found: ENGINE.md disclosure Triggers 0–3 do not fire.
  Source: https://www.cbinsights.com/company/phidata/financials
- **Team / corporate context:** Product, site and repository renamed from Phidata to Agno; the GitHub organization remains `agno-agi`; `agno-agi/phidata` and PyPI `phidata` are predecessor artifacts outside the evaluated target. `agno-agi/agno` is licensed Apache-2.0 since February 2026 (changed from MPL 2.0); `agno-agi/phidata` remains MPL 2.0. Telemetry (default ON, metadata only) is observed at os-api.agno.com; the hosted Control Plane is os.agno.com (app.agno.com is being sunset).
  Sources: https://www.agno.com/articles/community-roundup-february-2026 ; https://docs.agno.com/telemetry ; https://community.agno.com/t/logs-to-os-api-agno-com/1864
- **Do NOT state:** "Phidata Inc." as the current operator; "MPL 2.0" as the license of `agno-agi/agno`; "api.phidata.com" as the telemetry endpoint; "no privacy policy" (Privacy Notice at os.agno.com/legal/privacy, last updated 2026-04-20); "Zero CVEs" for the trailing-12-month windows ending 2026-03-31 or 2026-09-25 (CVE-2025-8665, CVE-2025-64168, CVE-2026-35002, CVE-2026-10105, CVE-2026-76832 are on record); that the complete Agno product is open source — the SDK and AgentOS runtime are Apache-2.0, the paid hosted Control Plane (os.agno.com) is closed source, so V source code disclosure is 2 (open core, Criterion-VSource-001).
- **Approved language:** "Agno (formerly Phidata), operated by Agno Inc.; SDK and AgentOS runtime under Apache-2.0; hosted Control Plane at os.agno.com; legacy Phidata artifacts excluded from CVE attribution."
- **Root cause:** The #032 initial record (2026-03-31) was a migrated capture without per-dimension sources; it carried operator "Phidata Inc." although the Terms of Service had named Agno Inc. since 2025-01-21, category "OSS (MPL 2.0)" after the February 2026 license change, telemetry endpoint api.phidata.com, "No privacy policy on agno.com", and `cve_count_12mo: 0` although two CVEs (published 2025-08-06 and 2025-10-31) fell inside its window. Corrected by the 2026-09-25 update (framework v0.3.2; KnownFacts-Agno-001). The 2026-09-25 update itself scored V source code disclosure 4 without accounting for the closed Control Plane; corrected to 2 on 2026-09-27 (40/85 → 38/85, Tier C unchanged; KnownFacts-Agno-001 rev.2).

### Flowise / FlowiseAI Inc. (Workday)

- **Operator:** FlowiseAI Inc., a Delaware corporation; 9450 SW Gemini Drive, Beaverton, Oregon 97008, United States; support@flowiseai.com. The FlowiseAI Service Terms (effective 2024-06-03) incorporate the Workday Online Terms of Service by reference.
  Source: https://flowiseai.com/terms
- **Status:** Subsidiary of Workday, Inc.; acquisition announced 2025-08-14, terms not disclosed. Workday is not a material Anthropic equity-holder (Trigger 1 does not fire); no Trigger 2 or 3 relationship was found at the parent level at the 2026-09-25 update.
  Source: https://newsroom.workday.com/2025-08-14-Workday-Acquires-Flowise,-Bringing-Powerful-AI-Agent-Builder-Capabilities-to-the-Workday-Platform
- **Team / corporate context:** The Flowise team announced a product sunset: code freeze 2026-07-29; repository to public archive (announced for 2026-08-10; GitHub shows "archived by the owner on Aug 13, 2026"); end of life 2026-08-31, when core-team presence in Discord and GitHub concludes; npm packages and Docker images to be marked deprecated. The repository SECURITY.md states that new security vulnerability reports are no longer accepted. The last npm release is `flowise` 3.1.4 (2026-07-29). Licensing: Apache-2.0, except `packages/server/src/enterprise` and files with an explicit copyright notice, which are under the FlowiseAI Commercial License — open core under Criterion-VSource-001 (V source code disclosure 2).
  Sources: https://flowiseai.com/sunset ; https://github.com/FlowiseAI/Flowise ; https://github.com/FlowiseAI/Flowise/blob/main/SECURITY.md ; https://github.com/FlowiseAI/Flowise/blob/main/LICENSE.md ; https://www.npmjs.com/package/flowise
- **Do NOT state:** "Acquired by Workday (Aug 2025)" as the operator string, or `independence: independent`; that Flowise is actively maintained, or accepts vulnerability reports, after the sunset dates above; that the whole of Flowise is Apache-2.0 open source; that CVE-2025-55346 or CVE-2025-58434 belong to the March 2026 (3.0.13) fix cluster — they were published 2025-08-14 and 2025-09-12, and the 3.0.13 cluster is CVE-2026-30820 to CVE-2026-30824 and CVE-2026-31829 (published 2026-03-07 to 2026-03-10).
- **Approved language:** "Flowise, operated by FlowiseAI Inc. (Delaware), a Workday subsidiary since August 2025; open core (Apache-2.0 with a commercially licensed enterprise directory); sunset announced — repository archived August 2026, end of life 2026-08-31."
- **Root cause:** The #007 record (migrated capture, 2026-03-24) carried the operator string "Acquired by Workday (Aug 2025)" with `independence: unrecorded`, and a key finding that placed CVE-2025-55346 and CVE-2025-58434 in the March 2026 cluster. Corrected by the 2026-09-25 update (framework v0.3.2; KnownFacts-Flowise-001).

### n8n / n8n GmbH

- **Operator:** n8n GmbH, Novalisstr. 10, 10115 Berlin, Germany; commercial register HRB 212509 B, Amtsgericht Charlottenburg (Berlin).
  Source: https://n8n.io/imprint/
- **Status:** Independent; no controlling shareholder disclosed. USD 180M Series C announced 2025-10-09, led by Accel; n8n's announcement names NVentures (NVIDIA's venture capital arm) and T.Capital as corporate investors, and Accel's announcement names NVentures among the round's strategic partners — ENGINE.md Trigger 2 fires for NVIDIA under Trigger2-Designation-001. SAP invested in May 2026 (announced 2026-05-12; valuation USD 5.2bn; Joule Studio embedding); no change of control or board seat is stated, and SAP is not a material Anthropic equity-holder.
  Sources: https://blog.n8n.io/series-c/ ; https://www.accel.com/news/our-investment-in-n8n-the-ai-platform-for-automation ; https://blog.n8n.io/n8n-sap/
- **Team / corporate context:** n8n is fair-code, not OSI open source: the repository is under the Sustainable Use License, and files with ".ee." in the filename or ".ee" in the directory name require an n8n Enterprise License (V source code disclosure 2 under Criterion-VSource-001). n8n's advisories use CVSS 4.0 as the primary score and carry CVSS 3.1 vectors for backward compatibility; VERDICT records v3.1 per Attribution-CVE-002.
  Source: https://github.com/n8n-io/n8n/blob/master/LICENSE.md
- **Do NOT state:** "open source" for n8n (use "fair-code, source-available"); CVE-2026-21877 as CVSS 10.0 — its CNA vector (AV:N/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H) computes to 9.9, which the GitHub advisory displays; "12+ CVEs" for the trailing window ending 2026-09-25 (175 on record, basis exact); that no Anthropic equity-holder is invested in n8n.
- **Approved language:** "n8n, operated by n8n GmbH (Berlin, HRB 212509 B); fair-code under the Sustainable Use License, with n8n Enterprise License (.ee.) files; independent; NVIDIA, through NVentures, participated in the October 2025 Series C (Trigger 2 disclosed)."
- **Root cause:** The #001 record (migrated capture, 2026-03-24) carried category "Open Source", CVSS 10.0 for CVE-2026-21877 and a count of "12+" (lower_bound). Corrected by the 2026-09-25 update (framework v0.3.2; KnownFacts-n8n-001).

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

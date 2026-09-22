# VERDICT Evaluation Prompt — #070 Glean Agents

First evaluation carrying `selection_basis` (SelectionFrame-002; StrategyApproval-001). Doubles as the Phase X hands-off end-to-end deploy demonstration: the output must fit the canonical schema (47 properties, 21 required) without new fields. Framework v0.3.2.

---

## PLATFORM UNDER EVALUATION

**Name:** Glean Agents (the agent product of the Glean Work AI platform; MIT AI Agent Index 2025 entry `glean-agents` — evaluated at product level to match that entry per Population Definition §5 strict matching)
**Owner:** Glean Technologies, Inc. — engine to verify the legal entity name, state of incorporation and principal place of business (Palo Alto, California per public reporting) on Glean's terms/privacy pages. Independent company (no parent). Series F (2025-06-10) led by Wellington Management with Khosla Ventures, Bicycle Capital, Geodesic Capital, Archerman Capital and returning investors including Altimeter, Capital One Ventures, Citi, Coatue, DST Global, General Catalyst, ICONIQ, IVP, Kleiner Perkins, Latitude Capital, Lightspeed, Sapphire Ventures, Sequoia, SoftBank Vision Fund 2 and Craft Ventures — engine to confirm from https://www.glean.com/press (Series F release) and set `independence: independent`.
**Selection basis:** `list:mit-2025`
**Category:** Enterprise AI Assistant · Agent Platform · Cloud SaaS (nearest existing record: #027 Amazon Q Business, "Enterprise AI Assistant · Cloud SaaS"; evaluate on the rubric independently, not comparatively)
**Primary product surfaces:**
- Glean Agents / Agent Builder / Agent Library (no-code and code agent creation inside the Glean platform)
- Glean Assistant and Glean Search (the platform the agents run on; permission-aware enterprise search over connected apps)
- Glean API and SDK / MCP server (engine to verify the current developer surface at developers.glean.com)
- Browser extension (Chrome Web Store listing) and desktop/mobile clients (engine to verify)
- Deployment: cloud SaaS with customer-dedicated cloud infrastructure claims ("client-specific cloud" language appears in third-party summaries — verify against Glean's own trust documentation; do not score marketing claims)
**Product URL:** https://www.glean.com
**GitHub:** null — closed source (record `github: null` per Schema-GithubField-001; an official org, if any, is not the evaluated target)
**Documentation:** https://developers.glean.com (engine to verify) · Help Center (engine to locate)

---

## EVALUATION SCOPE

Evaluate Glean Agents under VERDICT Framework v0.3.2 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

The evaluated surface is the Glean cloud platform's agent product as publicly documented. Foundation-model behaviour of the underlying LLMs (Glean is model-agnostic per public materials) is out of scope; Glean's own data handling, permissions model, agent controls and disclosure conduct are in scope.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://www.glean.com
- Press: https://www.glean.com/press (Series F 2025-06-10)
- Privacy policy: https://www.glean.com/privacy (third-party trackers record a last-updated date of 2026-05-05 — engine to read the current effective date on the page)
- Terms of service, DPA, sub-processor list, security page / trust center: engine to locate canonical URLs (trust.glean.com and glean.com/security are the typical patterns; do not assume they exist)
- Documentation / API reference: developers.glean.com (engine to verify)
- Status page: engine to locate
### Package distribution
- Chrome Web Store: https://chrome.google.com/webstore/detail/glean/cfpdompphcacgpjfbonkdokgjhgabpij (extension listing; developer contact visible there)
- SDK packages on PyPI / npm, if published (engine to verify; supply chain check STEP 3a applies if any exist)
### Security and vulnerability disclosure
- NVD search terms: "Glean", "Glean Technologies"
- CISA KEV catalog JSON: https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json
- OSV: https://osv.dev/list?q=glean (disambiguate from unrelated packages named "glean", including Mozilla Glean telemetry — attribution is product-scoped per ENGINE.md Attribution note)
- Bug bounty / VDP: engine to locate (security.txt, HackerOne/Bugcrowd)
### Community signals
- Independent security research on enterprise search agents / prompt-injection exposure of connected-data agents (only if it names Glean and is dated)
- MIT AI Agent Index 2025 entry `glean-agents` (aiagentindex.mit.edu — engine to verify the entry URL)
### Behavioral model
> Agents act over connected enterprise applications (100+ connectors claimed: Gmail, Slack, Teams, Salesforce, Jira, Notion, Zendesk, etc.), inheriting each user's permissions; agents can take actions in those apps, not only retrieve. The engine documents from public sources: what actions agents can execute, how permissions are enforced at action time, whether human approval gates exist and their defaults, how agent runs can be stopped, and what telemetry the platform collects.

---

## EVALUATION FOCUS AREAS

### V — Verifiability
- Corporate registration and official contact both confirmable from Glean's own pages?
- Closed source: 0 on source disclosure unless core components are published.
- Release notes / changelog publicly available with dates?
- Sub-processor list with update date?
- SOC 2 report publicly available, customers-only, or SOC 3 only? HIPAA / ISO 27001 claims verified against Glean's trust documentation (not third-party summaries).
- API reference completeness and behavioural spec for agents.

### R — Resilience
- Any CVEs attributable to Glean products (product-scoped)? Expected sparse for a closed SaaS — record "no public CVEs confirmed" with the search set used if none.
- Publicly reported security incidents involving Glean (two or more independent sources)?
- Supply chain: any published SDK/extension compromise; extension update history.

### D — Data Conduct
- GDPR / DPA availability; explicit training-use statement (public materials claim exclusion of customer data from LLM training — score only what Glean's own documents state); retention periods per category; telemetry defaults; sub-processors.

### I — Identity & Control
- Emergency stop / disable of agents (admin controls documented?); human-in-the-loop defaults for agent actions; delegation chain: how an agent's permissions derive from the user's, and whether that is documented.

### C — Containment
- Allowlist vs blocklist model for connectors and agent actions; least-privilege defaults; tenant isolation claims and any independent evidence (customer-dedicated infrastructure claims must be documented by Glean, not inferred).

### T — Transparency
- Advisory / incident disclosure posture; detailed security measures published; external AI safety framework referenced (NIST AI RMF, ISO 42001, etc.); disclosure to end users that they are interacting with an AI agent, by default or via setting.

---

## SPECIAL CONSIDERATIONS

### 1. Disclosure layer
Triggers 0 / 1 / 2 / 3: None on the public investor list (no Amazon, Google, Microsoft or NVIDIA position or channel relationship found at prompt drafting) — engine re-checks the Series F release and KNOWN_FACTS.md Anthropic Equity-Holder Records and states "None" or the trigger found.

### 2. Product-level matching
The evaluated unit is Glean Agents to match the MIT index entry; platform-level documents (privacy, security, DPA) govern it and are the evidence base. State this scope in the Executive Summary so a reader does not take the score as a rating of Glean Search alone.

### 3. Hands-off deploy
This is the first evaluation deployed without manual intervention. Output must include a complete front matter block using only schema properties (no new keys), `selection_basis: list:mit-2025`, `github: null`, `framework_version: v0.3.2`, `evaluation_number: 70`, `evaluation_type: initial`, `evaluated_at` = completion date, `evaluator_model` recorded, `independence` set, `qa` all `pass`.

---

## KNOWN FACT CORRECTIONS

None applicable.

---

## OUTPUT RULES

1. Full English report in a markdown code block (ENGINE.md Output Format).
2. Japanese summary in a `japanese-summary` code block.
3. Score tag line:
```
   Score: XX/85
   V: XX/20, R: XX/20, D: XX/15, I: XX/10, C: XX/10, T: XX/10
   Dimensions verified: V+R+D+I+C+T = XX
```
4. Tier classification (S / A / B / C / D) and category label.
5. Complete front matter block for `platforms/glean-agents.md` (see Special Considerations 3).

---

## REMINDERS

- Public documentation only (Layer 0). Silence = 0. Marketing claims are not evidence.
- Include positive findings alongside risks. No intent attribution. No comparison to other records without comparative data.

---
# END OF PROMPT

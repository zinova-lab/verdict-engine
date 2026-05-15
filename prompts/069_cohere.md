# VERDICT Evaluation Prompt — #069 Cohere

## PLATFORM UNDER EVALUATION

**Name:** Cohere (product family: Command series foundation models + Embed / Rerank retrieval models + North agentic AI platform)
**Owner:** Cohere Inc. — Canadian federal corporation, principal place of business Toronto, Ontario, Canada (with global offices in San Francisco, New York, London, Paris, and additional locations announced for Montréal and South Korea per Sep 2025 corporate communications). Founded 2019 by Aidan Gomez (CEO), Nick Frosst, and Ivan Zhang, all Google Brain alumni. Reported employee count approximately 500 (Apr 2025) scaling toward 1,000 with 2025 expansion. Independent of Anthropic at every layer (no equity overlap with Anthropic / Anthropic Ventures in any funding round per public investor records). Material NVIDIA cap-table presence and NVIDIA commercial partnership disclosed in Special Considerations sections 1 and 2 (VERDICT framework v1.1 Triggers 2 and 3, both firing). Cumulative funding approximately USD 970M-1.04B across 5+ rounds (Series A $40M Sep 2021, Series B $125M, Series C $270M led by Inovia Capital Jun 2023 at ~$2.2B valuation, Series D $500M Jul 2024 at $5.5B valuation, Series D extension $100M Sep 2025 at $7B valuation, with additional $500M $6.8B round noted in Sep 2025 PSP Investments communication — engine to reconcile cumulative figure against operator's own public statements). Series D and extension investors include NVIDIA (returning investor across multiple rounds), AMD Ventures, Salesforce Ventures, Oracle, Cisco, PSP Investments, Fujitsu, Index Ventures, Inovia Capital, Radical Ventures, Sapphire Ventures, Mirae Asset, Schroders Capital, Thomvest Ventures, DTCP, SentinelOne, Export Development Canada, BDC (Business Development Bank of Canada), Nexxus Capital Management, Healthcare of Ontario Pension Plan (HOOPP). Cohere announced leadership additions in 2025: Joelle Pineau (former Head of Meta Fundamental AI Research) as Chief AI Officer; François Chadwick (former Uber executive) as CFO. Founders retain majority of board seats per public reporting.
**Category:** Foundation Model API · Enterprise AI Platform · Agentic AI · Retrieval and Embedding Infrastructure · Cloud Service (with cloud-agnostic and on-premises deployment options)
**Primary product surfaces:**
- Command series — Cohere's flagship generative foundation models (Command R+, Command A, Command A Vision); proprietary closed-source weights with selected open-weight releases under non-commercial / research licenses (engine to verify license terms per release)
- Embed series — retrieval embedding models (Embed 4 most recent)
- Rerank series — retrieval reranking models (Rerank 3.5 most recent)
- North — Cohere's agentic AI workspace platform, characterized by operator as "security-first agentic AI platform" combining LLMs, search, and AI agents for enterprise workflows
- Cohere API platform — at api.cohere.ai (engine to verify canonical URL)
- Cloud distribution — Oracle Cloud Infrastructure, Microsoft Azure (Command R+ via Azure AI Foundry catalog), Amazon Web Services (Bedrock catalog), Google Cloud
- NVIDIA distribution — Command-R available on NVIDIA API Catalog (ai.nvidia.com) and as NVIDIA NIM microservice container; see Special Considerations section 2
- SDKs: Python, TypeScript / JavaScript, Go, Java (engine to verify current SDK matrix)
**Product URL:** https://cohere.com
**GitHub:** https://github.com/cohere-ai
**Documentation:** https://docs.cohere.com

---

## EVALUATION SCOPE

Evaluate Cohere (Cohere API platform and North agentic AI workspace as primary commercial surfaces; foundation model open-weight releases referenced where their licensing and provenance are publicly documented) under VERDICT Framework v1.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

The evaluated surface is the Cohere cloud platform tier as it is publicly documented, with cloud-agnostic deployment options (OCI, Azure, AWS, Google Cloud, on-premises, sovereign AI deployments) noted where they appear in public materials. Foundation model output behavior (alignment, hallucination rates, safety test results for specific Command model variants) is Layer 1+ behavioral evaluation scope and is not assessed under this Layer 0 public-documentation review.

This is the third VERDICT evaluation in the Foundation Model + Agent Platform category (following #061 Mistral La Plateforme and indirectly related to #064 Guardrails AI's safety-layer category). Engine should evaluate per the dimensional rubric independently rather than against absent or relative category benchmarks.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://cohere.com
- About / company: https://cohere.com/about
- Blog: https://cohere.com/blog
- Documentation: https://docs.cohere.com
- API reference: https://docs.cohere.com/reference
- North agentic AI platform: https://cohere.com/north (engine to verify canonical URL)
- Trust Center / Security page: engine to verify at typical patterns (trust.cohere.com, cohere.com/security)
- Privacy Policy: https://cohere.com/privacy (engine to verify canonical URL)
- Terms of Service: https://cohere.com/terms-of-use (engine to verify canonical URL)
- Data Processing Addendum (DPA): engine to locate via cohere.com legal pages
- Responsible AI / governance disclosures: engine to verify
- Series D press release (2024-07): https://cohere.com/blog (engine to locate dated entry)
- Series D extension press release (2025-09): https://cohere.com/blog (engine to locate dated entry)
- PSP Investments announcement (2025): https://www.investpsp.com/en/news/

### Package distribution
- Python SDK PyPI: https://pypi.org/project/cohere/
- TypeScript / JavaScript SDK npm: https://www.npmjs.com/package/cohere-ai
- Cohere GitHub organization: https://github.com/cohere-ai

### Security and vulnerability disclosure
- GitHub Security Advisories: https://github.com/cohere-ai (organization-wide)
- CVE database (NVD) search terms: "Cohere", "cohere-ai", "Cohere AI"
- OSV database: https://osv.dev/list?q=cohere (PyPI and npm ecosystems)
- GHSA index: https://github.com/advisories?query=cohere
- CISA KEV: not expected at evaluation date but engine to verify
- VDP / Security disclosure channel: engine to verify on trust center / security page

### Community signals
- GitHub stars, forks, contributor counts: https://github.com/cohere-ai
- PyPI download statistics: https://pypistats.org/packages/cohere
- Annualized revenue claims: ~$35M ARR (Mar 2024 per BetaKit), ~$100M ARR (May 2025 per Reuters), ~$150M ARR (Oct 2025), ~$200M ARR projected end of 2025 (operator-stated)
- Named enterprise and government partners per Sep 2025 PSP Investments announcement: Oracle, Dell, Royal Bank of Canada (RBC), Bell Canada (BCE), Fujitsu, LG CNS, SAP, Ensemble Health Partners
- Sovereign AI positioning: operator characterizes the platform as cloud-agnostic with sovereign deployment options serving "governments around the world"

### Behavioral model

Cohere operates as an enterprise-focused foundation model and agent platform. The deploying organization's applications invoke Cohere models through:

- **Cohere API** (api.cohere.ai) — direct cloud API for Command, Embed, and Rerank model invocation
- **Cloud marketplace deployments** — Command models accessible via Oracle Cloud Infrastructure (Cohere is a strategic OCI partner per Sep 2025 communications), Microsoft Azure AI Foundry, AWS Bedrock, Google Cloud Vertex AI; deployment surface determines data residency and contracting tier
- **NVIDIA distribution channel** — Command-R available on NVIDIA API Catalog and as NVIDIA NIM microservice container; see Special Considerations section 2 for the non-arms-length channel relationship analysis
- **On-premises and sovereign deployment** — operator offers self-hosted and sovereign AI deployment for governments and regulated enterprises
- **North agentic AI workspace** — Cohere-hosted workspace combining LLMs, search, and AI agents; security-first positioning per operator

The platform is cloud-agnostic by design; customer choice of deployment surface (Cohere-hosted API vs. cloud marketplace vs. self-hosted) determines the legal and operational trust boundary. The Cohere-hosted API tier processes customer prompts and completions in Cohere's managed infrastructure. The cloud marketplace and self-hosted tiers shift the operational boundary to the deploying organization's chosen cloud or on-premises environment, with Cohere's role becoming model and software provider rather than data processor.

Customer prompt and completion data handling, training opt-out, and retention policies must be assessed against Cohere's documented commercial terms; the cloud-agnostic positioning means data flow depends substantially on deployment tier.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Operator legal entity (Cohere Inc., Canadian federal corporation): verify consistency of corporate identity, business address, jurisdiction details (federal incorporation, Ontario operational base), and contact paths across the homepage, About page, Privacy Policy, Terms of Service, and any trust center documentation.
- Founder identity and current leadership: Aidan Gomez (CEO), Nick Frosst, Ivan Zhang as co-founders; Joelle Pineau (CAO, 2025 addition), François Chadwick (CFO, 2025 addition). Engine to verify against operator's About page and confirm founders retain board majority claim.
- Foundation model boundary disclosure: assess whether the boundary between open-weight model releases (e.g., Command R+ initial release noted as having open-weight version under non-commercial / research-restricted license) and proprietary cloud-only models is clearly documented.
- Cloud partner deployment claims: Oracle, Azure, AWS, Google Cloud partner deployments are claimed; engine to verify each via the partner marketplace listings as primary source.
- Trust Center compliance certifications: assess whether the Trust Center discloses SOC 2 Type II auditor name, ISO 27001 scope and certifying body, HIPAA BAA availability, and validity dates. Cohere's enterprise positioning implies compliance posture but Layer 0 verifies what is publicly documented.
- Subprocessor list: assess whether subprocessor list with last-updated date is publicly accessible.
- Funding figures: third-party data sources show variation in cumulative funding ($935M Crunchbase, $970M operator-derived, ~$1B with 2025 extensions); engine to record operator's own statement at evaluation date as authoritative.
- Revenue claims: operator-stated ARR figures ($150M Oct 2025, $200M projected) are operator self-positioning; engine to flag as operator-claimed.
- Headquarters location: Toronto consistent across primary sources, but global office expansion (Paris, Montréal, South Korea announced) may affect corporate footer consistency at evaluation date.

### R — Resilience

- CVEs assigned to `cohere` (PyPI) or `cohere-ai` (npm), or to Cohere platform surfaces (trailing 12 months): enumerate via NVD search restricted to relevant product strings, GitHub Security Advisories at github.com/cohere-ai, and PyPI / npm OSV ecosystems.
- CISA KEV: any Cohere entry at evaluation date.
- Status page for Cohere API: engine to verify presence (typical patterns: status.cohere.com), incident history retention, SLA commitments.
- Release cadence: GitHub Releases for SDK + Cohere API changelog + model release announcements (engine to locate). Assess release frequency, semantic versioning discipline, and breaking-change notification.
- Supply chain integrity: signed releases on GitHub, PyPI and npm package provenance for SDK packages, and project's response to recent supply chain attack patterns (Shai-Hulud, Vercel-Context disclosures referenced in prior VERDICT evaluations); engine to assess affirmative unaffected disclosures.
- Dependency hygiene: assess Cohere SDK dependency pinning and response to upstream CVEs.
- Penetration testing: engine to verify publication of pentest summaries on trust center if any.
- Distribution surface resilience: when Cohere is consumed via NVIDIA NIM, AWS Bedrock, Azure AI Foundry, OCI, the operational resilience boundary partially shifts to the distribution partner; assess how Cohere documents its responsibility partition.

### D — Data Conduct

- Customer-as-controller framing: assess whether the Privacy Policy and DPA frame Cohere as data processor when the deploying customer is data controller for prompts and completions processed by Cohere-hosted API.
- AI training opt-out: assess whether documentation makes explicit that customer prompts and completions are not used for training Cohere's foundation models. Enterprise foundation model platforms typically default to no-training; engine to verify and assess opt-out granularity.
- Data retention: assess documented retention windows for prompts, completions, training fine-tuning data, and deleted customer data. Foundation model providers typically retain inputs for abuse monitoring; engine to verify retention period and zero-data-retention option availability.
- Data residency: assess documented region options for Cohere-hosted API (US, EU, Canada given the Canadian operator base, others) and customer controls for region selection. Sovereign AI positioning implies stronger residency controls for government tier; assess what is publicly documented versus contract-gated.
- Encryption: confirm at-rest and in-transit encryption specifications, including customer-managed key (CMEK) availability if any.
- Subprocessor disclosure: assess whether Cohere publishes a subprocessor list with update cadence and customer notification mechanism. Critical given the cloud-agnostic distribution model: Oracle, Microsoft, AWS, Google, and NVIDIA are infrastructure / distribution partners with potentially differentiated data handling roles.
- Cross-border transfer mechanism: Canadian operator with US, EU, and global customers; assess GDPR Article 46 transfer mechanism documentation (SCCs, adequacy decisions) and Canada-specific privacy law alignment (PIPEDA).
- Government customer data handling: Sovereign AI deployments imply differentiated data handling for government customers; engine to assess whether sovereign deployment data flows are documented or contract-gated.
- Fine-tuning customer data: customer-supplied fine-tuning training data retention and deletion policies.

### I — Identity & Control

- Authentication mechanisms for Cohere platform: API key, OAuth, SAML SSO, SCIM provisioning. Assess what is documented for self-serve versus enterprise tier.
- RBAC and workspace structure: assess role definitions, permission granularity, and team / project scoping.
- API key management: scoping, rotation, revocation, per-environment scoping.
- Audit logging: scope of audit events captured for operator and customer activity, retention windows, export mechanisms.
- Multi-tenancy isolation: Cohere-hosted API is multi-tenant; assess what controls prevent cross-tenant prompt or completion exposure.
- 2FA / MFA enforcement options.
- North platform identity model: Cohere North is an end-user-facing workspace; assess identity model for end-user accounts versus customer organization administration.
- Sovereign deployment identity tier: government and sovereign deployments may use different identity infrastructure; assess what is publicly documented.

### C — Containment

- Cohere API egress and network controls: assess whether outbound network controls (IP allowlisting, private endpoints, VPC peering) are documented for enterprise tier.
- Cloud marketplace tenant isolation: when Cohere is consumed via OCI, Azure, AWS, or Google Cloud, isolation is governed by the cloud provider's tenant isolation; assess how Cohere documents the partitioning of responsibility.
- NVIDIA NIM deployment containment: when Command-R is deployed via NVIDIA NIM microservice container, the deploying organization controls the container environment; assess Cohere's documentation of the trust boundary in that deployment mode.
- Sovereign / on-premises deployment: assess what containment controls are publicly documented for sovereign deployments (air-gap support, customer-controlled key management, customer-controlled network egress).
- North platform agent execution containment: Cohere North is an agentic workspace; assess what controls govern agent action execution, tool use, and external service invocation.
- Connector / tool use boundary: assess what tools and connectors North agents can invoke, and whether customer-administered restrictions are documented.

### T — Transparency

- License clarity for open-weight Command releases: Command R+ and selected variants have been released with weights under non-commercial / research-restricted licenses; engine to verify the exact license terms (typically CC-BY-NC-4.0 or Cohere's own non-commercial license) per release, and confirm consistency between operator announcements and the actual license files on Hugging Face or GitHub mirrors.
- Documentation completeness: assess whether technical documentation, API reference, security disclosures, and compliance artifacts are accessible without gated authentication.
- Security disclosure cadence: assess publication of security advisories on GitHub and on the trust center, including SLA tiers and bug bounty program scope.
- Status page transparency: status page presence and public incident postmortems.
- Subprocessor list: presence, last-updated indicator, notification mechanism for additions. Critical given the multi-cloud distribution model.
- Responsible AI governance: assess publication of responsible AI framework, model card documentation per Command release, and any commitments to NIST AI RMF, ISO/IEC 42001, EU AI Act mappings.
- Sovereign AI commitment transparency: operator positioning as sovereign AI provider implies governance commitments; engine to assess what is publicly documented.
- Open-weight release transparency: License terms (non-commercial for Command R+ open weights per public reporting) and weight publication channels (Hugging Face, GitHub).
- Corporate transparency: Cohere is privately held (private company per Bloomberg, EquityZen, public reporting); SEC filings are not available. Public investor records and operator-issued press releases are the primary disclosure surface.

---

## SPECIAL CONSIDERATIONS

### 1. NVIDIA cap-table compound investor structure (framework v1.1 Trigger 2)

Cohere's strategic investor cohort includes NVIDIA, a participating investor across multiple funding rounds including the Series D ($500M, July 2024 at $5.5B valuation) and Series D extension ($100M, September 2025 at $7B valuation). As of November 2025, NVIDIA also holds a strategic equity commitment in Anthropic (up to USD 10 billion, subject to closing conditions per NVIDIA SEC Form 10-Q FY2026 Q3). This is a compound investor structure under VERDICT framework v1.1: NVIDIA holds equity positions in both the evaluator (Anthropic, operator of VERDICT) and the evaluated platform (Cohere). VERDICT scoring is based exclusively on public data sources per the v0.3.1 framework, and no vendor revenue or paid certification influences the rating.

### 2. NVIDIA non-arms-length channel relationship (framework v1.1 Trigger 3, additive)

Cohere also has a publicly-disclosed commercial channel relationship with NVIDIA beyond standard supplier-customer relations, including: Cohere's Command-R model published as a NVIDIA NIM microservice with co-engineering optimization for NVIDIA-accelerated infrastructure; Command-R availability on the NVIDIA API Catalog (ai.nvidia.com); and a joint GTC 2024 panel featuring Cohere CEO Aidan Gomez alongside NVIDIA CEO Jensen Huang. The operator publicly characterizes the partnership in its own communications as: "Cohere is working closely with NVIDIA to optimize Command-R to run on NVIDIA NIM microservices" and "we're proud to deepen our collaboration with NVIDIA." This channel relationship is additive to the cap-table relationship described above and constitutes a non-arms-length channel under VERDICT framework v1.1 Trigger 3.

### 3. Cohere North agentic AI platform (platform-material item)

In 2024-2025, Cohere launched North, characterized by the operator as a "security-first agentic AI platform" combining LLMs, search, and AI agents into an enterprise workspace. North is a distinct product surface from the Cohere API platform and from the Command / Embed / Rerank model APIs, with its own evaluation-relevant characteristics including end-user identity model, tool / connector boundary, agent action execution containment, and security positioning. Engine should:
- Verify the current product status of North (general availability vs. preview vs. limited release) at evaluation date.
- Assess publicly documented containment, identity, and audit characteristics specific to North's agentic workspace surface.
- Disclose North's positioning as a distinct evaluation surface within the Cohere product family; do not conflate North's characteristics with the foundation model API tier or vice versa.

---

## KNOWN FACT CORRECTIONS

None applicable.

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
- Include positive findings alongside risks. The cloud-agnostic deployment model, the sovereign AI positioning, the Canadian federal incorporation and global enterprise customer base (Oracle, Dell, RBC, BCE, Fujitsu, LG CNS, SAP, Ensemble Health Partners per operator), the publicly-disclosed Series D investor cohort, and any verified compliance certifications should be reflected where confirmed, alongside any documentation gaps, license boundary ambiguity for open-weight releases (non-commercial restrictions), unverified self-claims (ARR figures, sovereign AI commitment scope), and the framework v1.1 disclosures in Special Considerations.
- No intent attribution to Cohere, to investors, to LLM providers, to NVIDIA, or to Microsoft / Oracle / AWS / Google Cloud distribution partners.
- Structural context (NVIDIA Trigger 2 + Trigger 3 compound disclosure, cloud-agnostic by design, North agentic platform as distinct product surface, sovereign AI positioning, Canadian federal incorporation with global expansion) noted neutrally as fact, not as excuse, endorsement, or commentary.
- Strategy Brief #3 §3 B3 cross-reference structure: Trigger 2 paragraph (Section 1) carries the Anthropic equity disclosure and scoring disclaimer; Trigger 3 paragraph (Section 2) intentionally does not re-state these elements per the additive template.
- Cloud marketplace deployments (Azure AI Foundry, AWS Bedrock, OCI, Google Cloud Vertex AI) are industry-standard distribution channels and do not themselves constitute framework v1.1 Trigger 3 firings; only the NVIDIA NIM co-engineered integration with concurrent NVIDIA equity participation satisfies A3 criteria per Brief #3 §1.
- No political framing of NVIDIA, Anthropic, Canadian / US AI policy, or any party.
- Foundation model output behavior (alignment, hallucination rates, safety test results for Command model variants) is out of scope for this Layer 0 review; defer to the Future Evaluation Plan with explicit Layer 1+ language.

---
# END OF PROMPT

# VERDICT Evaluation Prompt — #061 Mistral La Plateforme

---

## PLATFORM UNDER EVALUATION

**Name:** Mistral La Plateforme (including the Agents API)
**Owner:** Mistral AI SAS — French société par actions simplifiée incorporated in Paris under registration number 952 418 325, registered office at 15 rue des Halles, 75001 Paris, France. Founded April 2023 by Arthur Mensch (CEO), Timothée Lacroix (CTO), and Guillaume Lample. Independent of Anthropic at every layer (no equity overlap with Anthropic / Anthropic Ventures in any funding round to date). Major investors include Lightspeed Venture Partners (Seed lead), Andreessen Horowitz (Series A lead), Microsoft (~$16M strategic), Nvidia, Salesforce, IBM, Samsung, Bpifrance, Bertelsmann, DST Global, ASML (~11% stake, largest single shareholder per Series C, Sep 2025), and a $830M conventional debt round (Mar 2026) led by Credit Agricole CIB, HSBC, and MUFG. Cumulative funding approximately $2.7B–$3.05B across 8–9 rounds (source-dependent).
**Category:** AI Agent Platform · Foundation Model API · Stateful Agents Runtime · Cloud Service (with on-premises and dedicated-environment enterprise tiers)
**Primary product surfaces:**
- La Plateforme (https://console.mistral.ai/) — central developer console for API keys, billing, workspaces, usage tracking
- Mistral AI Studio — production lifecycle environment (experiments, judges, datasets, observability, fine-tuning)
- Chat Completion API (https://api.mistral.ai/v1/chat/completions) — model invocation
- Agents API (GA May 27, 2025) — stateful conversation, server-managed thread context, built-in connectors (code execution, web search / web search premium, image generation, document library), MCP server support, agent handoffs
- Fine-Tuning API
- SDKs: Python (`mistralai`), TypeScript / JavaScript (`@mistralai/mistralai`)
- Self-hosted / on-premises / dedicated-environment deployment options (enterprise tier)
**Product URL:** https://mistral.ai/
**GitHub:** https://github.com/mistralai
**Documentation:** https://docs.mistral.ai/

---

## EVALUATION SCOPE

Evaluate Mistral La Plateforme (API platform, including the Agents API) under VERDICT Framework v0.3.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

The evaluated surface is the cloud API platform tier as it is publicly documented, with self-hosted / on-premises / dedicated-environment options noted where they appear in public materials. Foundation model output behavior (e.g., model alignment, safety test results for specific model families such as Pixtral) is Layer 1+ behavioral evaluation scope and is not assessed under this Layer 0 review.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://mistral.ai/
- News and announcements: https://mistral.ai/news
- Product page (La Plateforme): https://mistral.ai/products/la-plateforme
- Documentation: https://docs.mistral.ai/
- API specification: https://docs.mistral.ai/api
- Console: https://console.mistral.ai/
- Trust Center: https://trust.mistral.ai/
- Trust Center Controls: https://trust.mistral.ai/controls
- Trust Center Resources: https://trust.mistral.ai/resources
- Trust Center Subprocessors tab: https://trust.mistral.ai/ (Subprocessors section; engine to fetch the canonical URL)
- Privacy Policy: https://legal.mistral.ai/terms/privacy-policy
- Data Processing Addendum: https://legal.mistral.ai/terms/data-processing-addendum
- Terms of Service: legal.mistral.ai (engine to locate the canonical Terms URL)
- Help Center root: https://help.mistral.ai/
- Help Center — SOC 2 / ISO 27001: https://help.mistral.ai/en/articles/347638-do-you-have-soc2-or-iso27001-certification
- Help Center — Trust, Security, Compliance collection: https://help.mistral.ai/en/collections/789666-trust-security-compliance
- Help Center — data residency: https://help.mistral.ai/en/articles/347629-where-do-you-store-my-data-or-my-organization-s-data
- Agents API announcement: https://mistral.ai/news/agents-api

### Package distribution
- PyPI (Python SDK): https://pypi.org/project/mistralai/
- npm (TypeScript / JavaScript SDK): https://www.npmjs.com/package/@mistralai/mistralai
- GitHub organization: https://github.com/mistralai

### Security and vulnerability disclosure
- GitHub SECURITY.md: https://github.com/mistralai (engine to locate organization-level or repo-level SECURITY.md if present)
- GitHub Security Advisories: https://github.com/mistralai (engine to enumerate published advisories across repos)
- CVE database (NVD) search terms: "Mistral AI", "mistralai", "Mistral La Plateforme", "Mistral Agents API", "Mistral Studio"
- OSV database: https://osv.dev/ (query ecosystem npm:`@mistralai/mistralai` and PyPI:`mistralai`)
- GHSA: https://github.com/advisories?query=mistral
- CISA KEV: https://www.cisa.gov/known-exploited-vulnerabilities-catalog (query for Mistral-related entries; not expected at evaluation date)
- Responsible disclosure / VDP: engine to locate on Trust Center or via security@mistral.ai contact channel
- Penetration testing: engine to verify whether documented on Trust Center

### Community signals
- GitHub stars, forks, contributor counts across mistralai/mistral-inference, mistralai/client-python, mistralai/client-ts, and other organization repositories
- Release cadence: GitHub Releases + mistral.ai/news
- Operator-claimed model lineup: Mistral Large 3, Magistral Small / Medium, Mistral Medium 3, Mistral Small 3.1, Codestral, Devstral 2 / Devstral Small 2, Ministral 3 (3B / 7B / 14B), Pixtral, Mistral Vibe (CLI for AI-assisted software development)

### Behavioral model

Mistral La Plateforme is a cloud API platform that exposes:

- **Chat Completion API** for stateless single-turn or client-managed multi-turn model invocation
- **Agents API** for stateful, server-managed conversation threads with:
  - **Code Interpreter** — Python execution in a server-side sandbox (operator-managed runtime; isolation technology to be verified by engine against public documentation)
  - **Web Search** (`web_search` and `web_search_premium`) — search-engine-backed retrieval; the premium variant adds AFP and AP news agency content. The Trust Center Subprocessor list is the authoritative reference for the underlying search engine
  - **Image Generation** — Black Forest Lab FLUX1.1 [pro] Ultra integration
  - **Document Library** — hosted retrieval-augmented generation over user-uploaded documents
  - **MCP server support** — calls out to user-configured Model Context Protocol servers
  - **Agent handoffs** — multi-agent task routing
- **Fine-Tuning API** — customer-supplied training data
- **Connectors** — fetched on-demand and not stored permanently per Help Center privacy documentation
- **SDKs** for Python and TypeScript / JavaScript

The platform does not execute customer code outside the documented Code Interpreter sandbox. Customer prompts and outputs are retained server-side for thirty rolling days for the general API (zero data retention available on request, subject to approval); for the Agents API, retention is until account termination. Fine-tuning data is retained until customer deletion or account termination.

Self-hosted, on-premises, and dedicated-environment deployment options are documented at the enterprise tier; full architecture details for these tiers may be gated behind enterprise contact rather than public documentation.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Is the operator legal entity (Mistral AI SAS, SIRET 952 418 325, 15 rue des Halles 75001 Paris) named consistently across the Privacy Policy, Data Processing Addendum, Terms of Service, Trust Center, Help Center, and corporate footer?
- Is the boundary between open-weight model releases (e.g., Mistral 7B, Mixtral under Apache 2.0) and proprietary models served only through La Plateforme clearly documented?
- Does the Trust Center disclose the SOC 2 Type II auditor name, ISO 27001 / 27701 certifying body, scope of certification, and validity dates? (Note: Help Center confirms compliance with both frameworks; report copies are NDA-gated via the Trust Center.)
- Does the Subprocessors page display a "last updated" date, and what notification mechanism is documented for additions?
- Is the Code Interpreter sandbox isolation technology (e.g., gVisor, microVM, container isolation) documented in public materials, or is it gated to enterprise contact?
- Is the underlying provider for `web_search` and `web_search_premium` named in the Subprocessor list?
- Is the GDPR Article 46 transfer mechanism (Standard Contractual Clauses, adequacy decisions) documented per non-EU subprocessor?

### R — Resilience

- CVE / GHSA / OSV trailing-twelve-months count across `mistralai/*` GitHub repositories, npm:`@mistralai/mistralai`, PyPI:`mistralai`, and any La Plateforme-specific advisories.
- CISA KEV: any Mistral-related entry at evaluation date.
- API platform release cadence and breaking-change notification policy (engine to verify against the Documentation site changelog).
- Status page (e.g., status.mistral.ai) presence, incident history, and SLA commitments.
- Supply-chain integrity: signed releases, package provenance for `mistralai` PyPI and `@mistralai/mistralai` npm.
- Penetration testing cadence — referenced in Trust Center; report or summary public availability to be assessed.

### D — Data Conduct

- AI training opt-out: the Help Center documents "data sent through the API isn't used for model training" and that organization-level admins can disable data sharing for model training. Engine to verify this commitment is also reflected in the Privacy Policy and DPA.
- Retention asymmetry: the general API retains Input/Output for 30 rolling days for abuse monitoring (zero data retention on request); the Agents API retains Input/Output until account termination; Fine-Tuning API retains data until deletion or account termination. Engine to record this asymmetry as documented and assess whether the structural rationale for the longer Agents API retention is publicly explained.
- Connectors: fetched on-demand and "not stored permanently" per Help Center; engine to assess specificity of the not-stored-permanently claim.
- DPA controller / processor structure: Mistral AI SAS as processor when Customer is controller; engine to verify the DPA scope covers La Plateforme + Mistral AI Studio + Agents API explicitly.
- GDPR Article 46 transfer mechanisms for non-EU subprocessors: SCCs documented in DPA Section 8 area; engine to verify.
- Account deletion: documented as permanent and irreversible per Privacy documentation; engine to assess data export capability before deletion.
- Subprocessor objection rights: 10-day customer objection window per DPA — engine to verify in published DPA text.

### I — Identity & Control

- Authentication options: email/password, Google, GitHub social SSO at La Plateforme console (per third-party documentation; engine to verify against the operator's Help Center authentication article).
- SAML SSO and SCIM provisioning: Help Center documents SAML SSO setup as an Admin Panel feature; engine to verify whether SAML / SCIM are gated to enterprise tier.
- RBAC and workspace structure: Admin Panel documents workspaces, role assignment, and usage limits per workspace; engine to record granularity and any tier gating.
- API key management: scoping, rotation, and revocation documentation; transferability (Mistral ToS prohibits buying, selling, or transferring API keys per third-party reporting; engine to verify this clause in the canonical Terms text).
- Audit log availability and retention default; engine to record any tier gating.
- 2FA / MFA enforcement options.

### C — Containment

- Code Interpreter sandbox: isolation technology, default network egress (allow-all vs. deny-by-default), CPU / memory / time limits, file persistence behavior, and ability to opt out at the workspace level.
- Web Search and Web Search Premium: subprocessor identity, query data flow, retention of search queries, opt-out at the workspace level.
- Image Generation (FLUX1.1): subprocessor (Black Forest Labs) data flow, prompt and output retention, opt-out at the workspace level.
- MCP server invocation: customer-configured MCP servers; data flow boundary between Mistral-operated runtime and customer-operated MCP server; outbound network controls.
- Document Library: where uploaded documents are stored, encryption at rest, isolation per workspace.
- Tenant isolation between La Plateforme customers (multi-tenant cloud); SOC 2 Type II + ISO 27001 attested controls referenced; engine to record what is publicly disclosed beyond attestation references.
- Self-hosted / on-premises / dedicated-environment topology: ingress / egress documentation, customer-controlled key management, and air-gapped operation availability (engine to verify against public materials).

### T — Transparency

- Trust Center page count and content depth (Trust Center confirmed at trust.mistral.ai with Controls, Resources, Subprocessors sections).
- DPA: publicly accessible at legal.mistral.ai/terms/data-processing-addendum (no NDA gate); engine to verify completeness against an enterprise-grade DPA reference structure.
- Subprocessor list: publicly listed at Trust Center; engine to assess completeness, last-updated indication, and email-notification subscription mechanism documented in the DPA.
- Vulnerability / responsible disclosure policy: engine to locate, assess SLA tiers and scope.
- Status page: presence, history retention, public incident postmortems.
- AI safety / governance framework references: NIST AI RMF, ISO/IEC 42001, EU AI Act mapping; engine to record presence or absence on Trust Center and Help Center.
- Corporate change disclosure: whether the Koyeb acquisition (2026-02-17, per PitchBook) is reflected on the Trust Center (Subprocessor list, Resources), Privacy Policy, DPA, and corporate footer at evaluation date.
- Open-weight model release transparency: License terms (Apache 2.0 for several model families) and weight publication channels (Hugging Face, GitHub).

---

## SPECIAL CONSIDERATIONS

### 1. Foundation model + agent platform vertical integration

Mistral AI SAS develops and operates its own foundation models (Mistral Large 3, Magistral, Codestral, Pixtral, Ministral 3, among others) and exposes them through the same API platform (La Plateforme) that hosts the Agents API. This is a different architectural pattern from model-agnostic agent platforms (e.g., LangGraph, AutoGen, Semantic Kernel) where the agent runtime is decoupled from any specific model provider. The same operator controls both model output behavior and agent runtime; institutional separation between the two layers does not exist by design. Engine should disclose this architecture neutrally as a structural fact bearing on Verifiability and Containment scoring — it is not a containment failure within the framework. Model output safety findings, including external research on specific Mistral model families, are Layer 1+ behavioral evaluation scope and are not assessed under this Layer 0 public-documentation review; references to such findings, if any are encountered, should be deferred to the Future Evaluation Plan.

### 2. Operator self-positioning and data residency claims to be verified against the published DPA and Subprocessor list

Operator's public-facing materials describe Mistral AI as a European-headquartered AI provider, with Mistral Compute (announced 2025) hosted in France. The Privacy Policy and DPA identify Mistral AI SAS (Paris, SIRET 952 418 325) as the controller / processor entity for La Plateforme and Mistral AI Studio. The DPA documents subprocessor approval mechanics (10-day customer objection window) and references GDPR Article 46 Standard Contractual Clauses for transfers to non-adequate third countries. The Help Center also references the ability for enterprise organizations to deactivate features that involve data transfers outside the EU at the organization level. Engine should:
- Verify which features are EU-only versus globally distributed against the Trust Center Subprocessor list at evaluation date.
- Verify documentation completeness of GDPR Article 46 transfer mechanisms per non-EU subprocessor.
- Verify whether the enterprise-tier organization-level data-locality control is documented in the public DPA or Subprocessor list with sufficient specificity, or whether it is contractually negotiated at enterprise scale only.
- Record operator's self-positioning as factual statements without endorsement or rebuttal; report neutrally on the alignment between self-positioning and the documented legal-structural artifacts.

### 3. Recent acquisition of Koyeb (2026-02-17, per PitchBook M&A record)

Koyeb is a serverless GPU compute infrastructure platform. The acquisition extends Mistral's vertical integration alongside the previously announced Mistral Compute infrastructure layer. As of evaluation date, the public disclosure status of the acquisition's effect on the legal-entity stack and customer data flows is unverified. Engine should:
- Verify whether Koyeb is named in the current Subprocessors list at https://trust.mistral.ai/.
- Verify whether the acquisition is reflected in the Privacy Policy, DPA controller / processor designations, and corporate footer at evaluation date.
- Verify whether new data flows from La Plateforme / Agents API to Koyeb-operated infrastructure are documented in the Subprocessor list or DPA.
- Disclose the acquisition fact neutrally; do not infer architectural integration that is not documented in public sources.

---

## KNOWN FACT CORRECTIONS

None applicable. No Mistral-specific entry exists in `KNOWN_FACTS.md` as of evaluation date.

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
- Include positive findings alongside risks. Mistral's documented compliance posture (SOC 2 Type II, ISO 27001 / 27701, GDPR with publicly accessible DPA, Trust Center with Subprocessor list and 10-day objection rights, AI training opt-out, zero data retention on request) should be reflected where verified, alongside any documentation gaps, retention asymmetries, or unverified items surfaced during the evaluation.
- No intent attribution to operator, parent investors, or government customers.
- Structural or maintainer context (vertical integration of foundation model and agent platform; operator self-positioning as European AI provider; Koyeb acquisition) noted neutrally as fact, not as excuse, endorsement, or commentary.
- Foundation model output behavior (alignment, multimodal safety, etc.) is out of scope for this Layer 0 review; defer to the Future Evaluation Plan with explicit Layer 1+ language.
- No political framing of any operator characteristic; restrict to neutral legal and structural language.

---
# END OF PROMPT

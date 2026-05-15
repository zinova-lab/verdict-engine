# VERDICT Evaluation Prompt — #068 Arize AI

## PLATFORM UNDER EVALUATION

**Name:** Arize AI (product family: Arize AX commercial platform + Arize Phoenix open-source)
**Owner:** Arize AI, Inc. — Delaware C-corporation, principal place of business Berkeley, California, United States (per operator's official press releases and arize.com corporate communications; third-party data services show minor variation: Tracxn lists Berkeley, PitchBook lists Mill Valley, CB Insights lists Berkeley). Founded January 2020 by Jason Lopatecki (CEO) and Aparna Dhinakaran (CPO), both formerly of TubeMogul (acquired by Adobe 2016). Reported employee count approximately 172 (Tracxn, March 2026). Independent of Anthropic at every layer (no equity overlap with Anthropic / Anthropic Ventures in any funding round per public investor records). Material Microsoft cap-table presence and Microsoft commercial partnership disclosed in Special Considerations sections 1 and 2 (VERDICT framework v1.1 Triggers 2 and 3, both firing). Cumulative funding approximately USD 131M across 4 rounds (Tracxn) / USD 130M (PitchBook); latest Series C USD 70M announced 2025-02-20 led by Adams Street Partners. Disclosed Series C participants include M12 (Microsoft's corporate venture fund), SineWave Ventures, OMERS Ventures, Datadog, PagerDuty, Industry Ventures, Archerman Capital; returning investors Foundation Capital, Battery Ventures, TCV, Swift Ventures. Total investor count 15-16 across rounds (Tracxn / PitchBook). Board members include Dharmesh Thakker (Battery Ventures), Ashu Garg (Foundation Capital), Morgan Gerlak; co-founders Lopatecki and Dhinakaran. Arize acquired Velvet (Business/Productivity Software) on 2025-03-13 per PitchBook M&A record.
**Category:** LLM Observability · AI Evaluation · Model Monitoring · Cloud Service (with open-source Arize Phoenix library tier)
**Primary product surfaces:**
- Arize AX — commercial enterprise platform for AI observability, evaluation, monitoring, and troubleshooting for LLMs, AI agents, and traditional ML models; hosted at app.arize.com
- Arize Phoenix — open-source observability and evaluation library (operator-claimed two million monthly PyPI downloads as of 2025-02 PR); positioned by operator as "the most widely adopted AI observability library for development"
- Voice agent evaluation — first-to-market audio evaluation capability launched 2025 per operator press release
- Azure AI Studio integration — deep product integration with Microsoft Azure AI Studio (see Special Considerations section 2)
- Azure AI Foundry integration — portal, SDK, and CLI integration (see Special Considerations section 2)
- LlamaIndex joint platform — joint LLM application evaluation platform announced 2024-07
- OpenEvals and AgentEvals — open-source research initiatives referenced in 2025 Series C announcement
- Python SDK: `arize`, `arize-phoenix` (PyPI)
**Product URL:** https://arize.com
**GitHub:** https://github.com/Arize-ai
**Documentation:** https://docs.arize.com (engine to verify canonical URL)

---

## EVALUATION SCOPE

Evaluate Arize AI (Arize AX commercial platform primary scope; Arize Phoenix open-source library referenced where its operational characteristics are publicly documented) under VERDICT Framework v1.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

The evaluated surface is Arize AX as the operator's commercial product. Arize Phoenix as a standalone library is evaluated to the extent its design choices (license, repository governance, security advisories) bear on the operator's overall transparency and supply chain posture. Behavioral evaluation of observability accuracy, evaluation methodology effectiveness, and the operator's claimed LoCoMo or audio evaluation benchmark performance is Layer 1+ scope and not assessed under this Layer 0 review.

This is the third VERDICT evaluation in the LLM Observability category (following #060 Langfuse and #062 LangSmith). Engine should evaluate per the dimensional rubric independently rather than against absent or relative category benchmarks. Category-level positioning is a publishing-stage concern, not an evaluation-stage one.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://arize.com
- About / company: https://arize.com/about-us/
- Blog: https://arize.com/blog/
- Series C announcement (2025-02-20): https://arize.com/blog/arize-ai-raises-70m-series-c-to-build-the-gold-standard-for-ai-evaluation-observability/
- PR Newswire (2025-02-20): https://www.prnewswire.com/news-releases/arize-ai-secures-70m-series-c-to-fix-ais-biggest-problem-making-llms-and-ai-agents-work-in-the-real-world-302381601.html
- Documentation: engine to verify at docs.arize.com (canonical URL)
- Privacy Policy: engine to locate via arize.com footer
- Terms of Service: engine to locate via arize.com footer
- Data Processing Addendum (DPA): engine to locate via arize.com footer or trust portal
- Trust Center / Security page: engine to verify at typical patterns (trust.arize.com, arize.com/security)

### Package distribution
- Arize Python SDK PyPI: https://pypi.org/project/arize/
- Arize Phoenix PyPI: https://pypi.org/project/arize-phoenix/
- Arize Phoenix GitHub: https://github.com/Arize-ai/phoenix
- Arize AI GitHub organization: https://github.com/Arize-ai

### Security and vulnerability disclosure
- GitHub Security Advisories (Arize-ai org): https://github.com/Arize-ai/phoenix/security/advisories (and organization-wide)
- CVE database (NVD) search terms: "Arize AI", "arize-phoenix", "Arize Phoenix"
- OSV database: https://osv.dev/list?q=arize (PyPI ecosystem); https://osv.dev/list?q=arize-phoenix
- GHSA index: https://github.com/advisories?query=arize
- VDP / Security disclosure channel: engine to verify on trust center / security page if published

### Community signals
- GitHub stars, forks, contributor counts: https://github.com/Arize-ai/phoenix
- PyPI download statistics for `arize-phoenix`: https://pypistats.org/packages/arize-phoenix (operator-claimed two million monthly downloads as of 2025-02)
- Release cadence: GitHub Releases for Arize Phoenix + Arize AX changelog (engine to locate)
- Named enterprise customers per operator (Series C announcement 2025-02-20): Booking.com, Condé Nast, Duolingo, Hyatt, PepsiCo, Priceline, TripAdvisor, Uber, Wayfair, Klaviyo
- Customer testimonial verification per #064 Guardrails AI precedent

### Behavioral model

Arize AI operates as a cloud-hosted observability and evaluation platform for AI systems. The deploying organization's applications instrument their LLM, agent, or traditional ML model invocations to send trace and evaluation data to Arize's platform. Arize provides:

- **Tracing** — distributed tracing for LLM and agent applications, capturing prompt / response / intermediate state across multi-step pipelines
- **Evaluation** — automated evaluation including a "council of judges" approach (multiple LLM-based evaluators with human-in-the-loop) for accuracy, hallucination, relevance, and safety
- **Monitoring** — drift detection, latency monitoring, cost tracking, error rate alerting
- **Datasets and prompt management** — versioned datasets and prompt regression testing
- **OpenInference / OpenTelemetry semantic conventions** — instrumentation library standards
- **Audio evaluation** — first-to-market voice agent evaluation per operator self-positioning

The platform is LLM-provider-agnostic by design; the deploying developer configures which LLM providers and evaluation backends are integrated. Trace and evaluation data is sent from the deploying application to Arize's managed infrastructure (Arize AX) or to a self-hosted Arize Phoenix instance.

For Arize Phoenix (open-source), the deploying organization controls the entire trace storage and evaluation execution environment; no data leaves the deploying organization's infrastructure.

For Arize AX (managed), trace and evaluation data is processed and stored in Arize's managed infrastructure. The exact storage architecture, data residency options, customer isolation model, and encryption posture must be assessed against what is publicly documented.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Operator legal entity (Arize AI, Inc., Delaware C-corp): verify consistency of corporate identity, business address, and contact paths across the homepage, About page, Privacy Policy, Terms of Service, and any trust center documentation.
- Headquarters location: third-party data services show variation (Berkeley vs. Mill Valley); engine to verify the authoritative HQ from operator's own pages and press releases. The official Series C PR (PR Newswire 2025-02-20) is datelined Berkeley, CA.
- Founder identity and current leadership: Jason Lopatecki (CEO) and Aparna Dhinakaran (CPO) consistently named across operator pages and press releases.
- Arize Phoenix license claim: engine to verify against the LICENSE file in github.com/Arize-ai/phoenix; confirm the scope of OSS coverage and that the OSS repository is the production source for the Phoenix library tier.
- Named customer claims (Booking.com, Condé Nast, Duolingo, Hyatt, PepsiCo, Priceline, TripAdvisor, Uber, Wayfair, Klaviyo): engine to verify against publicly available external sources (customer engineering blog, conference talk, public case study, named-customer reference in operator-independent press coverage) per #064 Guardrails AI customer testimonial verification discipline. Operator-claimed customer references that cannot be independently verified should be noted as operator-claimed but unverified.
- Two million monthly downloads claim for Arize Phoenix: engine to verify against PyPI download statistics at evaluation date.
- "First-to-market audio evaluation" claim: engine to assess substantiation versus operator self-positioning.
- Velvet acquisition (2025-03-13): engine to verify operator-side disclosure of the acquisition in Privacy Policy, Trust Center, or corporate footer at evaluation date.

### R — Resilience

- CVEs assigned to `arize`, `arize-phoenix`, or Arize platform surfaces (trailing 12 months): enumerate via NVD search, GitHub Security Advisories at Arize-ai/phoenix, and PyPI OSV ecosystem.
- CISA KEV: any Arize entry at evaluation date.
- Status page for Arize AX: engine to verify presence (typical patterns: status.arize.com), incident history retention, SLA commitments.
- Release cadence: GitHub Releases for Arize Phoenix + Arize AX changelog. Assess release frequency and semantic versioning discipline.
- Supply chain integrity: signed releases on GitHub, PyPI package provenance for `arize` and `arize-phoenix`, and project's response to recent supply chain attack patterns (Shai-Hulud, Vercel-Context disclosures referenced in prior VERDICT evaluations); engine to assess affirmative unaffected disclosures.
- Dependency hygiene: assess Arize Phoenix dependency pinning and response to upstream CVEs.
- Penetration testing: engine to verify publication of pentest summaries on trust center if any.
- Velvet acquisition integration risks: post-acquisition feature merging may introduce new attack surfaces; assess whether documentation distinguishes pre-acquisition and post-acquisition feature lineage.

### D — Data Conduct

- Customer-as-controller framing: assess whether the Privacy Policy and DPA frame the operator as data processor when the deploying customer is data controller for trace, prompt, and response data sent to Arize AX.
- AI training opt-out: assess whether documentation makes explicit that customer trace and evaluation data is not used for training Arize's internal evaluation models or any third-party LLM provider models.
- Data retention: assess documented retention windows for trace data, evaluation results, datasets, and deleted customer data. Observability platforms by design retain trace data for extended periods (typical industry pattern: 14-day base tier + extended retention tier per prior VERDICT precedent #062 LangSmith); assess the retention model and customer controls.
- Data residency: assess documented region options for Arize AX (US, EU, others) and customer controls for region selection.
- Encryption: confirm at-rest and in-transit encryption specifications, including customer-managed key (CMEK) availability if any.
- Subprocessor disclosure: assess whether Arize publishes a subprocessor list with update cadence and customer notification mechanism. Note that Arize uses multiple LLM providers internally for the "council of judges" evaluation approach; these dependencies are critical subprocessor disclosures.
- Government customer claims: Series C announcement references "government agencies" as Arize customers; assess whether government-specific compliance certifications (FedRAMP, IL4/IL5, StateRAMP) are documented.
- SOC 2 / ISO 27001 / HIPAA: engine to verify against operator trust center.
- Self-hosted Arize Phoenix data conduct: when self-hosted, the deploying organization controls all data; assess whether documentation makes this distinction explicit.

### I — Identity & Control

- Authentication mechanisms for Arize AX: API key, OAuth, SAML SSO, SCIM provisioning. Assess what is documented for self-serve versus enterprise tier.
- RBAC and workspace structure: assess role definitions, permission granularity, and scoping to projects, environments, or model versions.
- API key management: scoping, rotation, revocation, and per-environment scoping.
- Audit logging: scope of audit events captured for operator and customer activity, retention windows, and export mechanisms.
- Multi-tenancy isolation: Arize AX is multi-tenant; assess what controls prevent cross-tenant trace data exposure.
- End-user identity propagation: when Arize evaluates AI agents that interact with end-users, how does trace data preserve end-user identity scoping versus aggregating at the customer-organization level?
- 2FA / MFA enforcement options.

### C — Containment

- Trace data egress: deploying applications send trace data to Arize AX; assess whether egress can be allowlisted, proxied, or scoped to specific Arize endpoints.
- "Council of judges" LLM invocation: Arize's evaluation methodology invokes multiple LLM providers internally for evaluation scoring. Assess whether customer trace data is sent to those LLM providers and whether customers can opt out or BYOK for evaluator LLMs.
- Self-hosted Arize Phoenix boundary: when Phoenix is self-hosted, the deploying organization controls all egress; assess whether documentation distinguishes the Cloud trust boundary from the Phoenix self-hosted trust boundary.
- Network controls: assess whether Arize AX supports IP allowlisting, private endpoint deployment, or VPC peering for enterprise tier.
- Action execution boundary: Arize is an observability layer, not an action execution layer; assess whether documentation makes explicit that Arize does not execute user-provided code or external API calls beyond LLM provider invocation for evaluation.
- Azure AI Studio / Azure AI Foundry integration trust boundary: when Arize is invoked through Azure AI Foundry, what is the data flow between Microsoft's hosted Azure environment and Arize's hosted infrastructure? (See Special Considerations section 2.)

### T — Transparency

- License clarity: Arize Phoenix license to be verified against the LICENSE file in github.com/Arize-ai/phoenix; engine to confirm and confirm CLA / DCO posture for external contributions.
- Documentation completeness: assess whether technical documentation, API reference, security disclosures, and compliance artifacts are accessible without gated authentication.
- Security disclosure cadence: assess publication of security advisories on GitHub for Arize Phoenix and on the trust center for Arize AX, including SLA tiers and bug bounty program scope.
- Status page transparency: status page presence and public incident postmortems.
- Subprocessor list: presence, last-updated indicator, notification mechanism for additions. Critical for Arize given the multi-LLM-provider "council of judges" architecture.
- Roadmap visibility: assess whether forward-looking product roadmap or quarterly updates are publicly available.
- Open-source initiative provenance: OpenEvals, AgentEvals, and Arize Phoenix are referenced as open-source initiatives in the Series C announcement; engine to verify repository governance, contribution guidelines, and academic citations.
- Velvet acquisition transparency: assess whether the acquisition is reflected in the Privacy Policy, DPA controller / processor designations, Trust Center subprocessor list, and corporate footer.
- Customer reference verifiability: per #064 Guardrails AI precedent, named enterprise customer claims require independent verification before being treated as positive evidence for V or T scoring.

---

## SPECIAL CONSIDERATIONS

### 1. Microsoft cap-table compound investor structure (framework v1.1 Trigger 2)

Arize AI's strategic investor cohort includes M12 (Microsoft's corporate venture fund) per the Series C round announced 2025-02-20. As of November 2025, Microsoft also holds a strategic equity commitment in Anthropic (up to USD 5 billion, subject to closing conditions per the joint Microsoft / NVIDIA / Anthropic announcement). This is a compound investor structure under VERDICT framework v1.1: Microsoft (via M12) holds equity positions in both the evaluator (Anthropic, operator of VERDICT) and the evaluated platform (Arize AI). VERDICT scoring is based exclusively on public data sources per the v0.3.1 framework, and no vendor revenue or paid certification influences the rating.

### 2. Microsoft non-arms-length channel relationship (framework v1.1 Trigger 3, additive)

Arize AI also has a publicly-disclosed commercial channel relationship with Microsoft beyond standard supplier-customer relations, including deep product integration with Azure AI Studio and Azure AI Foundry portal, SDK, and CLI. The operator publicly characterizes the partnership as "long-standing collaboration" reinforced by M12's strategic investment. This channel relationship is additive to the cap-table relationship described above and constitutes a non-arms-length channel under VERDICT framework v1.1 Trigger 3.

### 3. Velvet acquisition (2025-03-13)

Arize AI acquired Velvet (Business / Productivity Software, per PitchBook M&A record) on 2025-03-13. As of evaluation date, the public disclosure status of the acquisition's effect on the platform's feature lineage, data flows, subprocessor list, and legal-entity stack is unverified. Engine should:
- Verify whether Velvet is named in the current Subprocessor list or Trust Center.
- Verify whether the acquisition is reflected in the Privacy Policy, DPA controller / processor designations, and corporate footer at evaluation date.
- Verify whether any new data flows or feature integrations from Velvet are documented in the Subprocessor list or product documentation.
- Disclose the acquisition fact neutrally; do not infer architectural integration that is not documented in public sources.

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
- Include positive findings alongside risks. The open-source Arize Phoenix tier, the publicly-disclosed Series C investor cohort, the LLM-provider-agnostic platform design, the operator's open-source research initiatives (OpenEvals, AgentEvals), and any verified compliance certifications should be reflected where confirmed, alongside any documentation gaps, unverified self-claims (two million monthly downloads, first-to-market audio evaluation, "most widely adopted AI observability library"), named-customer reference verification status, and acquisition disclosure gaps.
- No intent attribution to Arize AI, to investors, to LLM providers, or to Microsoft.
- Structural context (Microsoft Trigger 2 + Trigger 3 compound disclosure, Velvet acquisition, LLM-provider-agnostic by design, Arize Phoenix OSS dual-tier structure) noted neutrally as fact, not as excuse, endorsement, or commentary.
- Strategy Brief #3 §3 B3 cross-reference structure: Trigger 2 paragraph (Section 1) carries the Anthropic equity disclosure and scoring disclaimer; Trigger 3 paragraph (Section 2) intentionally does not re-state these elements per the additive template.
- No political framing of Microsoft, Anthropic, or any party.
- Behavioral evaluation of observability accuracy, evaluation methodology effectiveness, or specific benchmark performance is out of scope for this Layer 0 review.

---
# END OF PROMPT

# VERDICT Evaluation Prompt — #062 LangSmith

---

## PLATFORM UNDER EVALUATION

**Name:** LangSmith
**Owner:** LangChain, Inc. — Delaware C-corporation, principal place of business San Francisco, California, United States. Founded 2022 by Harrison Chase (CEO) and Ankush Gola. Independent of Anthropic at every layer (no equity overlap with Anthropic / Anthropic Ventures in any funding round per public investor records). Disclosed investors include Benchmark (Series A lead, April 2023), Sequoia Capital (Series A co-lead, Feb 2024, $1.1B post-money valuation per third-party reporting), Conviction, Lux Capital, Cowboy Ventures, plus angels including Stanford-affiliated researchers. The LangChain framework (open-source, MIT) and LangGraph (open-source, MIT) are the same operator's products; LangSmith is the operator's commercial observability platform.
**Category:** LLM Observability · Agent Evaluation Platform · Cloud Service (with self-hosted Enterprise option)
**Primary product surfaces:**
- LangSmith Tracing (https://smith.langchain.com/) — distributed tracing for LLM/agent applications, base traces (14-day retention) + extended traces (400-day retention)
- LangSmith Evaluations — dataset-based eval, prompt regression, custom evaluator framework
- LangSmith Prompts — versioned prompt management, playground, A/B testing
- LangSmith Deployment / LangGraph Cloud — managed deployment for LangGraph agents
- SDKs: Python (`langsmith`), TypeScript/JavaScript (`langsmith`)
- Self-hosted Enterprise — customer-managed Kubernetes deployment on AWS / GCP / Azure
**Product URL:** https://www.langchain.com/langsmith
**GitHub:** https://github.com/langchain-ai
**Documentation:** https://docs.langchain.com/langsmith

---

## EVALUATION SCOPE

Evaluate LangSmith (observability + evaluation + deployment platform) under VERDICT Framework v0.3.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

The evaluated surface is the cloud-hosted LangSmith platform (US and EU regions) plus the documented self-hosted Enterprise deployment option. The open-source LangChain framework and LangGraph orchestration library are referenced as same-operator products but not re-evaluated here (LangChain framework was evaluated separately; LangGraph was evaluated separately). Behavioral evaluation of how LangSmith's evaluators detect specific failure modes is Layer 1+ scope and not assessed under this Layer 0 review.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://www.langchain.com/
- LangSmith product page: https://www.langchain.com/langsmith
- Pricing: https://www.langchain.com/pricing
- Documentation: https://docs.langchain.com/langsmith
- Pricing FAQ (Docs): https://docs.langchain.com/langsmith/pricing-faq
- Console: https://smith.langchain.com/
- Trust Center: https://trust.langchain.com/
- Trust Center Resources: https://trust.langchain.com/resources
- Terms of Service: engine to locate canonical URL at langchain.com or smith.langchain.com
- Privacy Policy: engine to locate canonical URL
- Data Processing Addendum: engine to locate at trust.langchain.com or langchain.com/legal
- Changelog: https://changelog.langchain.com/
- Support: https://support.langchain.com/

### Package distribution
- PyPI (Python SDK): https://pypi.org/project/langsmith/
- npm (TypeScript / JavaScript SDK): https://www.npmjs.com/package/langsmith
- GitHub organization: https://github.com/langchain-ai

### Security and vulnerability disclosure
- GitHub SECURITY.md: engine to locate organization-level or repo-level SECURITY.md across langchain-ai/* repos
- GitHub Security Advisories: https://github.com/langchain-ai (engine to enumerate published advisories across repos including langchain, langgraph, langsmith-sdk)
- CVE database (NVD) search terms: "LangChain", "langchain", "LangSmith", "langsmith", "LangChain Inc"
- OSV database: https://osv.dev/ (query ecosystem PyPI:`langsmith`, PyPI:`langchain`, PyPI:`langgraph`, npm:`langsmith`, npm:`langchain`)
- GHSA: https://github.com/advisories?query=langchain
- CISA KEV: https://www.cisa.gov/known-exploited-vulnerabilities-catalog (query for LangChain-related entries)
- Status page: https://status.smith.langchain.com/

### Community signals
- GitHub stars, forks, contributor counts across langchain-ai/langchain, langchain-ai/langgraph, langchain-ai/langsmith-sdk
- Release cadence: PyPI / npm release history + Changelog
- Recent public security incidents or postmortems: engine to verify against Status page history and Changelog

### Behavioral model

LangSmith is a cloud observability and evaluation platform that ingests trace events from customer LLM/agent applications via SDK or HTTP API. Operational behavior:

- **Trace ingestion** — SDK-instrumented applications send trace events (inputs, outputs, intermediate steps, metadata, latency, token counts, errors) to the LangSmith cloud over HTTPS
- **Retention tiers** — base traces retained 14 days at $2.50/1K trace pricing tier; extended traces retained 400 days at $5.00/1K pricing tier; customer chooses retention per trace via SDK or API
- **Evaluations** — dataset-based evals run server-side; customer-defined evaluators may call external LLM providers (OpenAI, Anthropic, Google, etc.)
- **Prompts** — versioned prompt storage; A/B testing routes a configurable fraction of traffic between prompt versions
- **LangSmith Deployment / LangGraph Cloud** — managed agent runtime, deployment runs metered separately from traces
- **Data residency** — customers may select US or EU region at signup; Enterprise plan supports self-hosted Kubernetes deployment on AWS / GCP / Azure such that "data never leaves your environment"
- **AI training** — operator does not use customer data for model training per Pricing FAQ and ToS
- **Self-hosted Enterprise** — customer-managed K8s cluster runs LangSmith; image / Helm chart distribution channel to be verified

The platform does not execute customer LLM code; it ingests trace records of executions that happen on the customer side. Evaluator runs and LangGraph Cloud deployment runs are operator-side executions; sandbox / isolation technology for those runtimes is to be verified by engine against public documentation.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Is the operator legal entity (LangChain, Inc.) named consistently across the Privacy Policy, DPA, Terms of Service, Trust Center, Changelog, and corporate footer?
- Is the boundary between open-source LangChain framework (MIT-licensed) and proprietary LangSmith platform clearly documented?
- Does the Trust Center disclose the SOC 2 Type II auditor name, certification scope, and validity dates? (Per Changelog, SOC 2 Type II was announced 2024-07; per LinkedIn announcement, LangGraph Platform joined the SOC 2 Type II attestation 2025-07.)
- Does the Trust Center publish a Subprocessor list with last-updated date and customer notification mechanism?
- Are LangGraph Cloud / LangSmith Deployment evaluator and agent runtime isolation technology documented in public materials?
- Are the SDK packages (PyPI `langsmith`, npm `langsmith`) signed or attested for supply-chain integrity?
- Is the SDK source code repository (langchain-ai/langsmith-sdk) publicly accessible and current?

### R — Resilience

- CVE / GHSA / OSV trailing-twelve-months count across `langchain-ai/*` GitHub repositories, PyPI `langsmith`, npm `langsmith`, and the broader LangChain ecosystem packages (`langchain`, `langgraph`, `langchain-core`) where LangSmith depends on or is bundled with them.
- CISA KEV: any LangChain / LangSmith entry at evaluation date.
- Status page (status.smith.langchain.com) incident history, retention, and any documented SLA commitments per pricing tier.
- Supply-chain integrity: signed releases, package provenance for `langsmith` PyPI and npm; any documented response to historical npm/PyPI ecosystem compromises.
- Penetration testing cadence — engine to verify Trust Center disclosure.
- Release cadence and breaking-change notification policy.

### D — Data Conduct

- AI training opt-out: Pricing FAQ states "LangSmith does not use your data to train models." Engine to verify this commitment is also reflected in the Privacy Policy, DPA, and Terms of Service with consistent wording.
- Retention asymmetry: base traces 14 days vs extended traces 400 days, customer-selected per trace; engine to assess whether the structural rationale and use-case guidance is publicly explained, and whether default behavior is documented (which retention tier applies when not explicitly specified).
- Customer data ownership: Pricing FAQ states "you own all rights to your data"; engine to verify consistency in ToS and DPA.
- DPA controller / processor structure: LangChain, Inc. as processor when Customer is controller; engine to verify the DPA scope explicitly covers LangSmith + LangGraph Cloud + LangSmith Deployment.
- HIPAA Business Associate Agreement: per FAQ, BAA is Enterprise-plan-only; engine to verify which product surfaces are HIPAA-eligible.
- GDPR Article 46 transfer mechanism documentation per non-EU subprocessor.
- Data export and deletion: engine to record API support and retention behavior post-deletion request.
- Self-hosted Enterprise: customer-controlled retention; engine to verify any operator-side telemetry the self-hosted deployment may emit to LangChain Inc. infrastructure.

### I — Identity & Control

- Authentication options: email/password, social SSO (Google / GitHub) at smith.langchain.com console; engine to verify against current documentation.
- SAML SSO and SCIM provisioning: typically Enterprise-tier; engine to verify availability, configuration documentation, and pricing tier gating.
- RBAC and workspace / organization structure: engine to record granularity, role definitions, and any tier gating.
- API key management: scoping (project-level, organization-level), rotation, revocation; transferability restrictions in ToS.
- Audit log availability and retention default; engine to record any tier gating.
- 2FA / MFA enforcement options.
- Workspace data isolation: multi-tenant cloud isolation controls documented in Trust Center or DPA.

### C — Containment

- LangSmith Deployment / LangGraph Cloud agent runtime: sandbox isolation technology, default network egress posture, CPU / memory / time limits, file persistence behavior.
- Evaluator execution: evaluators that call external LLM providers from operator-side infrastructure — egress destinations, customer API key handling, retention of evaluator outputs.
- Tenant isolation between LangSmith customers (multi-tenant cloud); SOC 2 Type II attested controls referenced; engine to record what is publicly disclosed beyond attestation references.
- Self-hosted Enterprise: customer-controlled cluster topology, ingress / egress documentation, customer-managed encryption keys availability.
- Trace data isolation at rest: encryption posture, key management options (operator-managed vs customer-managed KMS).
- A/B testing routing: traffic split between prompt versions runs server-side; engine to verify whether sensitive prompt content is processed only within the customer's region.

### T — Transparency

- Trust Center (trust.langchain.com) page count and content depth.
- Public DPA availability: engine to verify whether DPA is publicly accessible (vs NDA-gated) and assess completeness against an enterprise-grade DPA reference structure.
- Subprocessor list: publicly listed at Trust Center; engine to assess completeness, last-updated indication, and notification mechanism documented in DPA.
- Vulnerability / responsible disclosure policy: engine to locate (likely at trust.langchain.com or support.langchain.com), assess scope and SLA tiers.
- Status page (status.smith.langchain.com): presence, history retention, public incident postmortems.
- AI safety / governance framework references: NIST AI RMF, ISO/IEC 42001, EU AI Act mapping; engine to record presence or absence on Trust Center.
- Changelog (changelog.langchain.com): public release notes cadence, breaking-change communication, security-relevant announcements.
- SOC 2 / ISO 27001 report availability: NDA-gated vs publicly summarized; engine to record the access mechanism.

---

## SPECIAL CONSIDERATIONS

### 1. Same-operator ecosystem with previously evaluated open-source frameworks

LangChain, Inc. operates three platforms previously evaluated by VERDICT or referenced in this evaluation: the open-source LangChain framework (Agent Framework category, prior VERDICT evaluation #025), the open-source LangGraph orchestration library (Agent Orchestration category, prior VERDICT evaluation #035), and the proprietary LangSmith observability platform (this evaluation, #062). The legal entity, corporate governance, security posture, and DPA reference structure are shared across all three. Engine should evaluate LangSmith as a distinct platform without re-evaluating the framework dimensions, and where shared operator-level facts (legal entity, SOC 2 attestation, ToS) affect scoring, the engine should cite the LangSmith-specific surfaces (smith.langchain.com, trust.langchain.com Trust Center, Pricing FAQ) as the canonical sources rather than re-using prior evaluation findings.

### 2. Same-category prior evaluation: LangFuse (#060, Tier A, score 62)

LangSmith and LangFuse occupy the same LLM observability / agent evaluation category. LangFuse was evaluated as #060 (Tier A, score 62/85). The engine should apply identical V/R/D/I/C/T criteria to LangSmith as were applied to LangFuse, without comparative bias. The engine may neutrally note category-positioning facts (e.g., LangSmith's deeper LangChain-native integration, LangFuse's framework-agnostic open-core positioning) as factual structural context, but should not introduce comparative quality judgments. Differences in score that emerge from independent evaluation are recorded as facts about each platform's documented public posture, not as a ranking.

### 3. Indirect commercial relationship with Anthropic via framework-integration support

LangChain, Inc.'s products (the LangChain framework, LangGraph, and LangSmith) support Anthropic's Claude API as a first-class LLM provider. This constitutes an indirect commercial relationship: LangChain Inc. derives commercial value from supporting Claude (enabling customer applications that consume Claude), and Anthropic derives commercial value from LangChain Inc.'s framework adoption (which channels traffic to Claude). No equity relationship exists between Anthropic / Anthropic Ventures and LangChain, Inc. per public investor records. Engine should record this commercial-relationship fact neutrally and include the standard Bias Disclosure wording.

---

## KNOWN FACT CORRECTIONS

None applicable. No LangChain / LangSmith-specific entry exists in `KNOWN_FACTS.md` as of evaluation date.

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
- Include positive findings alongside risks. LangSmith's documented compliance posture (SOC 2 Type II, GDPR, HIPAA at Enterprise tier, public Trust Center, AI training opt-out, customer data ownership, US/EU regions, self-hosted Enterprise option) should be reflected where verified, alongside any documentation gaps, retention asymmetries, or unverified items surfaced during the evaluation.
- No intent attribution to operator, investors, or framework users.
- Structural or maintainer context (same-operator ecosystem with LangChain/LangGraph; same-category prior evaluation of LangFuse; framework support for multiple LLM providers including Anthropic Claude) noted neutrally as fact, not as excuse, endorsement, or commentary.
- Behavioral evaluation of LangSmith's evaluator effectiveness, prompt regression detection accuracy, or trace coverage completeness is out of scope for this Layer 0 review; defer to the Future Evaluation Plan with explicit Layer 1+ language.
- No political framing of any operator characteristic; restrict to neutral legal and structural language.

---
# END OF PROMPT

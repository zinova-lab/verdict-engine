# VERDICT Evaluation Prompt — #066 NeMo Guardrails

## PLATFORM UNDER EVALUATION

**Name:** NeMo Guardrails
**Owner:** NVIDIA Corporation — Delaware C-corporation, principal place of business Santa Clara, California, United States. NeMo Guardrails is an internal product of NVIDIA, developed and maintained as part of the NVIDIA NeMo software stack. Not an acquisition; not a subsidiary; the project is operated directly by NVIDIA's research and product organization. NVIDIA holds material strategic equity commitment in Anthropic (up to USD 10 billion, subject to closing conditions, announced 2025-11-18 per NVIDIA SEC Form 10-Q FY2026 Q3) — see Special Considerations section 1.
**Category:** AI Safety · LLM Guardrails / Programmable Constraints · Open-Source Toolkit (with commercial NIM deployment)
**Primary product surfaces:**
- NeMo Guardrails library — open-source Python toolkit (Apache 2.0), distributed via PyPI as `nemoguardrails` and via GitHub at NVIDIA-NeMo/Guardrails
- NeMo Guardrails CLI — `nemoguardrails chat`, `nemoguardrails server`, `nemoguardrails evaluate`, `nemoguardrails actions-server` commands packaged with the library
- NeMo Guardrails server — HTTP API server exposing `/v1/chat/completions` endpoint for guardrailed chat completions, deployable as standalone process or via Docker container
- NeMo Guardrails microservice (production deployment) — container image distributed via NVIDIA's NeMo microservices platform, designed for Kubernetes deployment with Helm charts; part of the broader NVIDIA AI Enterprise / NeMo software stack
- LangChain integration — opt-in via `NEMOGUARDRAILS_LLM_FRAMEWORK=langchain` environment variable, allowing guardrails to wrap LangChain Runnable objects
**Product URL:** https://github.com/NVIDIA-NeMo/Guardrails
**GitHub:** https://github.com/NVIDIA-NeMo/Guardrails
**Documentation:** https://docs.nvidia.com/nemo/guardrails/latest/

---

## EVALUATION SCOPE

Evaluate NeMo Guardrails (open-source toolkit primary scope; commercial NeMo Microservices production deployment referenced where publicly documented) under VERDICT Framework v1.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

The evaluated surface is the `nemoguardrails` open-source library as publicly documented at github.com/NVIDIA-NeMo/Guardrails and docs.nvidia.com/nemo/guardrails/. The NeMo Guardrails microservice (production container image for Kubernetes) is included to the extent its operational characteristics are publicly documented in the same documentation site; configuration and deployment details gated behind NVIDIA AI Enterprise contact are not assessed.

LLM model output behavior (alignment, jailbreak resistance, hallucination rates for any specific upstream LLM the guardrails wrap) is Layer 1+ behavioral evaluation scope and is not assessed under this Layer 0 review.

**CVE scope clarification**: NeMo Guardrails is a distinct product from the NeMo Framework (`nemo-toolkit` PyPI package, NVIDIA-NeMo/NeMo GitHub repository). CVEs assigned against the NeMo Framework (e.g., CVE-2025-23361, CVE-2025-23312, CVE-2025-33205, CVE-2025-33212, CVE-2025-23249, CVE-2025-23250, CVE-2025-23251, CVE-2024-0129) describe vulnerabilities in the speech / model framework, not in the guardrails toolkit. R dimension assessment must distinguish CVEs assigned to the `nemoguardrails` package or NeMo Guardrails repository from CVEs assigned to NeMo Framework or other NeMo-family products.

---

## KNOWN PUBLIC SOURCES

### Official project
- GitHub repository: https://github.com/NVIDIA-NeMo/Guardrails
- LICENSE.md: https://github.com/NVIDIA-NeMo/Guardrails/blob/main/LICENSE.md
- Documentation (current): https://docs.nvidia.com/nemo/guardrails/latest/
- Overview: https://docs.nvidia.com/nemo/guardrails/latest/about/overview.html
- Installation guide: https://docs.nvidia.com/nemo/guardrails/latest/getting-started/installation-guide.html
- Guardrails library documentation (built-in guardrails catalog): referenced from overview; engine to fetch canonical URL
- Configuration guide: referenced from README; engine to fetch canonical URL
- NeMo Microservices documentation (production deployment context): https://docs.nvidia.com/nemo/microservices/
- NVIDIA AI Enterprise product page: https://www.nvidia.com/en-us/ai-data-science/products/ai-enterprise/
- NVIDIA Trust Center: https://www.nvidia.com/en-us/security/
- NVIDIA Privacy Center: https://www.nvidia.com/en-us/about-nvidia/privacy-center/
- NVIDIA Corporate Privacy Policy: https://www.nvidia.com/en-us/about-nvidia/privacy-policy/

### Package distribution
- PyPI: https://pypi.org/project/nemoguardrails/
- PyPI release history: https://pypi.org/project/nemoguardrails/#history
- GitHub Releases: https://github.com/NVIDIA-NeMo/Guardrails/releases
- Docker / container image: engine to verify whether published to NVIDIA NGC container registry or to Docker Hub from documentation

### Security and vulnerability disclosure
- NVIDIA Security Bulletins: https://www.nvidia.com/en-us/security/security-bulletins/
- NVIDIA PSIRT contact: https://www.nvidia.com/en-us/security/psirt-policies/ (engine to verify reporting channel and disclosure SLA)
- GitHub Security Advisories: https://github.com/NVIDIA-NeMo/Guardrails/security/advisories
- CVE database (NVD) search terms: "NeMo Guardrails", "nemoguardrails", restricted to product strings matching `nemoguardrails` rather than `nemo` or `nemo-toolkit` broadly
- OSV database: https://osv.dev/list?q=nemoguardrails (PyPI ecosystem)
- GHSA index: https://github.com/advisories?query=nemoguardrails

### Community signals
- GitHub stars, forks, contributor count: https://github.com/NVIDIA-NeMo/Guardrails
- PyPI download statistics: https://pypistats.org/packages/nemoguardrails
- Release cadence: GitHub Releases + PyPI version history
- Issue and PR activity: https://github.com/NVIDIA-NeMo/Guardrails/issues
- EMNLP 2023 introductory paper (cited by NVIDIA): "NeMo Guardrails: A Toolkit for Controllable and Safe LLM Applications" — engine to retrieve via arXiv or ACL Anthology if relevant for V dimension provenance assessment

### Behavioral model

NeMo Guardrails is a Python library that intercepts LLM invocations to apply programmable safety controls. The library operates as middleware between an application and an LLM provider (Anthropic, OpenAI, Google, AWS Bedrock, NVIDIA NIM, Hugging Face, and others). It is LLM-provider-agnostic by design; the LLM is configured by the deploying developer, not by NVIDIA.

The library supports five guardrail types:
- **Input rails**: applied to user input before LLM invocation; can reject or alter input
- **Dialog rails**: enforce conversational flows defined by the developer
- **Retrieval rails**: applied to retrieved chunks in RAG workflows
- **Execution rails**: applied to action invocations (tool calls)
- **Output rails**: applied to LLM responses before delivery

Built-in guardrails include LLM self-checking (input/output moderation, fact-checking, hallucination detection), NVIDIA safety models (content safety, topic safety), jailbreak and injection detection, and integrations with community models and third-party APIs (ActiveFence, AlignScore, PolicyAI).

The library does not execute arbitrary shell commands and does not modify files outside the developer's working directory and configuration paths. Network egress occurs through outbound API calls to the developer-configured LLM provider and to optional third-party safety APIs (NVIDIA NIM endpoints, ActiveFence, AlignScore, etc.) using developer-supplied credentials. The library is stateless beyond per-conversation context held in memory during a session; persistent storage of conversation history is the deploying application's responsibility.

In production deployment as a microservice (`nemoguardrails server` or NeMo Microservices), the toolkit exposes an HTTP API on a configurable port; deployment, authentication, network egress controls, and data persistence are governed by the deploying organization's Kubernetes / container configuration, not by NVIDIA's hosted service.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Apache 2.0 licensing of the core NeMo Guardrails library (per repository LICENSE.md, SPDX-FileCopyrightText: Copyright NVIDIA CORPORATION & AFFILIATES): confirm the scope of OSS coverage, presence of CLA or DCO for contributions, and whether the OSS repository is the production build source for the PyPI package.
- NVIDIA as operating entity: verify corporate identity statement, contact paths, and engineering team disclosure (the EMNLP 2023 paper attributes the original toolkit to NVIDIA Research authors — engine to assess whether the GitHub repository and documentation site name NVIDIA Corporation consistently as operator).
- Documentation provenance: the documentation site at docs.nvidia.com/nemo/guardrails/ is hosted on NVIDIA's primary documentation domain; assess whether documentation versioning ties to specific library releases, and whether deprecated versions remain accessible.
- NeMo Microservices production deployment claims: assess whether the documentation distinguishes between OSS library capabilities and the production microservice's added capabilities, or conflates them.
- PyPI publisher identity: assess whether `nemoguardrails` is published from a verified NVIDIA-owned PyPI account, and whether package signing / sigstore / PEP 740 attestations are present.

### R — Resilience

- Recent CVEs assigned specifically to NeMo Guardrails or `nemoguardrails` package (trailing 12 months): engine to enumerate via NVD search restricted to `nemoguardrails` product string, GitHub Security Advisories at NVIDIA-NeMo/Guardrails/security/advisories, and OSV ecosystem `PyPI:nemoguardrails`. Distinguish from CVEs assigned to NeMo Framework (`nemo-toolkit`) which describe a distinct product.
- CISA KEV: any NeMo Guardrails entry at evaluation date.
- NVIDIA PSIRT disclosure process: assess publication of disclosure SLA, coordinated disclosure timeline, and patch release cadence as referenced from NVIDIA Security Bulletins.
- Release cadence: GitHub Releases shows recent versions including LangGraph + tool calling integration (per release notes) and LangChain RunnableRails support. Assess release frequency, semantic versioning discipline, and breaking-change notification.
- Supply chain integrity: signed releases on GitHub, PyPI package provenance (attestations, sigstore), and supply chain attack history (e.g., Shai-Hulud / npm-style compromises in the broader ecosystem; assess whether `nemoguardrails` was affected).
- Dependency hygiene: the PyPI package has multiple LangChain integration paths and optional extras (NVIDIA, AlignScore, etc.); assess dependency pinning discipline and the project's response to upstream CVEs in dependencies.

### D — Data Conduct

- LLM provider data flow: NeMo Guardrails routes prompts to developer-configured LLM providers using developer-supplied API keys. The deploying application controls which provider receives data; NVIDIA's library acts as middleware. Assess whether documentation makes this data flow explicit and whether the library logs or retains conversation content beyond runtime memory.
- Third-party safety API data flow: built-in integrations with ActiveFence, AlignScore, PolicyAI, and NVIDIA NIM endpoints involve outbound network calls. Assess documentation completeness for each integration's data handling, opt-out mechanism, and whether the data flow is documented as developer-controlled or NVIDIA-controlled.
- NVIDIA Corporate Privacy Policy applicability: assess whether the NVIDIA privacy policy applies to interactions with the OSS library (likely not, since the library executes in the developer's environment) versus the NeMo Microservices production offering (likely yes, if hosted as managed service).
- Training data and feedback loops: assess whether NVIDIA collects telemetry, usage statistics, or error reports from the OSS library by default, and whether opt-out is available.
- NVIDIA AI Enterprise tier: assess whether the commercial tier includes data processing agreements (DPA), customer-as-controller framing, and GDPR / CCPA / HIPAA references in publicly accessible documentation versus enterprise-contract-gated material.
- Subprocessor disclosure: assess whether the production NeMo Microservices offering publishes a subprocessor list comparable to enterprise SaaS providers.

### I — Identity & Control

- The OSS library has no built-in authentication; the deploying application owns auth and identity. Assess whether documentation makes this responsibility explicit.
- NeMo Guardrails server / microservice authentication: assess what authentication mechanisms are documented (API key, OIDC, mTLS, none) and whether secure defaults are recommended in deployment guides.
- NVIDIA AI Enterprise account management: assess whether the commercial tier offers SAML SSO, SCIM, RBAC, and audit logging, and whether these are documented publicly versus gated to sales contact.
- API key management for downstream LLM providers: assess whether the library documents secure credential handling patterns (environment variables, secret managers, key rotation) versus exposing keys in configuration files.
- Multi-tenancy: the library is single-tenant by design (one developer's deployment); assess whether the production microservice offers multi-tenant isolation or remains single-tenant per deployment.

### C — Containment

- Library execution boundary: NeMo Guardrails executes in the developer's Python process; sandbox or isolation is the deploying application's responsibility. Assess whether documentation enumerates the trust boundary explicitly.
- Outbound network egress: the library makes outbound calls to LLM providers and third-party safety APIs. Assess whether egress can be allowlisted, proxied, or disabled, and whether documentation provides guidance for security-sensitive deployments.
- Custom action execution: the library supports custom actions defined by the developer (custom Python functions invoked from guardrail configurations). Assess whether documentation warns about the trust implications of custom actions and whether sandboxing is recommended.
- Configuration injection risk: guardrail configurations are defined in YAML and Colang (a guardrails DSL). Assess whether the library validates configuration input and whether configuration loading from untrusted sources is documented as unsafe.
- Production microservice tenant isolation: when deployed as the NeMo Guardrails microservice on Kubernetes, assess whether documented Helm charts include resource limits, network policies, and pod security standards by default.
- LangChain integration risk surface: when LangChain integration is enabled, the library wraps arbitrary LangChain Runnable objects. Assess whether this expands the trust boundary in ways the documentation discusses.

### T — Transparency

- License clarity: Apache 2.0 across the core repository, with SPDX-FileCopyrightText attribution to NVIDIA CORPORATION & AFFILIATES. Confirm no internal feature gating in the OSS build documented publicly, and confirm contribution guidelines (CLA / DCO) for external commits.
- Security disclosure cadence: NVIDIA PSIRT publishes security bulletins for NVIDIA products. Assess whether NeMo Guardrails-specific advisories appear in NVIDIA Security Bulletins or only in GitHub Security Advisories on the repository.
- Documentation versioning: assess whether the documentation site exposes versioned snapshots tied to library releases (typical pattern: `latest/` symbolic plus version-pinned paths).
- Release notes detail: GitHub Releases include feature additions (LangGraph + tool calling, LangChain RunnableRails) per recent entries; assess granularity for breaking changes, deprecations, and migration paths.
- Research provenance: the EMNLP 2023 introductory paper provides academic peer-review provenance for the toolkit's design. Assess whether the documentation site references the paper as a transparent design rationale.
- Corporate transparency: NVIDIA is a publicly-traded company with SEC disclosures available. The strategic equity commitment in Anthropic (Special Considerations section 1) is publicly disclosed in NVIDIA's Form 10-Q.
- NeMo Microservices commercial tier transparency: assess whether SLA, support tiers, and compliance posture (SOC 2, ISO 27001, FedRAMP) for the commercial offering are publicly documented or gated to enterprise contact.

---

## SPECIAL CONSIDERATIONS

### 1. NVIDIA-Anthropic multi-layer commercial and equity relationship (framework v1.1 Trigger 1)

NVIDIA, the operator of NeMo Guardrails, has a multi-layer commercial and equity relationship with Anthropic (the operator of VERDICT). NVIDIA is a supplier of compute infrastructure to Anthropic, and Anthropic has committed up to USD 30 billion in Azure capacity (powered by NVIDIA) plus additional capacity up to 1 GW. Separately, as of November 2025, NVIDIA has committed to invest up to USD 10 billion in Anthropic, subject to closing conditions, per NVIDIA's SEC Form 10-Q (FY2026 Q3). VERDICT scoring is based exclusively on public data sources per the v0.3.1 framework, and no vendor revenue or paid certification influences the rating. Readers should weigh this multi-layer relationship when interpreting the evaluation.

### 2. NeMo Guardrails product-level Anthropic LLM integration (additive to section 1)

NeMo Guardrails supports multiple LLM providers, including Anthropic, OpenAI, and others, as integration options for end-user configuration. The presence of Anthropic as one available LLM provider in the toolkit is additive to the corporate-level relationships described above and is not material to scoring, which evaluates the toolkit's governance properties independent of LLM choice.

### 3. CVE attribution scope — NeMo Guardrails vs. NeMo Framework

NeMo Guardrails is a distinct product from the NeMo Framework. Multiple CVEs disclosed in 2024-2025 (CVE-2025-23361, CVE-2025-23312, CVE-2025-33205, CVE-2025-33212, CVE-2025-23249, CVE-2025-23250, CVE-2025-23251, CVE-2024-0129) describe vulnerabilities in the NeMo Framework (speech / model / training framework, package `nemo-toolkit`), not in the `nemoguardrails` guardrails toolkit. R dimension assessment must distinguish CVEs assigned to NeMo Guardrails from CVEs assigned to other NeMo-family products. Engine to enumerate NeMo Guardrails-specific CVEs via NVD product string match, GitHub Security Advisories on NVIDIA-NeMo/Guardrails, and PyPI OSV ecosystem `nemoguardrails`.

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
- Include positive findings alongside risks. NVIDIA's corporate transparency (SEC-disclosed equity positions, publicly-traded company filings), the toolkit's Apache 2.0 license, the EMNLP 2023 peer-reviewed academic provenance, and the explicit LLM-provider-agnostic design should be reflected where verified, alongside any documentation gaps and any CVEs assigned specifically to the guardrails toolkit.
- No intent attribution to NVIDIA, to the development team, or to any LLM provider mentioned in integration documentation.
- Structural context (NVIDIA as parent operator, NVIDIA-Anthropic multi-layer commercial and equity relationship, the OSS toolkit versus commercial microservice tier distinction) noted neutrally as fact, not as excuse, endorsement, or commentary.
- CVE scope discipline: distinguish CVEs assigned to `nemoguardrails` from CVEs assigned to `nemo-toolkit` or the broader NeMo Framework. The latter describe a distinct product family.
- No political framing of NVIDIA's corporate characteristics or geopolitical position; restrict to neutral legal and structural language.
- LLM model output behavior is out of scope for this Layer 0 review.

---
# END OF PROMPT

# VERDICT Evaluation Prompt — #065 Weaviate

## PLATFORM UNDER EVALUATION

**Name:** Weaviate
**Owner:** Weaviate B.V. (Netherlands, Amsterdam HQ — primary operating entity for non-US customers) and Weaviate, LLC (United States — contracting entity for US customers per Non-Enterprise Agreement). Independent, venture-backed (Series B, Index Ventures lead, 2023); no parent company; no acquisition history.
**Category:** Vector Database
**Primary product surfaces:**
- Weaviate Database — open-source core (BSD 3-Clause License per repository LICENSE file), self-hosted via Docker / Kubernetes / binaries
- Weaviate Cloud — managed service (Serverless and Enterprise tiers)
- Bring Your Own Cloud (BYOC) — Weaviate deployed in customer-controlled cloud account
- Client SDKs — Python, JavaScript / TypeScript, Go, Java, C# / .NET, plus community-maintained clients
- Cloud Console — web UI for cluster management and Query Agent access
**Product URL:** https://weaviate.io
**GitHub:** https://github.com/weaviate/weaviate
**Documentation:** https://docs.weaviate.io

---

## EVALUATION SCOPE

Evaluate Weaviate under VERDICT Framework v0.3.1 (Layer 0, public documentation only).
Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://weaviate.io
- Documentation: https://docs.weaviate.io
- Privacy policy: https://weaviate.io/privacy
- Security page: https://weaviate.io/security
- Trust portal (gated): https://trust.weaviate.io
- Service hub (all legal documents): https://weaviate.io/service
- General Terms: https://weaviate.io/service/general-terms
- Non-Enterprise Agreement (self-serve ToS): https://weaviate.io/service/weaviate-non-enterprise-agreement
- Weaviate Cloud Agreement: https://weaviate.io/service/weaviate-cloud-agreement
- Data Processing Agreement: https://weaviate.io/dpa
- Updates to Terms & Policies log: https://weaviate.io/service/updates-to-terms-and-policies
- Investors page: https://weaviate.io/company/investors

### Package distribution
- GitHub Releases: https://github.com/weaviate/weaviate/releases
- Container image registry: cr.weaviate.io/semitechnologies/weaviate (per official docker-compose example in repository README)

### Security and vulnerability disclosure
- GitHub Security Advisories: https://github.com/weaviate/weaviate/security/advisories
- Vendor security disclosure (November 2025 release): https://weaviate.io/blog/weaviate-security-release-november-2025
- CVE database (NVD) search terms: "weaviate", "Weaviate B.V."
- OSV database: https://osv.dev/list?q=weaviate
- VDP / Security Report channel: https://weaviate.io/security
- ISO 27001 certification announcement: https://weaviate.io/blog/weaviate-iso-compliant

### Community signals
- GitHub stars, forks, contributor count: https://github.com/weaviate/weaviate
- Security-tagged issues: https://github.com/weaviate/weaviate/issues?q=is%3Aissue+label%3Asecurity
- Release notes / cadence: https://docs.weaviate.io/weaviate/release-notes
- Community forum: https://forum.weaviate.io
- Blog (technical and corporate): https://weaviate.io/blog
- 2025 year-in-review (product roadmap signals): https://weaviate.io/blog/weaviate-in-2025

### Behavioral model
Weaviate is a database server. It stores vector embeddings alongside object data and exposes CRUD plus vector / keyword / hybrid search through REST, gRPC, and GraphQL APIs. It does not execute arbitrary shell commands and does not modify files outside its own data and backup directories. Network exposure is on configurable ports (defaults: REST 8080, gRPC 50051). Authentication is via API keys (native) or OIDC (configurable). Multi-tenancy is supported per collection (per-tenant data isolation). External egress occurs through optional modules (`text2vec-*`, `generative-*`, `reranker-*`, `qna-*`, `multi2vec-*`) that call third-party model APIs (OpenAI, Anthropic, Cohere, Hugging Face, AWS Bedrock, Google, Voyage AI, and others) using customer-supplied API keys (BYOK). Backups are written to customer-configured object storage (S3 / GCS / Azure Blob / filesystem). The Query Agent (GA 2025) executes retrieval planning against the user's own data under the user's auth scope.

---

## EVALUATION FOCUS AREAS

### V — Verifiability
- BSD 3-Clause licensing of the core Weaviate Database (per repository LICENSE file): confirm the scope of OSS coverage versus closed components (Cloud Console, Query Agent server-side logic, managed-tier features), and whether the OSS repository is the production build source.
- SOC 2 Type II and ISO 27001:2022 evidence access: the trust portal at trust.weaviate.io gates audit reports — assess what is publicly available versus NDA-gated, and whether the gating model is documented.
- CVE disclosure detail: the November 2025 vendor security blog discloses affected versions, CVSS scores, root cause, fix versions, and mitigation flags. Evaluate whether this level of detail is consistently provided across the security blog series.
- BYOC architecture claims: assess whether the operator-zero-access posture is supported by publicly documented architecture, customer-controlled keys, and encryption-at-rest specifications, or rests on marketing assertion alone.

### R — Resilience
- Recent CVEs (trailing 12 months): CVE-2025-67818 (Backup ZipSlip path traversal, CVSS 8.7 High, NVD published 2025-12-12) and CVE-2025-67819 (Shard Movement path traversal, CVSS 4.9 Medium, vendor blog November 2025). Both are path-traversal class disclosed in coordinated release through the VDP program (researcher: soohyun). Evaluate patch rollout discipline across 1.30.x / 1.31.x / 1.32.x / 1.33.x branches, Enterprise customer embargo handling, and seamless patching of managed Weaviate Cloud and Marketplace customers.
- Historical CVE footprint: CVE-2023-38976 (DoS in v1.20.0) is the oldest disclosed CVE. Confirm the total CVE count over the platform's lifetime and the proportion routed through structured disclosure versus discovered externally.
- Support window policy: documentation states the latest three minor versions are supported with bug fixes and security patches. Confirm this is documented as a policy rather than ad hoc practice.
- SLA documentation: assess publication of SLAs for Weaviate Cloud Serverless and Enterprise tiers, including uptime targets and credit mechanics.
- Backup module hardening: CVE-2025-67818 is in the backup module; documentation confirms the module can be disabled via the `enabled_modules` configuration as a workaround. Evaluate the broader pattern of module-level toggle controls for risk reduction.

### D — Data Conduct
- Data residency: documented multi-region deployment options for Weaviate Cloud (EU and US zones). Confirm scope and customer controls.
- Customer-as-controller framing: the privacy policy explicitly states that Weaviate is data processor (not controller) for personal data uploaded to the Serverless service, with the corporate customer qualifying as sole data controller under GDPR. Assess whether this framing is consistent across Privacy Policy, DPA, and customer agreements.
- DPA terms: the public DPA includes Standard Contractual Clauses (SCCs) for transfers outside the EEA, Article 32 GDPR TOM measures, and a 30-day data deletion commitment post-cessation. Evaluate completeness against industry baseline.
- HIPAA scope: HIPAA-compliant services are explicitly limited to the Dedicated cloud offering, not Serverless. Confirm BAA availability and the boundary between Dedicated and Serverless tiers.
- Aggregated-information clause in self-serve ToS: Weaviate reserves the right to aggregate and analyze usage data for product improvement, disclosed only in aggregated and anonymized format. Assess clarity and customer opt-out mechanisms.
- Encryption: confirm at-rest and in-transit encryption specifications, including customer-managed key (CMEK) availability per managed-tier documentation.
- Subprocessor disclosure: the DPA references a Weaviate Data Subprocessors document. Evaluate the public availability and update cadence of the subprocessor list.

### I — Identity & Control
- Authentication mechanisms: native API key authentication, OIDC integration, and the cluster RBAC framework introduced through 2025 per the 2025 year-in-review blog. Evaluate granularity (role definitions, permission scope, scoping to collections and tenants).
- OIDC group management: confirm provider compatibility and group-to-role mapping capabilities.
- Multi-tenancy isolation: assess the architecture of per-tenant data separation, including whether tenant isolation is logical (shared cluster) or physical (separate clusters), and the controls preventing cross-tenant data exposure.
- Audit logging: scope of audit events captured for operator and customer activity, retention windows, and export mechanisms.
- Customer-managed keys: extent to which customers can control encryption keys, authentication credentials, and module API key storage.

### C — Containment
- Module isolation: the modular architecture allows enabling and disabling components (vectorizers, generative modules, rerankers, backup, shard-movement). Evaluate whether modules execute in the main Weaviate process or in isolated contexts, and how customer control over enabled modules is exposed.
- Generative module egress: when `generative-anthropic`, `generative-openai`, `generative-cohere`, or similar modules are enabled, Weaviate makes outbound API calls to third-party model providers using customer-supplied API keys. Evaluate whether egress can be constrained (allowlist, proxy, disable) and how this is documented for security-sensitive deployments.
- Shard movement API: this surface was the locus of CVE-2025-67819 and is documented as disabled by default. Evaluate whether the default-disabled posture is consistent across managed-tier and self-hosted deployments.
- Backup destination controls: backups write to customer-configured object stores; assess whether destination credential isolation and write-path validation are documented post the November 2025 patches.
- BYOC operational boundary: the BYOC deployment model places Weaviate components inside a customer-controlled cloud account. Evaluate the documentation of the operational boundary — what Weaviate operates remotely versus what the customer controls locally.

### T — Transparency
- License clarity: BSD 3-Clause across the core repository with no internal feature gating in the OSS build documented publicly. Confirm contribution guidelines, CLA scope, and governance model for commits.
- Security disclosure cadence: blog-based CVE disclosures with affected versions, CVSS, fix versions, and embargo handling. Evaluate the consistency of this pattern across the security blog series.
- Trust portal gating: assess what compliance artifacts are publicly visible at trust.weaviate.io versus gated (audit reports, SOC 2 letter, ISO certificate).
- Roadmap visibility: the 2025 year-in-review and earlier annual posts function as public roadmap retrospective signals. Evaluate whether forward-looking roadmap signals are also publicly available.
- Release notes detail: assess the granularity of release notes for breaking changes, deprecations, and migration paths.
- Corporate transparency: investor list is published; subprocessor list is referenced in the DPA. Evaluate whether ownership structure and key corporate facts are disclosed without requiring third-party data services.

---

## SPECIAL CONSIDERATIONS

### 1. Anthropic indirect commercial integration via generative module

Weaviate ships a `generative-anthropic` module that enables retrieval-augmented generation using Anthropic Claude models. The module is default-enabled on Weaviate Cloud (WCD) instances. Customers supply their own Anthropic API keys (BYOK pattern); no direct billing relationship between Anthropic and Weaviate is publicly disclosed. Anthropic models are also accessible indirectly through the AWS Bedrock generative module.

### 2. Two coordinated path-traversal CVEs disclosed November–December 2025

CVE-2025-67818 (Backup ZipSlip, CVSS 8.7 High, NVD 2025-12-12) and CVE-2025-67819 (Shard Movement, CVSS 4.9 Medium, vendor blog November 2025) are both path-traversal class vulnerabilities. Both were reported through Weaviate's VDP program by an external researcher (soohyun) and patched in a coordinated release across the 1.30.x, 1.31.x, 1.32.x, and 1.33.x supported branches. Enterprise customers received embargo notification; Weaviate Cloud and cloud Marketplace customers were patched without customer action.

### 3. ISO 27001:2022 certification obtained September 2025

Weaviate received ISO 27001:2022 certification on 2025-09-24 per vendor blog disclosure, joining existing SOC 2 Type II certification. HIPAA-compliant services are available through the Dedicated cloud offering only, not the Serverless tier. Audit reports, test results, and certificates are accessible through the trust portal at trust.weaviate.io.

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
- Include positive findings alongside risks.
- No intent attribution.
- Structural or maintainer context noted neutrally, not as excuse.

---
# END OF PROMPT

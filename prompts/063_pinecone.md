# VERDICT Evaluation Prompt — #063 Pinecone

---

## PLATFORM UNDER EVALUATION

**Name:** Pinecone
**Owner:** Pinecone Systems, Inc. — Delaware C-corporation, principal place of business New York, New York, United States. Founded 2019 by Edo Liberty (CEO, formerly Yahoo Research and AWS AI Labs). Independent of Anthropic at every layer (no equity overlap with Anthropic / Anthropic Ventures in any funding round per public investor records). Disclosed investors include Andreessen Horowitz (Series B lead, April 2023, $100M, ~$750M post-money valuation per third-party reporting), ICONIQ Growth (Series B co-lead), Wing Venture Capital, Menlo Ventures, plus earlier seed investors. Pinecone is the operator of the Pinecone Serverless managed vector database, the Pinecone Assistant retrieval-and-generation product, and Pinecone Inference (managed embedding model hosting).
**Category:** Vector Database · Retrieval Infrastructure · Cloud Service (with BYOC and Enterprise options)
**Primary product surfaces:**
- Pinecone Serverless (https://app.pinecone.io/) — fully managed multi-tenant vector database, pay-per-use, AWS / Azure / GCP regions
- Pinecone Assistant — retrieval-augmented generation service (chunk + embed + retrieve + LLM call); supported LLM providers include Anthropic Claude, OpenAI, Google models
- Pinecone Inference — managed embedding model hosting
- BYOC (Bring Your Own Cloud, GA 2024) — Pinecone cluster runs in the customer's own AWS / Azure / GCP account
- SDKs: Python (`pinecone-client`), TypeScript / JavaScript (`@pinecone-database/pinecone`), plus Java, Go community SDKs
- Marketplace listings: AWS Marketplace, Azure Marketplace, GCP Marketplace
**Product URL:** https://www.pinecone.io/
**GitHub:** https://github.com/pinecone-io
**Documentation:** https://docs.pinecone.io/

---

## EVALUATION SCOPE

Evaluate Pinecone (managed vector database + retrieval platform) under VERDICT Framework v0.3.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

This is the first vector database category evaluation under VERDICT framework. Where vector database semantics differ from agent platform semantics (notably C — Containment for vector DB primarily concerns multi-tenant index isolation rather than sandbox isolation), the engine should explicitly note the dimension adaptation in the relevant section. The evaluated surface is the cloud-hosted Pinecone Serverless plus the documented BYOC and Enterprise deployment options. Behavioral evaluation of retrieval accuracy, embedding quality, or specific RAG outcomes is Layer 1+ scope and not assessed under this Layer 0 review.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://www.pinecone.io/
- Documentation: https://docs.pinecone.io/
- Release notes: https://docs.pinecone.io/release-notes/2026
- Console: https://app.pinecone.io/
- Pricing: https://www.pinecone.io/pricing/
- Security page: https://www.pinecone.io/security/
- Trust Center: https://security.pinecone.io/
- HIPAA announcement: https://www.pinecone.io/blog/hipaa/
- Blog: https://www.pinecone.io/blog/
- Terms of Service: engine to locate canonical URL
- Privacy Policy: engine to locate canonical URL
- Customer Data Protection Addendum (DPA): engine to locate via Trust Center or pinecone.io/legal

### Package distribution
- PyPI (Python SDK): https://pypi.org/project/pinecone-client/
- npm (TypeScript / JavaScript SDK): https://www.npmjs.com/package/@pinecone-database/pinecone
- GitHub organization: https://github.com/pinecone-io
- AWS Marketplace: engine to locate listing
- Azure Marketplace: https://marketplace.microsoft.com/en-us/product/saas/pineconesystemsinc1688761585469.pineconesaas
- GCP Marketplace: engine to locate listing

### Security and vulnerability disclosure
- GitHub SECURITY.md: engine to locate at github.com/pinecone-io organization or repo level
- GitHub Security Advisories: https://github.com/pinecone-io (engine to enumerate published advisories)
- CVE database (NVD) search terms: "Pinecone", "Pinecone Systems", "pinecone-client"
- OSV database: https://osv.dev/ (query ecosystem PyPI:`pinecone-client`, npm:`@pinecone-database/pinecone`)
- GHSA: https://github.com/advisories?query=pinecone
- CISA KEV: https://www.cisa.gov/known-exploited-vulnerabilities-catalog (query for Pinecone-related entries)
- Status page: https://status.pinecone.io/ (engine to verify URL)
- Trust Center incident disclosures: security.pinecone.io publishes incident-response statements (e.g., Shai-Hulud NPM worm declarations, Salesloft investigation)

### Community signals
- GitHub stars, forks, contributor counts across pinecone-io/* repositories including pinecone-python-client, pinecone-ts-client
- Release cadence: GitHub Releases + Pinecone Blog + Release Notes
- Customer references (public): Notion is publicly cited; additional named customers to be enumerated from pinecone.io/customers or case studies

### Behavioral model

Pinecone is a managed vector database that ingests dense (and sparse, in some configurations) vectors and serves nearest-neighbor similarity queries. Operational behavior:

- **Pinecone Serverless** — fully managed multi-tenant cloud service. Indexes are organized into namespaces for logical separation. Storage and querying are billed per-use; minimum $50/month on the Standard plan.
- **Multi-cloud** — AWS, Azure, GCP across US and EU regions; customer selects region at index creation.
- **BYOC** — Pinecone cluster software runs inside the customer's own cloud account (AWS / Azure / GCP), providing infrastructure-level isolation; typically Enterprise-tier.
- **Pinecone Assistant** — retrieval-augmented generation service. Customer uploads documents; Pinecone Assistant chunks, embeds, stores in a managed index, and serves chat completion responses by combining retrieval with a customer-selected LLM provider (Anthropic Claude, OpenAI GPT, Google Gemini, etc.). Per Pinecone's 2026 release notes, automatic routing is implemented for deprecated Claude models (3.5 Sonnet, 3.7 Sonnet) to Claude Sonnet 4.5.
- **Pinecone Inference** — operator-hosted embedding models invoked via API.
- **Authentication and access control** — API keys per project with configurable role-based permissions across control plane and data plane; SSO; 2FA; RBAC at organization and project levels.
- **Encryption** — AES-256 at rest, TLS 1.2 with AES-256 in transit via HTTPS and gRPC.
- **Customer-managed keys (BYOK)** — option to encrypt data using customer's cloud provider KMS.
- **Private connectivity** — option to connect without exposing traffic to the public internet (e.g., AWS PrivateLink-style endpoints; engine to verify availability across cloud providers).

The platform does not execute customer code outside its own retrieval and embedding pipelines. Pinecone Assistant invokes external LLM APIs on behalf of the customer using customer-provided LLM API keys or customer-funded model usage.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Is the operator legal entity (Pinecone Systems, Inc.) named consistently across the Privacy Policy, DPA, Terms of Service, Security page, Trust Center, and corporate footer?
- Is the boundary between Pinecone Serverless, Pinecone Assistant, Pinecone Inference, and BYOC clearly documented in pricing and architecture references?
- Does the Trust Center (security.pinecone.io) disclose SOC 2 Type II auditor name, certification scope, and validity dates? (2025 audit completed with zero deviations per public statement.)
- Does the Trust Center disclose ISO 27001 certification details (auditor, scope, validity) where claimed?
- Does the Trust Center publish a Subprocessor list with last-updated date and customer notification mechanism?
- Is the BYOC architecture (cluster topology, control-plane data flow back to Pinecone, customer-side resource consumption) documented in public materials?
- Are the SDK packages (PyPI `pinecone-client`, npm `@pinecone-database/pinecone`) signed or attested for supply-chain integrity?

### R — Resilience

- CVE / GHSA / OSV trailing-twelve-months count across `pinecone-io/*` GitHub repositories, PyPI `pinecone-client`, npm `@pinecone-database/pinecone`.
- CISA KEV: any Pinecone-related entry at evaluation date.
- Status page (status.pinecone.io) incident history, retention, and documented SLA commitments per pricing tier. Marketing materials reference 99.95% uptime SLA; engine to verify against canonical SLA document.
- Supply-chain integrity response: Trust Center has published affirmative statements regarding the Shai-Hulud / Shai-Hulud 2.0 NPM worm campaigns ("not affected") and Salesloft integration ("never installed or used"). Engine to verify both statements still appear at evaluation date and assess T-dimension scoring.
- Penetration testing cadence — engine to verify Trust Center disclosure.
- Multi-availability-zone resilience: marketing references automatic multi-AZ spanning; engine to verify against architecture documentation.

### D — Data Conduct

- AI training: Pinecone is a vector database, not an LLM provider, so model-training opt-out semantics differ. Engine to verify whether Pinecone's Privacy Policy and DPA include any operator-side use of customer vector data for analytics, product improvement, or aggregated metrics, and assess transparency of those flows.
- Encryption at rest (AES-256) and in transit (TLS 1.2 with AES-256) documented; engine to verify and assess key management options including customer-managed KMS.
- Retention: vector data retained until customer-initiated deletion; engine to verify retention policy for soft-deleted indexes, backups, and operator-side logs.
- DPA controller / processor structure: Pinecone Systems, Inc. as processor when Customer is controller; engine to verify the DPA explicitly covers Pinecone Serverless + Pinecone Assistant + Pinecone Inference + BYOC.
- HIPAA Business Associate Agreement: Standard plan customers can add HIPAA compliance for $190/month (HIPAA-ready infrastructure, encrypted storage, audit logging, BAA execution); Enterprise plan includes HIPAA inclusively. Engine to verify scope (which product surfaces are HIPAA-eligible).
- GDPR Article 46 transfer mechanism documentation per non-EU subprocessor.
- Data deletion: documented as customer-initiated and engine to verify backup retention post-deletion.

### I — Identity & Control

- Authentication options: email/password, social SSO; engine to verify against documentation.
- SAML SSO and SCIM provisioning: engine to verify availability and any tier gating.
- RBAC and organization / project structure: documented RBAC at organization and project levels; engine to record granularity and any tier gating.
- API key management: project-scoped keys with configurable role-based permissions across control plane and data plane; rotation and revocation documentation.
- Audit log availability: documented system event monitoring for operational visibility and security compliance; engine to verify retention default and any tier gating.
- 2FA / MFA enforcement options.
- Deletion protection: documented "additional layer of verification to prevent accidental deletion of an index and its data"; engine to verify availability across plans.

### C — Containment

> The C (Containment) dimension is here adapted to vector database semantics: sandbox-level isolation of executed code is not applicable (Pinecone does not execute customer code); instead, the dimension evaluates multi-tenant index isolation, namespace separation, BYOC infrastructure isolation, and customer-managed encryption keys.

- Multi-tenant index isolation in the shared Pinecone Serverless cloud: documented controls and SOC 2 Type II / ISO 27001 attested coverage; engine to record what is publicly disclosed beyond attestation references.
- Namespace separation within an index: documented multi-tenant isolation pattern; engine to verify documentation specificity (e.g., cross-namespace query prohibition guarantees).
- BYOC architecture: Pinecone cluster running in customer's own AWS / Azure / GCP account — engine to assess whether public documentation specifies the control-plane data flow that Pinecone retains versus what stays in the customer account, and the implications for tenant isolation guarantees.
- Customer-managed encryption keys (BYOK via customer's cloud KMS): engine to verify availability per plan and per cloud provider.
- Private endpoint connectivity: engine to verify availability per plan and per cloud provider.
- Pinecone Assistant LLM-provider invocation: customer's LLM API calls flow from Pinecone-operated infrastructure to external LLM providers (Anthropic, OpenAI, Google) — engine to assess whether retention, logging, and key handling for this LLM-call leg are documented.

### T — Transparency

- Trust Center (security.pinecone.io, SafeBase-powered) page count and content depth.
- Public DPA availability: engine to verify whether DPA is publicly accessible vs NDA-gated, and assess completeness against an enterprise-grade DPA reference structure.
- Subprocessor list: engine to verify presence at Trust Center, assess completeness, last-updated indication, and notification mechanism documented in DPA.
- Vulnerability / responsible disclosure policy: engine to locate (likely at security.pinecone.io or via security@pinecone.io contact).
- Status page: presence, history retention, public incident postmortems.
- AI safety / governance framework references: NIST AI RMF, ISO/IEC 42001, EU AI Act mapping; engine to record presence or absence on Trust Center.
- Affirmative incident-response statements: Shai-Hulud unaffected declaration and Salesloft "never installed" declaration are positive transparency signals when verified; engine to score affirmative-disclosure pattern in T dimension.
- SOC 2 / ISO 27001 report availability: NDA-gated vs publicly summarized; engine to record the access mechanism.

---

## SPECIAL CONSIDERATIONS

### 1. First vector database category evaluation under VERDICT framework

This is the first vector database evaluated under VERDICT framework. The C dimension is adapted from sandbox-isolation semantics (used for agent platforms) to multi-tenant-index-isolation semantics (appropriate for vector databases). Engine should explicitly note this dimension adaptation in the C section header or first paragraph, with one to two sentences describing the adaptation. This is a precedent-setting evaluation for the framework's applicability across adjacent AI-infrastructure categories; engine should record any other dimension where vector-database semantics required adaptation, neutrally and without commentary on framework limitations.

### 2. Direct commercial integration with Anthropic Claude API via Pinecone Assistant

Pinecone Assistant directly integrates Anthropic Claude as a supported LLM provider. Per Pinecone's 2026 release notes published at docs.pinecone.io: Pinecone has implemented operator-side routing logic that automatically routes chat requests specifying Claude 3.5 Sonnet or 3.7 Sonnet to Claude Sonnet 4.5 following Anthropic's model deprecation, with no customer code changes required. This represents a direct commercial relationship in which Pinecone's paid product (Pinecone Assistant) consumes Anthropic Claude API and responds operationally to Anthropic's model lifecycle decisions. No equity relationship exists between Anthropic / Anthropic Ventures and Pinecone Systems, Inc. per public investor records. Engine should record this commercial-relationship fact neutrally in the Contextual Analysis section, with the standard Bias Disclosure wording in the report's bias-disclosure section.

### 3. Recent affirmative incident-response disclosures at security.pinecone.io

The Trust Center has published two affirmative incident-response statements within the trailing-twelve-month window: (a) regarding the Shai-Hulud and Shai-Hulud 2.0 NPM worm campaigns, Pinecone published a statement following a comprehensive infrastructure-and-dependency audit confirming that Pinecone is not affected, and that monitoring and detection logic specifically designed to identify the worm has been deployed; (b) regarding the Salesloft integration that affected other vendors, Pinecone published an internal-investigation statement confirming that Pinecone has never installed or used any Salesloft integration. Engine to verify both statements still appear at security.pinecone.io at evaluation date and assess T-dimension scoring as positive affirmative-disclosure signals. Engine should not extrapolate from these specific disclosures to broader incident-response maturity claims that are not separately documented.

---

## KNOWN FACT CORRECTIONS

None applicable. No Pinecone-specific entry exists in `KNOWN_FACTS.md` as of evaluation date.

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
- Include positive findings alongside risks. Pinecone's documented compliance posture (SOC 2 Type II with zero deviations 2025, HIPAA via Standard add-on or Enterprise, GDPR, encryption at rest and in transit, customer-managed KMS option, multi-cloud deployment, 99.95% SLA reference, affirmative incident-response disclosures, BYOC option) should be reflected where verified, alongside any documentation gaps or unverified items surfaced during the evaluation.
- No intent attribution to operator, investors, or customers (including Anthropic).
- Structural or maintainer context (first vector database category evaluation; Pinecone Assistant direct Claude integration; affirmative incident-response disclosure pattern) noted neutrally as fact, not as excuse, endorsement, or commentary.
- Behavioral evaluation of retrieval quality, embedding accuracy, or specific RAG outcomes is out of scope for this Layer 0 review; defer to the Future Evaluation Plan with explicit Layer 1+ language.
- No political framing of any operator characteristic; restrict to neutral legal and structural language.

---
# END OF PROMPT

# VERDICT Evaluation Prompt — #064 Guardrails AI

---

## PLATFORM UNDER EVALUATION

**Name:** Guardrails AI
**Owner:** Guardrails AI, Inc. — Delaware C-corporation, principal place of business Menlo Park, California, United States. Founded 2023 by Shreya Rajpal (CEO, formerly Apple ML engineer and Predibase founding engineer), Diego Oppenheimer (formerly Algorithmia / DataRobot), Safeer Mohiuddin (formerly AWS), and Zayd Simjee (formerly AWS). Independent of Anthropic at every layer (no equity overlap with Anthropic / Anthropic Ventures in any funding round per public investor records). Disclosed investors include Zetta Venture Partners (Seed lead, February 2024, $7.5M total round), Bloomberg Beta, Pear VC, Factory, GitHub Fund, and angel investors including Ian Goodfellow (Google DeepMind), Logan Kilpatrick (Google / formerly OpenAI), and Lip-Bu Tan. Reported employee count approximately 11 (per Tracxn, January 2026). The Guardrails open-source framework is Apache-2.0-licensed; Guardrails Hub is the open validator marketplace; the operator also offers a commercial cloud platform.
**Category:** AI Safety · LLM Guardrails / Validators · Open-Source Framework + Commercial Cloud Platform
**Primary product surfaces:**
- Guardrails (Python framework, Apache 2.0) — input/output validators around LLM applications; published as PyPI package
- Guardrails Hub (https://hub.guardrailsai.com/) — open marketplace of community-contributed validators
- Guardrails commercial platform (https://www.guardrailsai.com/) — managed runtime guardrails, synthetic data simulation, eval dataset generation
- LLM-provider-agnostic by design: supports Anthropic Claude, OpenAI, Google, open-source models
**Product URL:** https://www.guardrailsai.com/
**GitHub:** https://github.com/guardrails-ai
**Documentation:** https://www.guardrailsai.com/docs

---

## EVALUATION SCOPE

Evaluate Guardrails AI (open-source guardrails framework + Guardrails Hub validator marketplace + commercial cloud platform) under VERDICT Framework v0.3.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

This is the first AI safety / guardrails / validator-category evaluation under VERDICT framework. The evaluated surface combines (a) the open-source Python framework distributed via PyPI and GitHub, (b) the Guardrails Hub marketplace, and (c) the commercial cloud platform where available. Behavioral evaluation of how individual validators perform on specific failure modes (hallucination detection rate, PII recall, prompt-injection block rate) is Layer 1+ scope and not assessed under this Layer 0 review.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://www.guardrailsai.com/
- Documentation: https://www.guardrailsai.com/docs
- Guardrails Hub: https://hub.guardrailsai.com/
- Blog: https://www.guardrailsai.com/blog
- Terms of Service: engine to locate canonical URL at guardrailsai.com
- Privacy Policy: engine to locate canonical URL
- Data Processing Addendum: engine to locate (may not be publicly available given operator stage)
- Trust Center: engine to verify presence (may not exist given operator stage)

### Package distribution
- PyPI (Python framework): https://pypi.org/project/guardrails-ai/
- GitHub organization: https://github.com/guardrails-ai

### Security and vulnerability disclosure
- GitHub SECURITY.md: engine to locate at github.com/guardrails-ai/guardrails or organization level
- GitHub Security Advisories: https://github.com/guardrails-ai (engine to enumerate published advisories)
- CVE database (NVD) search terms: "Guardrails AI", "guardrails-ai", "guardrails", "Guardrails Hub"
- OSV database: https://osv.dev/ (query ecosystem PyPI:`guardrails-ai`)
- GHSA: https://github.com/advisories?query=guardrails
- CISA KEV: https://www.cisa.gov/known-exploited-vulnerabilities-catalog (query for Guardrails-related entries)
- Status page: engine to verify presence

### Community signals
- GitHub stars, forks, contributor counts at github.com/guardrails-ai/guardrails (reported ~2,900 stars per investor materials early 2024; engine to verify current count)
- PyPI download volume (reported ~10,000 monthly downloads per investor materials early 2024; engine to verify current)
- Guardrails Hub validator count and contributor diversity
- Release cadence: GitHub Releases + PyPI release history

### Behavioral model

Guardrails AI is an LLM safety / validation framework that wraps LLM calls with input and output guards. Operational behavior:

- **Open-source framework (Guardrails)** — Python library installed via PyPI; runs in the customer's application process. The framework intercepts LLM inputs and outputs, runs configured validators (regex-based, ML-classifier-based, or LLM-as-judge), and applies corrective actions (reask, exception, refrain, fix).
- **Guardrails Hub** — public marketplace of validators (community-contributed and operator-published). Validators are distributed as Python packages or Hub entries downloadable to the customer's environment.
- **LLM-provider-agnostic** — the framework operates between the customer's application and any LLM provider (Anthropic, OpenAI, Google, self-hosted models). Customer-provided LLM API keys are used.
- **Commercial cloud platform** — engine to verify scope; reported functionality includes managed runtime guardrails (validators run in Guardrails-operated infrastructure rather than customer process), synthetic data simulation, and evaluation dataset generation.
- **LLM-as-judge validators** — some validators invoke an LLM (customer-selected, including Anthropic Claude) to evaluate outputs; the customer's data therefore may flow through external LLM providers as part of validation.

The open-source framework executes in the customer's process; the commercial cloud platform executes operator-side. Engine to assess both surfaces.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Is the operator legal entity (Guardrails AI, Inc.) named consistently across the Privacy Policy, Terms of Service, GitHub repository, and corporate footer?
- Is the boundary between the open-source Apache-2.0 framework and the commercial cloud platform clearly documented?
- Is there a Trust Center, security page, or equivalent compliance posture page?
- Are the SDK / framework packages (PyPI `guardrails-ai`) signed or attested for supply-chain integrity?
- Is the source code repository (github.com/guardrails-ai/guardrails) publicly accessible, current, and the canonical distribution channel?
- Are Guardrails Hub validators reviewed, code-signed, or otherwise verifiable before customer download?
- Is the commercial platform architecture documented in public materials (whether managed runtime exists, where validators execute, network egress flows)?

### R — Resilience

- CVE / GHSA / OSV trailing-twelve-months count across `guardrails-ai/*` GitHub repositories and PyPI `guardrails-ai`.
- CISA KEV: any Guardrails-related entry at evaluation date.
- Status page presence (if commercial cloud platform exists with public uptime tracking).
- Supply-chain integrity: signed releases, package provenance for PyPI `guardrails-ai`; any documented response to historical PyPI ecosystem compromises.
- Validator code review and security review process for Guardrails Hub submissions.
- Release cadence: GitHub Releases + PyPI release history.
- Penetration testing: engine to verify presence of disclosure.

### D — Data Conduct

- AI training: engine to verify whether operator uses customer data (validator inputs, outputs, telemetry) for any model training, product improvement, or aggregated analytics. Per "silence is data" principle, absence of explicit opt-out documentation should be scored accordingly.
- Privacy Policy: engine to locate, verify operator's data-handling commitments for the commercial platform surface.
- DPA: engine to verify whether a publicly available DPA exists.
- Retention: engine to verify what (if any) customer data is retained operator-side for the commercial platform surface (validator inputs/outputs, evaluation datasets, telemetry).
- Open-source framework data flows: the framework runs in the customer's process and does not necessarily transmit customer data to operator infrastructure; engine to verify whether any telemetry, error reporting, or analytics flows operator-side by default and how to disable.
- LLM-as-judge validators: customer's data flows through external LLM providers (Anthropic, OpenAI, Google) when LLM-as-judge validators are used; engine to assess documentation of this data flow.
- GDPR and US state privacy law compliance posture.

### I — Identity & Control

- Open-source framework: customer-managed entirely; no operator-side identity surface.
- Commercial platform (if available): authentication options, SSO / SAML availability, RBAC granularity, API key management.
- Guardrails Hub: validator publishing identity controls (verified publisher vs anonymous contribution); engine to verify.
- 2FA / MFA enforcement options for commercial platform.

### C — Containment

> The C (Containment) dimension is here adapted to a guardrails-framework context: the open-source framework itself does not execute customer code in a sandbox (it runs as a library in the customer's process); for the commercial cloud platform, sandbox isolation for operator-side validator execution is the relevant evaluation question. Note also the self-referential institutional context: the platform being evaluated provides containment-like services to other LLM applications, but this evaluation assesses the operator's own containment posture, not the validator-effectiveness containment its product provides to customers.

- Open-source framework: process-level isolation is the customer's responsibility (framework runs in customer process). Engine to verify documentation of any operator-recommended deployment isolation patterns.
- Guardrails Hub validators: distributed code executed in customer environment — engine to assess code review, sandboxing recommendations, or supply-chain protections for downloaded validators.
- Commercial cloud platform validator execution: where do operator-side validators run? Sandbox technology, network egress posture, customer data handling. Engine to verify documentation.
- LLM-as-judge data flow containment: when customer data flows through external LLM providers for validation, what controls exist (key handling, prompt logging, output retention)? Engine to verify.
- Tenant isolation in the commercial cloud platform (if multi-tenant).

### T — Transparency

- Trust Center presence: engine to verify (likely absent given operator stage; "silence is data" applies).
- Public DPA availability: engine to verify (likely absent given operator stage).
- Subprocessor list: engine to verify (likely absent given operator stage).
- Vulnerability / responsible disclosure policy: engine to locate at github.com/guardrails-ai/guardrails SECURITY.md or guardrailsai.com.
- Status page: engine to verify presence for commercial cloud platform.
- AI safety / governance framework references: NIST AI RMF, ISO/IEC 42001, EU AI Act mapping; engine to record presence or absence.
- Source code transparency: framework is Apache 2.0 open source — engine to score positively as transparency signal.
- Validator-marketplace transparency: Guardrails Hub validator listings — engine to assess whether validator behavior, dependencies, and update history are documented per validator.
- Operator blog and Changelog presence and cadence.

---

## SPECIAL CONSIDERATIONS

### 1. First AI-safety / guardrails / validator category evaluation under VERDICT framework

This is the first AI-safety / guardrails platform evaluated under VERDICT framework. The C dimension is adapted from generic agent-platform sandbox semantics to a hybrid evaluation: (a) the open-source framework runs in the customer's process and does not have its own sandbox, with containment posture being the customer's responsibility, and (b) the commercial cloud platform validator runtime (where it exists) is evaluated as an operator-side execution surface. Additionally, this evaluation has a self-referential institutional context: the platform being evaluated provides containment-like services to LLM applications, while VERDICT (the evaluating party) provides independent evaluation of AI agent and infrastructure platforms. The two operate in adjacent institutional categories within the AI trust infrastructure space, and this evaluation applies identical criteria to Guardrails AI as to any other platform regardless of category adjacency.

### 2. Early-stage operator footprint affecting compliance-attestation availability

Guardrails AI, Inc. is post-Seed (single $7.5M round, February 2024) with approximately 11 employees as of January 2026. As of pre-evaluation research, Guardrails AI has no publicly documented SOC 2, ISO 27001, HIPAA, or similar major compliance attestations. Per ENGINE.md Absolute Rule #10 ("silence is data"), absent attestations should be scored as zero, with explicit acknowledgment in the relevant dimension subsections that the operator's stage may explain the absence but does not change the scoring. Engine should not apply scoring leniency on the basis of operator stage; the framework rewards documented controls and penalizes absence of documentation uniformly across operator sizes.

### 3. Customer testimonials cited on operator surface require independent verification

The operator's website and investor-affiliated publications cite Robinhood and Masterclass as customers, with Masterclass providing a named attribution quote ("Aman Gupta, engineering lead for AI at Masterclass") in publicly available investor blog content. Engine should attempt to independently verify these customer relationships against customer-side public sources (case studies, joint marketing announcements, customer engineering blog references). Where verifiable, engine should record the customer relationship as documented. Where unverifiable from customer-side sources at evaluation date, engine should record the operator-side claim neutrally with a "verifiable only from operator-side sources at evaluation date" qualifier and assess T-dimension scoring accordingly.

---

## KNOWN FACT CORRECTIONS

None applicable. No Guardrails AI-specific entry exists in `KNOWN_FACTS.md` as of evaluation date.

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
- Include positive findings alongside risks. Guardrails AI's open-source Apache-2.0 distribution, publicly accessible GitHub repository, named operator entity with disclosed founders and investors, and stated commitment to AI safety are positive signals where verified; absent compliance attestations, absent Trust Center, and unverified customer testimonials are documentation gaps to be scored per "silence is data" principle.
- No intent attribution to operator, investors, or angel investors (including Ian Goodfellow, Logan Kilpatrick, Lip-Bu Tan).
- Structural or maintainer context (first AI-safety category evaluation; self-referential containment institutional context; early-stage operator footprint; LLM-provider-agnostic framework design including support for Anthropic Claude) noted neutrally as fact, not as excuse, endorsement, or commentary.
- Behavioral evaluation of validator effectiveness (hallucination detection accuracy, PII recall, prompt-injection block rate) is out of scope for this Layer 0 review; defer to the Future Evaluation Plan with explicit Layer 1+ language.
- No political framing of any operator characteristic; restrict to neutral legal and structural language.

---
# END OF PROMPT

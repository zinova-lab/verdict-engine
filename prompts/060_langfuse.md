# VERDICT Evaluation Prompt — #060 Langfuse

---

## PLATFORM UNDER EVALUATION

**Name:** Langfuse
**Owner:** Langfuse GmbH (Berlin, Germany). Subsidiary of ClickHouse, Inc. (San Francisco, USA) following acquisition announced 2026-01-16. Engineering and corporate registration remain in Berlin; legal entity continuity post-acquisition to be verified by engine against current Terms of Service and Privacy Policy operator naming.
**Category:** AI Agent / LLM Application Observability · Tracing · Prompt Management · Evaluation Platform · Open Core (MIT + commercial EE)
**Primary product surfaces:**
- Langfuse Cloud (multi-tenant SaaS, US / EU / HIPAA data regions, AWS-hosted with ClickHouse OLAP backend)
- Self-hosted OSS (MIT-licensed, Docker Compose / Kubernetes Helm, air-gapped supported)
- Self-hosted Enterprise Edition (commercial license key, unlocks `/ee` modules: SCIM, project-level RBAC, extended audit log retention, advanced data retention policies)
- Server-side SDKs (Python, JS/TS) and integrations (OpenTelemetry, Langchain, OpenAI SDK, LiteLLM, LlamaIndex, Haystack)
**Product URL:** https://langfuse.com/
**GitHub:** https://github.com/langfuse/langfuse
**Documentation:** https://langfuse.com/docs

---

## EVALUATION SCOPE

Evaluate Langfuse under VERDICT Framework v0.3.1 (Layer 0, public documentation only). Score dimensions V, R, D, I, C, T. E excluded from Layer 0. Max: 85 points.

Scoring should reflect the publicly available product posture: the OSS core under MIT license is the primary scored surface, with Cloud and Enterprise Edition policies credited where they are documented in public-facing pages (security center, FAQ, pricing, legal). Features gated behind a commercial license that are documented only in EE-restricted documentation are noted but not credited as universally available.

---

## KNOWN PUBLIC SOURCES

### Official project
- Homepage: https://langfuse.com/
- Documentation: https://langfuse.com/docs
- Security & Compliance Overview: https://langfuse.com/security
- Self-hosting documentation: https://langfuse.com/self-hosting
- Privacy policy: linked from https://langfuse.com/security (Privacy Policy ↗); engine to fetch the canonical URL from the security center
- Terms of service: linked from https://langfuse.com/security (Terms of Service ↗); engine to fetch the canonical URL from the security center
- DPA: https://langfuse.com/security (DPA section)
- Subprocessors list: https://langfuse.com/security (Subprocessors section)
- Compliance documentation: https://langfuse.com/security (SOC 2 Type II, ISO 27001, HIPAA pages)
- Open-source strategy: https://langfuse.com/docs/open-source
- Software dependencies and license policy: https://langfuse.com/security/dependencies
- Responsible disclosure policy: linked from https://langfuse.com/security
- Telemetry documentation: linked from the GitHub README (telemetry docs)

### Package distribution
- npm: https://www.npmjs.com/package/langfuse
- PyPI: https://pypi.org/project/langfuse/
- Docker images: https://github.com/langfuse/langfuse/pkgs/container/langfuse
- GitHub Releases: https://github.com/langfuse/langfuse/releases

### Security and vulnerability disclosure
- GitHub SECURITY.md: https://github.com/langfuse/langfuse/blob/main/SECURITY.md (verify presence)
- GitHub Security Advisories: https://github.com/langfuse/langfuse/security/advisories
- CVE database (NVD) search terms: "Langfuse", "langfuse/langfuse"
- OSV database: https://osv.dev/ (query by ecosystem npm:langfuse and PyPI:langfuse)
- GHSA: https://github.com/advisories?query=langfuse
- CISA KEV: https://www.cisa.gov/known-exploited-vulnerabilities-catalog (query for any Langfuse entry — N/A expected)
- Penetration testing: referenced on https://langfuse.com/security; report or summary public availability to be assessed
- Bug bounty / VDP URL: to be located on https://langfuse.com/security under Responsible Disclosure

### Community signals
- GitHub stars, forks, contributor count: https://github.com/langfuse/langfuse (operator self-claims 25,197 stars on security page; engine to record current observed value)
- Security-tagged issues: https://github.com/langfuse/langfuse/issues?q=label%3Asecurity
- Release cadence: GitHub Releases (operator claims multiple per week)
- SDK install volume: operator self-claims 23.1M+ SDK installs/month, 6M+ Docker pulls (security page) — directional signal only
- Customer disclosures: operator self-claims 19 of Fortune 50 / 63 of Fortune 500 (security page) — directional signal only

### Behavioral model

Langfuse is an LLM application observability platform. The platform ingests trace, observation, score, prompt, and evaluation data from customer applications via SDKs (Python, JS/TS) or OpenTelemetry-compatible exporters. Data flow:

- Customer application emits traces and observations to Langfuse server (via authenticated public ingestion API)
- Server stack: Next.js web application + Node.js worker (asynchronous event processing), backed by Postgres (transactional metadata), ClickHouse (high-performance OLAP for traces / observations / scores), Redis or Valkey (queue and cache), and S3-compatible object storage (raw events, multi-modal inputs, exports)
- Optional external LLM API or gateway dependency for LLM-as-judge evaluations and Playground features

Cloud deployment runs on AWS with ClickHouse Cloud as the OLAP backend, with three data residency regions (US, EU, HIPAA). Self-hosted deployments run identically on customer infrastructure (single-node Docker Compose to multi-node Kubernetes), with air-gapped operation supported (internet access optional). Telemetry to a centralized PostHog instance is enabled by default for self-hosted instances reporting aggregated usage statistics; the operator documents that no traces, prompts, observations, scores, or dataset contents are transmitted, and provides an opt-out mechanism.

The platform does not directly execute customer code, agent actions, or shell commands. Its surface is data ingestion, storage, query, visualization, and evaluation orchestration. Containment scoring should reflect this read/write data plane posture rather than a code-execution posture.

---

## EVALUATION FOCUS AREAS

### V — Verifiability

- Is the operator legal entity (Langfuse GmbH; subsidiary of ClickHouse, Inc.) named consistently across Privacy Policy, Terms of Service, DPA, and Subprocessors list? Does the operator naming reflect the 2026-01-16 acquisition?
- Does the security center disclose the SOC 2 Type II auditor name, ISO 27001 certifying body, HIPAA attestation method, and penetration testing vendor or scope?
- Is the open-core boundary precisely documented? What features sit under MIT, what under EE, and is the `/ee` directory boundary inspectable in the public repository?
- Is the telemetry to PostHog fully enumerated (specific fields collected, destination, opt-out mechanism)?
- Are subprocessors enumerated by name, jurisdiction, and processing purpose?

### R — Resilience

- CVE / GHSA / OSV trailing twelve months count for `langfuse/langfuse`, npm:langfuse, and PyPI:langfuse. Time-to-disclosure pattern.
- CISA KEV: any entry related to Langfuse or its critical dependencies (ClickHouse, Postgres, Redis/Valkey).
- Release cadence: verify operator's multiple-per-week claim against GitHub Releases.
- SECURITY.md presence and quality (disclosure channel, PGP key, response time SLA, scope).
- External penetration test cadence and report or summary public availability.
- Acquisition transition (2026-01-16) impact on release cadence or maintainer continuity if observable in commit history.

### D — Data Conduct

- Does the Privacy Policy explicitly exclude customer trace, prompt, observation, score, or dataset content from being used to train AI models by Langfuse, ClickHouse, Inc., or any subprocessor?
- DPA availability: signing channel (self-serve via dashboard, contract, or both), GDPR Article 28 compliance scope, sub-processing flow-through clauses.
- Data residency: US, EU, HIPAA region documentation, data segregation guarantees, cross-region transfer mechanisms (SCCs / DPF / other lawful bases for international transfers).
- Data retention defaults and customer-configurable retention windows. Data masking and data deletion capabilities (operator self-claim — verify documentation).
- Acquisition impact: whether ClickHouse Inc. is named as a subprocessor or controller post-acquisition, whether new data flows or aggregations have been documented since 2026-01-16.

### I — Identity & Control

- Authentication options on Cloud and self-hosted core: email/password, social SSO (Google, GitHub, etc.).
- SAML SSO and SCIM provisioning: gated to EE per operator's documentation; verify that the gating is clearly disclosed.
- Project-level RBAC: gated to EE per Discussion #10745.
- API key creation, scoping, rotation, and revocation documentation.
- Audit log retention defaults and EE extension.
- 2FA / MFA requirements and enforcement options.

### C — Containment

- Self-hosted air-gapped operation: documented configuration, list of optional external dependencies (LLM gateway for LLM-as-judge, telemetry endpoint), and explicit instructions to disable each.
- Network architecture: ingress and egress paths between Langfuse server, worker, Postgres, ClickHouse, Redis/Valkey, and S3-compatible storage; whether deployment within customer VPC is documented as a supported topology.
- Telemetry to PostHog: default-on vs default-off, opt-out path, and what fields are transmitted.
- Cloud platform: AWS region pinning, ClickHouse Cloud region alignment with Langfuse Cloud regions, customer data isolation between tenants.
- The platform does not execute customer code, so traditional sandbox containment criteria (microVM, gVisor, network egress allow-list at code-execution boundary) are not applicable. Score the data-plane containment posture.

### T — Transparency

- SOC 2 Type II report request flow: NDA-gated, public summary, or full report; cadence (annual claim).
- ISO 27001 certificate: public availability, certifying body, scope, validity dates.
- HIPAA: BAA availability mechanism (entitled plan), region scope.
- Penetration test: report public, summary public, or existence-only disclosure.
- Subprocessors list: completeness, last-updated date, change notification policy.
- Acquisition disclosure: whether the 2026-01-16 ClickHouse acquisition is reflected on operator-controlled pages (security center, legal pages, About / company page, blog).
- Incident and breach notification policy: public commitment, notification SLA, scope.
- Vulnerability management policy: public document, SLA tiers by severity.
- Whistleblowing channel: presence and access mechanism.

---

## SPECIAL CONSIDERATIONS

### 1. Acquisition by ClickHouse, Inc. (2026-01-16)

ClickHouse, Inc. (San Francisco; CEO Aaron Katz; total funding $1.05B across 7 rounds; Series D $400M closed 2026-01-16 at a $15B valuation) acquired Langfuse GmbH on the same date the Series D was announced (SiliconANGLE, PitchBook). Langfuse continues to operate under the Langfuse brand with the Berlin engineering presence; the corporate-entity status of Langfuse GmbH and the subprocessor / controller relationship between Langfuse GmbH and ClickHouse, Inc. post-acquisition are matters for the engine to verify against current Terms of Service, Privacy Policy, DPA, and Subprocessors list. The technical relationship between the two products (Langfuse stores telemetry in ClickHouse) predated the acquisition and is documented in pre-acquisition technical materials.

### 2. Open-core licensing model with `/ee` boundary

Langfuse follows an open-core model. The repository LICENSE file states that all content outside the `ee/`, `web/src/ee/`, and `worker/src/ee/` directories is licensed under MIT (Expat); content within those directories is licensed under the separate `ee/LICENSE` and gated by an Enterprise license key check at runtime. Features documented as EE-gated include SCIM provisioning, project-level RBAC, extended audit-log retention, and advanced data retention policies. Scoring should reflect the publicly available MIT-licensed core posture; EE features should be noted in the report but not credited as universally available without a paid license. Operator's open-core strategy page (https://langfuse.com/docs/open-source) is the primary reference for the boundary.

### 3. Indirect commercial relationship surface with Anthropic

Public investor records (Tracxn, PitchBook) show no equity overlap between Anthropic / Anthropic Ventures and Langfuse (investors: Y Combinator, Lightspeed Venture Partners, La Famiglia, $4.5M Seed) or between Anthropic / Anthropic Ventures and ClickHouse, Inc. (36 institutional investors including Dragoneer, Khosla Ventures, Index Ventures, Lightspeed, GIC, T. Rowe Price, WCM Investment Management; Anthropic Ventures not present). Anthropic is, however, publicly disclosed as a major customer of ClickHouse, Inc. (ClickHouse press releases dated 2025-05-29 and 2025-10-07; TipRanks 2026-02-20 reporting on Anthropic's air-gapped ClickHouse deployment supporting Claude Code observability). This creates an indirect commercial-relationship surface at the parent-company level. Engine should disclose this surface neutrally in the Contextual Analysis section without intent attribution; no direct equity, commercial, or contractual relationship between Langfuse (the platform under evaluation) and Anthropic appears in public sources.

---

## KNOWN FACT CORRECTIONS

None applicable. No Langfuse-specific entry exists in `KNOWN_FACTS.md` as of evaluation date.

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
- Include positive findings alongside risks. Langfuse's documented compliance posture (annual SOC 2 Type II, ISO 27001, GDPR + DPA, HIPAA, external penetration testing, air-gapped self-host support) should be reflected where verified, alongside any documentation gaps surfaced during the evaluation.
- No intent attribution to operator, parent company, or investors.
- Structural or maintainer context (acquisition by ClickHouse, Inc.; open-core boundary; indirect Anthropic commercial-relationship surface) noted neutrally as fact, not as excuse or commentary.

---
# END OF PROMPT

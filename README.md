# VERDICT Evaluation Engine

VERDICT is an independent trust evaluation index for AI agent platforms, operated by ZinovaCreation (Japan). This repository contains the evaluation engine used to produce the scores published at getverdict.fyi.

VERDICT publishes its evaluation engine for full transparency. Every score at getverdict.fyi traces back to the criteria defined here. The framework, the quality review checklist, and the prompt templates that generate each evaluation are all public and versioned.

## Position

VERDICT is a witness, not a judge. Evaluations record what public data shows. Interpretation belongs to the reader.

## Why this exists

AI agent platforms now execute autonomous actions on behalf of their users — handling credentials, writing code, invoking APIs, moving data across systems. Certification frameworks such as SOC 2 and ISO 27001 attest to organizational process; they do not attest to agent behavior, containment design, or supply chain resilience. The March 2026 LiteLLM supply chain compromise (Trivy → Checkmarx KICS → LiteLLM, disclosed 2026.03.24) demonstrated this gap in public: certified platforms were reached through their dependency chain.

VERDICT evaluates the behavioral, structural, and incident-resilience dimensions that certifications do not address.

## Independence

Independence is defined structurally, not declaratively:

- Zero revenue from evaluated vendors, in any form, at any time
- No pre-publication sharing of evaluations with evaluated parties
- Scoring based solely on publicly available sources: CVE databases, the CISA Known Exploited Vulnerabilities catalog, NVD, official terms of service and privacy policies, and GitHub security advisories

These are the preconditions for the editorial authority VERDICT claims.

## Contents

- `ENGINE.md` — Framework v0.3.1. Seven dimensions (V/E/R/D/I/C/T), scoring criteria, eight-step evaluation sequence, output format, absolute principles.
- `QA.md` — Three-category quality review covering factual accuracy, legal risk, and report quality. Blocklists for inflammatory language and AI writing tells. Severity classification (Critical / Warning / Note).
- `KNOWN_FACTS.md` — Documented fact corrections the engine must apply during every evaluation. Entries are added as errors are identified and resolved.
- `prompts/_template.md` — Standard template for platform-specific evaluation prompts.
- `prompts/057_aider.md` — Reference prompt implementing the template.

This repository does not contain individual evaluation reports. Those are published at getverdict.fyi.

## Usage

The engine is designed to run in any LLM chat interface with web search capability.

1. Load `ENGINE.md`, `QA.md`, and `KNOWN_FACTS.md` into the session as operating context.
2. Select a platform-specific prompt from `prompts/`, or create a new one using `_template.md`.
3. Submit the prompt. The engine produces a full English report and a Japanese summary, passing through the mandatory quality review before delivery.

Raw URLs for direct loading:` ``` `
https://raw.githubusercontent.com/GithubsampleZIC/verdict-engine/main/ENGINE.md
https://raw.githubusercontent.com/GithubsampleZIC/verdict-engine/main/QA.md
https://raw.githubusercontent.com/GithubsampleZIC/verdict-engine/main/KNOWN_FACTS.md
` ``` `

## Versioning

The engine is versioned. Every evaluation published at getverdict.fyi is bound to the engine version under which it was conducted. The current framework is v0.3.1. Material changes to scoring criteria trigger a minor version increment and, where warranted, re-evaluation of affected platforms. Historical evaluations remain valid under their original engine version.

## Governance

This repository documents the engine that VERDICT operates. It is a transparency publication, not a community project. External pull requests and issues are not accepted. The engine is maintained solely by VERDICT / ZinovaCreation, which preserves single-source methodology governance as a condition of editorial independence. Factual corrections to published evaluations should be sent to vendor@getverdict.fyi with supporting documentation.

## Third-party use

This engine is licensed under CC-BY 4.0 and may be forked, adapted, or referenced. Forks and derivatives are independent of VERDICT. Evaluations produced by forked or derivative versions are not VERDICT evaluations and should not be represented as such.

The names "VERDICT" and "getverdict.fyi," and the evaluation index published at getverdict.fyi, are operated solely by ZinovaCreation.

## Standards referenced

- MIT AI Agent Index (2025)
- NIST AI Risk Management Framework 1.0
- OWASP Top 10 for LLM Applications (2025)
- EU AI Act (effective August 2024)
- CWE / CVSS v3.1 (NVD)
- CISA Known Exploited Vulnerabilities Catalog

## Disclaimer

This engine is provided as-is under the terms of CC-BY 4.0. VERDICT makes no warranty that the methodology identifies all security, privacy, or compliance risks of any platform. VERDICT evaluations are informational and are not a substitute for independent due diligence in procurement, compliance, investment, or legal decisions.

## License

Creative Commons Attribution 4.0 International (CC-BY 4.0). Full text in `LICENSE`.

## Maintainer

Tatsuya Suzuki — ZinovaCreation, Japan.
Index: getverdict.fyi
Contact: hello@getverdict.fyi

## Related

The VERDICT Index at getverdict.fyi currently covers 55 AI agent platforms scored under this framework, with individual evaluation reports, category comparisons, and the Q1 2026 state-of-AI-agent-security report.

## Framework version

VERDICT v0.3.1
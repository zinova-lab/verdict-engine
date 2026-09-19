# VERDICT Population Definition v1

**Version date:** 2026-09-19 (single-day retrieval of every source below)
**Applies to:** selection of evaluations #070 onward, and the coverage figures VERDICT publishes
**Framework:** VERDICT v0.3.1 · Proposed location: `verdict-engine/docs/selection/population_definition_v1.md` · Data: `verdict-platforms/data/census/2026-09/`

VERDICT evaluates AI agent platforms against public data. Until this document, the question "why these 69 platforms?" had no written answer: the first 69 were selected one by one during 2025–2026, before any criteria existed. This document fixes a population — the set of platforms VERDICT measures itself against — using third-party lists and mechanical conditions only. Inclusion in the population is not an assessment of any platform. It is a sampling frame, so that VERDICT can state what fraction of the field it has covered and what it has not.

## 1. Adopted lists

Every source was retrieved on 2026-09-19. SHA-256 digests (first 16 hex characters here; full digests in `sha256sums.txt`) identify the exact file used.

| List | Publisher | Version | Entries used | Retrieved | SHA-256 (prefix) |
|---|---|---|---|---|---|
| AI Agent Index | MIT (academic project, CC-BY 4.0) | 2025 edition | 30 | 2026-09-19 | `488dbef69b54e20f` |
| AI 50 | Forbes, with Sequoia Capital and Meritech Capital | 2026 (published 2026-04-16) | 50 | 2026-09-19 | `0a1f59f1df087dd7` |
| Top 100 Gen AI Consumer Apps | a16z | 6th edition (2026-03-10) | 5 (see below) | 2026-09-19 | `f2123dde4e40f5dc` |
| GitHub topic snapshot | GitHub (primary data, no curator) | 2026-09-19 | 832 repositories | 2026-09-19 | in `census_v1_2026-09-19.csv` (`cdd442acdfff037a`) |

The a16z list is image-based and covers consumer apps generally; VERDICT uses only the products the a16z report text itself names as agentic or vibe-coding products (Replit, Lovable, Cursor, Manus, Genspark). The MIT index data is redistributed with attribution under CC-BY 4.0. Forbes and a16z page content is archived locally with its digest and is not redistributed.

## 2. Why each list is treated as third-party

The same three tests apply to every list: (a) a place on the list cannot be purchased and sponsorship leaves no mark on how entries are presented; (b) the list is publicly readable in full at no charge; (c) the list carries a version or date.

- **MIT AI Agent Index** — academic selection with no fee or sponsorship; published under an open license; annual edition.
- **Forbes AI 50** — no fee to apply or to be listed; selection by independent judging panels; the 2026 package names Mayfield as sponsoring partner, which is a relationship with the publisher, not with listed companies; private companies only; annual.
- **a16z Top 100** — ranked by third-party measurement (SimilarWeb web traffic, Sensor Tower mobile usage); publicly posted; dated semiannual editions. a16z is an investor in some listed companies and marks them as such.
- **GitHub topic snapshot** — primary data with no editorial layer; reproducible from the query string and the retrieval date.

Products or services a publisher offers to listed companies after publication are unrelated to VERDICT's use of the list. VERDICT has no relationship with any of the publishers.

## 3. GitHub conditions

A repository enters the population when all of the following hold on the retrieval date:

1. It carries at least one of three GitHub topics: `ai-agents`, `llm-agents`, `agents`.
2. It has 1,000 or more stars.
3. It has had a push within the preceding 12 months (on 2026-09-19: pushed on or after 2025-09-19).

Because the `agents` topic is also used outside AI, a relevance filter is applied: the repository must carry an AI-related topic (such as `ai`, `llm`, `gpt`, `agentic`, `langchain`, `rag`, `generative-ai`, `mcp`) or its description must contain an AI term (ai, llm, gpt, agentic, language model, openai, claude, gemini, autonomous, copilot, rag). On 2026-09-19 the three queries returned 858 repositories; 832 passed the filter.

The 1,000-star line is a customary attention threshold. It was set before VERDICT counted how many of its own evaluations fall above or below it, and it does not change with that count.

## 4. Known limitations

**Reliance on self-declared topics.** GitHub topics are applied by repository owners. Well-known agent projects without one of the three topics are outside the population regardless of their size. A cross-check against a community-maintained list (2026-09-13) found 22 live repositories above 500 stars in that situation, five of them already evaluated by VERDICT.

**Repository types.** Roughly one third of the eligible repositories (267 of 810 unevaluated on 2026-09-19) are prompt or skill collections, curated lists, guides, courses, or templates rather than software platforms. They stay in the population because the denominator is defined by third-party data and mechanical conditions only; VERDICT does not subtract them.

**Closed-source components.** Commercial guardrail, observability, and red-teaming products without a public repository are reachable only through the three lists, which rarely include them. This layer is largely outside the population.

**OWASP landscape not adopted.** The OWASP GenAI Security Project's Agentic AI solutions landscape was considered as a source for that layer. Its directory displays sponsor badges on individual entries, which does not meet the second half of test (a). It will be re-examined at the next annual update.

**The first 69 evaluations.** 34 of VERDICT's 69 current evaluations fall inside this population; 35 fall outside. Of the 35, 17 are hosted products absent from all three lists, 16 are open-source repositories that lack the three topics on their main repository, and 2 are repositories with no push in the 12-month window. These 35 were selected before the criteria existed. They remain published and on their review schedule; the population governs what is selected next and what coverage is claimed, not what was already evaluated. Per-entry status is included in the census dataset.

**Matching.** Lists name companies; VERDICT evaluates products. Seven Forbes entries match VERDICT evaluations, three of them at company level (Cohere, Mistral AI, OpenAI). The headline figure below uses strict product-level matching only.

## 5. Coverage figures

**Headline: 6 of the 30 systems in the MIT AI Agent Index 2025 have a published VERDICT evaluation (20.0%).** These are Agentforce, Browser Use, Manus, n8n, watsonx Orchestrate, and Zapier. Microsoft Copilot Agents is counted as unevaluated because VERDICT's evaluation covers Copilot Studio, a different product.

**Auxiliary: overall population coverage is approximately 3.8%** — 34 evaluated entries against a population of roughly 895 (30 + 50 + 5 list entries and 832 repositories, de-duplicated by name). The figure is low because the population is deliberately wide; it is published so that readers can see the size of the field, not narrowed to improve the ratio.

## 6. Queue policy

VERDICT commits to evaluating every system in the MIT AI Agent Index 2025. Public vulnerability disclosures (CVE, GHSA) concerning any platform take priority over this queue at any time.

Tooling and component repositories (coding agents, browser automation, frameworks, runtimes, observability, memory, guardrails) form a second queue ordered by stars, descending, with no completion commitment. A vocabulary screen that recognises prompt collections, skill packs, guides, and similar repository types is used to order that queue. It affects ordering only; it does not change the population or any coverage figure.

## 7. Updates

The population is redrawn annually from the then-current editions of the same lists and a fresh GitHub snapshot, with a new version date. Between annual versions, quarterly deltas record additions and removals without changing the denominator used for the year's coverage figures. Each version keeps its dataset and digests.

## 8. If a list disappears

If a publisher stops maintaining a list or changes it so that tests (a)–(c) no longer hold, the most recent adopted edition is frozen as part of the population until the next annual update, at which point a replacement source meeting the same tests is adopted and the change is recorded. Coverage figures for past versions are not restated.

---

*Population Definition v1 · VERDICT · ZinovaCreation · 2026-09-19. Dataset: `census_v1_2026-09-19.csv`, `sha256sums.txt`, `mit_2025_entries.json` (CC-BY 4.0, MIT AI Agent Index).*

# VERDICT — category → stack_layer map v1

**Status:** operational document (no schema change). Drafted by Operations under SelectionFrame-Census-001 (A-1 ratified 2026-09-12). Review cadence: re-issue with each annual population-map update; versioned.
**Labels:** `stack_layer` ∈ {`agent`, `tooling`, `component`} (SelectionFrame-Census-001 clause (d); replaces the internal Tier 1/2/3 shorthand in Engine-facing and public documents).
**Rule applied:** Strategy §3 boundaries (SelectionFrame-001) + supplementary rule A-1 (primary operator non-developer and deployed agent acts autonomously → `agent`; developer-facing API/runtime/OSS builder → `component`). Unit of classification = the name VERDICT evaluated (e.g., Zapier, not Zapier Agents).
**Counts:** agent 13 / tooling 20 / component 36 = 69 (verdict-platforms `data/platforms.json`, fetched 2026-09-12).

| slug | name | category (as recorded) | stack_layer | note |
|---|---|---|---|---|
| activepieces | Activepieces | Workflow Automation · Open Source (MIT) | tooling | boundary → tooling (A) |
| ag2 | AG2 | Multi-Agent Framework · OSS (Apache 2.0) | component |  |
| agentforce | Salesforce Agentforce | CRM-Native Agent Builder · Enterprise SaaS | agent |  |
| aider | aider | AI Coding Agent | tooling |  |
| amazon-q-business | Amazon Q Business | Enterprise AI Assistant · Cloud SaaS (AWS) | agent |  |
| arize-ai | Arize AI | LLM Observability | component |  |
| autogen | AutoGen | Multi-Agent Framework · Open Source (MIT) | component |  |
| autogpt | AutoGPT | Autonomous AI Agent · Source-Available | agent |  |
| babyagi | BabyAGI | Experimental Autonomous Agent · OSS (MIT) | component |  |
| bedrock | AWS Bedrock Agents | Managed Agent Platform · Enterprise SaaS | component |  |
| bolt-new | Bolt.new | AI App Builder · OSS Core | tooling |  |
| botpress | Botpress | Chatbot / Agent Builder · Open Source (MIT integrations) | agent | boundary → agent (A-1) |
| browser-use | Browser Use | Browser Agent Library · Open Source (MIT) | tooling |  |
| browserbase | Browserbase | Browser Infrastructure · Cloud (Proprietary) | component | boundary → component (browser runtime infra) |
| camel-ai | CAMEL-AI | Multi-Agent Research · OSS (Apache 2.0) | component |  |
| cline | Cline | AI Coding Agent | tooling |  |
| cohere | Cohere | Foundation Model API | component |  |
| composio | Composio | AI Agent Tool Integration · OSS SDK + Cloud | component |  |
| copilot-studio | Microsoft Copilot Studio | No-Code Agent Builder · Enterprise SaaS | agent | boundary → agent (A-1, unit = evaluated name) |
| coze | Coze | AI Agent Platform · Closed Source | agent |  |
| crewai | CrewAI | Multi-Agent Orchestration · Open Source | component |  |
| cursor | Cursor | AI Coding IDE · Proprietary | tooling |  |
| devin | Devin | AI Coding Agent · Cloud SaaS | tooling |  |
| dify | Dify | LLM Application Builder · Open Source | component | developer-facing builder → component |
| dust | Dust | Enterprise AI Assistant · OSS + Cloud SaaS | agent |  |
| e2b | E2B | AI Agent Code Execution Sandbox | component |  |
| flowise | Flowise | LLM Agent Builder · Open Source | component | developer-facing builder → component |
| gemini-code-assist | Gemini Code Assist | AI Coding Agent | tooling |  |
| github-copilot | GitHub Copilot | AI Coding Agent · Microsoft | tooling |  |
| guardrails-ai | Guardrails AI | AI Safety | component |  |
| haystack | Haystack | AI Application Framework · Open Source (Apache 2.0) | component |  |
| langchain | LangChain | LLM Agent Framework · Open Source (MIT core) | component |  |
| langflow | Langflow | Visual AI Agent Builder · Open Source | component | developer-facing builder → component; CVE lane unaffected |
| langfuse | Langfuse | AI / LLM Application Observability | component |  |
| langgraph | LangGraph | Agent Orchestration · OSS (MIT) | component |  |
| langroid | Langroid | Multi-Agent LLM Framework · OSS (MIT) | component |  |
| langsmith | LangSmith | LLM Observability | component |  |
| letta | Letta | Stateful AI Agent Framework · Open Source (Apache 2.0) | component |  |
| llamaindex | LlamaIndex | RAG / Data Framework · Open Source (MIT core) | component |  |
| lovable | Lovable | AI App Builder · Cloud SaaS | tooling |  |
| make | Make.com | Workflow Automation · Cloud SaaS | tooling | boundary → tooling (A) |
| manus-ai | Manus AI | Autonomous Browser Agent · Cloud | agent |  |
| metagpt | MetaGPT | Multi-Agent Dev Framework · OSS (MIT) | component |  |
| mistral-la-plateforme | Mistral La Plateforme | AI Agent Platform | component |  |
| n8n | n8n | Workflow Automation · Open Source | tooling | boundary → tooling (A) |
| nemo-guardrails | NeMo Guardrails | AI Safety | component |  |
| openai | OpenAI Assistants API | LLM Agent API · Managed SaaS | component |  |
| openhands | OpenHands | AI Coding Agent · OSS (MIT) | tooling |  |
| phidata | Phidata (Agno) | Multi-Agent Framework · OSS (MPL 2.0) | component |  |
| pinecone | Pinecone | Vector Database | component |  |
| pipedream | Pipedream | Workflow Automation · API Integration | tooling | boundary → tooling (A) |
| relevance-ai | Relevance AI | AI Agent Platform · Cloud SaaS | agent |  |
| replit | Replit | AI Coding Agent / Cloud IDE | tooling |  |
| rivet | Rivet | Visual AI Agent IDE · OSS (MIT) | component |  |
| runner-h | Runner H | Browser Agent · Proprietary (EU) | agent |  |
| semantic-kernel | Semantic Kernel | AI Orchestration SDK · Open Source (MIT) | component |  |
| skyvern | Skyvern | Browser Agent · AGPL-3.0 + Cloud | tooling |  |
| stagehand | Stagehand | Browser Agent SDK · Open Source (MIT) | tooling |  |
| superagent | Superagent | AI Agent Security Platform · OSS + Cloud | component |  |
| superagi | SuperAGI | Agent Management · OSS (MIT) | component |  |
| v0 | v0 | AI App Builder · Cloud SaaS | tooling |  |
| vertex-ai | Vertex AI Agent Builder | No-Code Agent Builder · Enterprise SaaS | agent | boundary → agent (A-1) |
| voiceflow | Voiceflow | Conversational AI · Cloud SaaS | agent | boundary → agent (A-1) |
| watsonx-orchestrate | IBM watsonx Orchestrate | Enterprise AI Agent Platform · Cloud SaaS + On-Prem | agent |  |
| weaviate | Weaviate | Vector Database | component |  |
| windsurf | Windsurf | AI Coding IDE · VS Code Fork | tooling |  |
| wordware | Wordware | AI Agent IDE · Cloud SaaS | component |  |
| zapier | Zapier | Workflow Automation · Cloud SaaS | tooling | boundary → tooling (A: unit = Zapier, not Zapier Agents) |
| zep | Zep | Agent Memory Layer | component |  |

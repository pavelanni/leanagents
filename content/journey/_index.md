---
title: "The journey"
description: "How AI agents evolved from magic tricks to production infrastructure."
showDate: false
showReadingTime: true
showAuthor: false
showBreadcrumbs: true
showTableOfContents: true
---

{{< figure src="journey-hero.png" alt="The evolution of AI agents: from individual magic to framework complexity to lean runtimes" class="mx-auto max-w-3xl" nozoom=true >}}

{{< lead >}}
The conversation about AI agents has shifted three times in three
years --- from "what can they do?" to "how do we orchestrate them?"
to "how do we run them in production?"
{{< /lead >}}

## Phase 1: Magic (2023--2024)

Early adopters discovered that LLMs with tool access could do
remarkable things. Cursor, GitHub Copilot, ChatGPT plugins ---
individual developers experienced what felt like a productivity
superpower. One agent, one engineer, full machine access.

The conversation was about **capability**: what CAN agents do?

## Phase 2: Frameworks (2024--2025)

Teams started building with LangChain, CrewAI, AutoGen, and similar
frameworks. The focus shifted to multi-agent orchestration, RAG
pipelines, and complex workflows.

But each agent is a full Python or Node.js runtime --- pip install,
shell access, network reach. The agent can install packages, download
code, curl arbitrary endpoints. Fine for five agents in a lab.
Terrifying for 500 in production.

## Phase 3: Runtime (2025--2026)

The question shifts from "what can an agent do?" to "what SHOULD an
agent do?" This is the crossing-the-chasm moment.

Business users don't need agents that write code, install packages,
or browse the web. They need agents that summarize reports, review
documents, and answer domain questions --- with guardrails that an
admin controls.

## The problem with today's agents

Today's agentic frameworks are built for and by software engineers.
They assume the user is technical, full filesystem and network access
is acceptable, the agent should be maximally capable, and one or a
few agents serve the whole team.

This doesn't scale. When you want to deploy 100 or 1,000 agents
across an organization --- each serving different teams, different
roles, different compliance requirements --- you need a fundamentally
different approach.

**The attack surface problem.** A typical Python-based agent runtime
ships with curl, pip, a shell, and a full standard library. An
adversarial prompt can instruct the agent to install a package,
download a script, or exfiltrate data via HTTP. Guardrails are
prompt-level (easy to bypass), not infrastructure-level (hard to
bypass).

**The resource problem.** A Python or TypeScript-based agent pod on
Kubernetes consumes 200--500 MiB of memory. At that footprint,
running 100 agents costs 50 GiB of cluster memory. Running 1,000 is
impractical.

## By the numbers

| Metric | Traditional frameworks | Lean agents |
| --- | --- | --- |
| Pod memory | ~200--300 MiB | ~10 MiB |
| Agents per 50 GiB | ~100 | ~5,000 |
| Runtime deps | Python, pip, OS packages | None (static binary) |
| Startup time | Seconds | Milliseconds |
| Attack surface | Shell, network, filesystem | Configured tools only |
| Skill delivery | pip install, git clone | Signed OCI images |

## The key insight

> We're moving from agents-for-engineers to agents-for-everyone. That
> requires treating the agent runtime like infrastructure, not an
> application. Small, constrained, auditable, deployable at scale.

The agents we use today --- Claude Code, Cursor, Goose --- are
powerful precisely because they have full access to the developer's
machine. That power is the wrong model for business users. A document
summarization agent for the legal team should not be able to install
Python packages. An HR policy reviewer should not have shell access.

Lean agents invert the control model: instead of a powerful agent
that you try to constrain with prompts, you start with a minimal
agent and add only the capabilities it needs --- as auditable, signed
skill images.

---

{{< button href="/manifesto/" >}}
Read the manifesto
{{< /button >}}

{{< button href="/projects/" >}}
View projects
{{< /button >}}

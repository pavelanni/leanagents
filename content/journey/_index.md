---
title: "The journey"
description: "How AI agents evolved from personal tools to production infrastructure."
showDate: false
showReadingTime: true
showAuthor: false
showBreadcrumbs: true
showTableOfContents: true
---

{{< figure src="journey-hero.png" alt="The evolution of AI agents: from individual exploration to framework orchestration to production runtimes" class="mx-auto max-w-3xl" nozoom=true >}}

{{< lead >}}
AI agents have gone through three distinct phases in three years.
Each phase solved one problem and revealed the next.
{{< /lead >}}

## Phase 1: Discovery (2023--2024)

Developers discovered that LLMs with tool access could do remarkable
things. Cursor, GitHub Copilot, ChatGPT plugins --- individual
engineers saw dramatic productivity gains. One agent, one developer,
full machine access.

These **developer agents** are powerful precisely because they have
unrestricted access to the developer's environment. They can read
any file, run any command, install any package. That trust model
works because the developer is both the operator and the user ---
the agent acts on their behalf, on their machine.

The focus was on **capability** --- exploring what agents could do.

## Phase 2: Orchestration (2024--2025)

Teams started building with LangChain, CrewAI, AutoGen, and similar
frameworks. The focus shifted to **multi-agent orchestration**, RAG
pipelines, and complex workflows.

These frameworks extended the developer agent model to team
settings. Each agent is still a full Python or Node.js runtime ---
`pip install`, shell access, network reach. This works well for
**research, prototyping, and small-scale deployments** where a
technical team manages the agents directly.

## Phase 3: Production (2025--2026)

As organizations move from experimentation to production, the
requirements change. The question is no longer what agents can do,
but **how to deploy them safely at scale**.

Think of it like the difference between your personal computer and
a server processing banking transactions. Your laptop runs whatever
you want --- you trust yourself. A production server is **locked
down, purpose-built, and auditable**. Both are computers. Both are
necessary. They serve different purposes.

The same distinction applies to agents.

## Two kinds of agents

Developer agents and production agents are not competitors --- they
are complements. Developer agents are where ideas begin: exploring
capabilities, prototyping workflows, pushing boundaries. Production
agents are where those ideas get deployed: constrained, auditable,
running at scale.

| | Developer agents | Production agents |
| --- | --- | --- |
| **Purpose** | Exploration, research, development | Enterprise deployment at scale |
| **Trust model** | Developer trusts themselves | Admin controls capabilities |
| **Access** | Full machine access | Configured tools only |
| **Runtime** | Python, Node.js, full standard library | Compiled, minimal, static binary |
| **Footprint** | ~200--300 MiB | ~10 MiB |
| **Density** | ~100 per 50 GiB | ~5,000 per 50 GiB |
| **Skill delivery** | `pip install`, `git clone` | Signed OCI images |
| **Examples** | Claude Code, Cursor, Goose | DocsClaw, ZeroClaw, OpenFang |

Developer agents don't disappear when production agents arrive.
They remain essential tools for the engineers who design, build,
and test the workflows that production agents execute. A developer
uses Claude Code to prototype an agent workflow, then deploys a
lean agent to run that workflow in production --- just as a
developer writes code on a laptop, then deploys it to a server.

## Why production agents must be different

A document summarization agent for the legal team should not be able
to install Python packages. An HR policy reviewer should not have
shell access. When you deploy 100 or 1,000 agents across an
organization --- each serving different teams, different roles,
different compliance requirements --- you need a runtime built for
that context.

**Minimal footprint.** At 10 MiB per agent, you can run 5,000
specialized agents on the same cluster resources that hold 100
developer agents. That changes the economics from "one big agent
for everyone" to "the right agent for each team."

**Constrained by design.** A compiled agent runtime has no shell,
no package manager, no ability to expand its own capabilities. The
attack surface is what the administrator configures --- not what an
adversarial prompt can discover.

**Infrastructure-grade delivery.** Skills are packaged, versioned,
and signed --- distributed through the same supply chain enterprises
already trust for container images.

---

<div class="cta-row">

{{< button href="/manifesto/" >}}
Read the manifesto
{{< /button >}}

{{< button href="/projects/" >}}
View projects
{{< /button >}}

</div>

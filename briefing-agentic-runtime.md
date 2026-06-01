# Briefing: The Next Step in the Agentic Journey

## The arc

### Phase 1: Magic (2023-2024)

Early adopters discovered that LLMs with tool access could
autocomplete entire features and generate working prototypes
from a prompt. Cursor and GitHub Copilot gave individual
developers what felt like a productivity superpower. One agent,
one engineer, full machine access. People asked: what CAN
agents do?

### Phase 2: Frameworks (2024-2025)

Teams started building with LangChain and CrewAI. The focus
shifted to multi-agent orchestration, RAG pipelines, and
complex workflows. But each agent runs a full Python or Node.js
runtime with pip, shell access, and network reach. The agent
can install packages, download code, and curl arbitrary
endpoints. That works for 5 agents in a lab. It breaks at 500
in production.

### Phase 3: Runtime (2025-2026)

Engineers started asking a different question: what SHOULD an
agent do? This is the crossing-the-chasm moment. Business users
don't need agents that write code or install packages. They
need agents that summarize reports and review documents, with
guardrails that an admin controls.

## The problem with today's agents

Today's agentic frameworks are built for and by software
engineers. They assume:

- The user is technical and can evaluate agent output
- Full filesystem and network access is acceptable
- The agent should be maximally capable
- One or a few agents serve the whole team

This breaks at scale. Deploying 100 or 1,000 agents across an
organization, each serving different teams and compliance
requirements, demands a different approach.

**The attack surface problem:** A typical Python-based agent
runtime ships with curl, pip, a shell, and a full standard
library. An adversarial prompt can instruct the agent to
`pip install` a package, download a script, or exfiltrate data
via HTTP. Guardrails are prompt-level (easy to bypass), not
infrastructure-level (hard to bypass).

**The resource problem:** A Python or TypeScript agent pod on
OpenShift consumes 200-500 MiB of memory. Running 100 agents
costs 50 GiB of cluster memory. Running 1,000 is impractical.

## What DocsClaw does differently

DocsClaw is a lightweight agentic runtime built in Go for
Kubernetes and OpenShift. It treats the agent problem as an
infrastructure challenge.

### Minimal footprint

- ~10 MiB per pod (vs. ~200-300 MiB for comparable Python
  runtimes)
- Single static binary, no runtime dependencies
- Starts in milliseconds
- 50x more agents on the same cluster resources

### Constrained by design

- No shell access for the agent (tools are compiled in, not
  installed)
- No package manager. The agent can't expand its own
  capabilities.
- No curl or wget. Network access is limited to configured
  tools.
- Agent personality (system prompt, skills, tool allowlist)
  defined in a Kubernetes ConfigMap. The admin controls what the
  agent can do.

### Enterprise trust model for skills

Skills are delivered as OCI images via our companion project
[skillimage.dev](https://skillimage.dev):

- Signed with sigstore for supply chain verification
- Versioned and immutable. You know what capabilities each
  agent has.
- Mounted as Kubernetes image volumes, no download at runtime
- Same packaging and distribution model that enterprises
  already use for container images

### Standard protocols

- **A2A** (Agent-to-Agent) protocol for agent orchestration
- **OpenAI-compatible API** for connecting existing chat UIs
  (Open WebUI, LibreChat)
- Users connect with their preferred client; the agent
  intelligence lives on the server

## Agents for everyone, not just engineers

The agents we use today (Claude Code and Cursor) are powerful
because they have full access to the developer's machine. That
power is the wrong model for business users. A document
summarization agent for the legal team should not be able to
install Python packages. An HR policy reviewer should not have
shell access.

DocsClaw starts with a minimal agent and adds only the
capabilities it needs, as auditable, signed skill images.
You treat the agent runtime like infrastructure: small,
constrained, auditable, deployable at scale on OpenShift.

## By the numbers

| Metric            | Python frameworks          | DocsClaw              |
| ----------------- | -------------------------- | --------------------- |
| Pod memory        | ~200-300 MiB               | ~10 MiB               |
| Agents per 50 GiB | ~100                       | ~5,000                |
| Runtime deps      | Python, pip, OS packages   | None (static binary)  |
| Startup time      | Seconds                    | Milliseconds          |
| Attack surface    | Shell, network, filesystem | Configured tools only |
| Skill delivery    | pip install, git clone     | Signed OCI images     |

## Talking points for the interview

**The chasm.** Agents today are built for engineers. Bringing
agents to every team in the enterprise requires a runtime as
manageable and auditable as a container. DocsClaw is that
container.

**Scale.** At 10 MiB per agent, you run 5,000 specialized
agents on the same cluster that holds 100 Python-based agents.
The economics shift from "one big agent for everyone" to "the
right agent for each team."

**Security.** The agent runtime has no curl, no Python, no
package manager, no shell. The attack surface is what the admin
configures in a ConfigMap.

**Ecosystem.** We built two things: a lightweight runtime
(DocsClaw) and a skill distribution system (skillimage.dev).
Skills are packaged, signed, and distributed like container
images. Enterprises already know how to manage that supply
chain.

**Open source.** The runtime, the skill packaging tools, the
OCI format are all open source. We're proving a pattern that
runs on any Kubernetes cluster, with OpenShift providing the
enterprise-grade foundation.

---
marp: true
theme: redhat-dark
paginate: true
header: ""
footer: "Red Hat — Lean Agents"
---

<!-- _class: section-title -->

# Production agents should be <span class="accent">lean</span>

Change my mind.

Pavel Anni · Office of the CTO · Red Hat

<span class="tag">leanagents</span> <span class="tag">openshift</span> <span class="tag">go</span>

<!--
Opening hook: the "Change My Mind" framing signals debate, not
lecture. Invite disagreement from the start — give the audience
permission to push back throughout.
Timing: ~45s
-->

---

# Everyone is building agents — with <span class="accent">developer</span> tools

- The agentic AI wave is here — every team wants AI assistants
- Python and TypeScript frameworks dominate: LangChain, CrewAI, OpenAI Agents SDK
- Engineers design agents for **their own needs**: code generation, git, testing
- These are powerful tools — and the right choice for developers

<!--
Acknowledge the status quo without dismissing it.
The audience builds on these frameworks — don't alienate them.
The key word is "developer" — set up the distinction that pays
off on slide 8.
Timing: ~60s
-->

---

# You've <span class="accent">done this before</span>

- **VMs → containers** — you learned to separate dev artifacts from production
- **Monoliths → microservices** — you learned to right-size your deployments
- **Dev agents → production agents** — same lesson, new workload

Lift-and-shift never works. You know this.

<!--
The historical pattern makes the argument feel inevitable.
The audience has lived through these transitions —
they already agree with the principle, they just haven't
applied it to agents yet.
Timing: ~60s
-->

---

<!-- _class: section-title -->

# The <span class="accent">runtime</span> is not the workload

An agent calls an LLM API and waits.
Seconds waiting. Milliseconds processing. Repeat.

The waiter outweighs the kitchen.

<!--
Core insight: the LLM does the thinking; the agent runtime
just makes API calls and processes results. Most of the time,
the runtime is idle — waiting for the network.
Yet most frameworks ship hundreds of megabytes of interpreter
and dependencies that sit idle 99% of the time.
Timing: ~45s
-->

---

# 200–500 MiB × 1,000 agents = a <span class="accent">problem</span>

- On your laptop, the OS shares libraries across processes — 500 MiB feels manageable
- On Kubernetes, resource requests are **exclusive reservations**
- The scheduler can't give that memory to another pod — even when yours is idle
- Most agents are idle most of the time, waiting for the next task
- What one agent hides on your laptop, a thousand expose on your cluster

<!--
Address the misconception: people assume K8s pods share memory
like processes on a personal computer. They don't.
Resource requests are hard commitments — the scheduler removes
that capacity from the available pool entirely.
1,000 pods × 500 MiB requested = 500 GiB reserved, mostly idle.
Timing: ~60s
-->

---

# Every agent is a full <span class="accent">dev environment</span>

- Python runtime, pip, virtualenv — all installed in the container
- Node.js, npm, node_modules — same story for TypeScript agents
- A malicious skill can `import subprocess` and run anything
- The attack surface **scales linearly** with the agent count
- Business users don't need any of this, but they inherit all of it

<!--
Stress the security angle — this resonates with platform teams.
Python → arbitrary code exec, pip → supply chain attacks,
shell → command injection, git → credential exposure.
Each pod is a full development environment that no one asked
for and no business user needs.
Timing: ~60s
-->

---

<!-- _class: section-title -->

# <span class="accent">~10 MiB</span> per agent pod

Full agentic loop. No interpreter. No dev tools.
20–50× less memory than a Python equivalent.

<!--
The reveal moment. Let the number breathe.
Source: measured on OpenShift — running pod ~11 MiB, idle ~9 MiB.
Don't explain yet — just the stat. The next slides explain how.
Timing: ~30s
-->

---

# Developer agents and production agents are <span class="accent">different workloads</span>

- **Developer agents** — full-featured, code execution, git, tests, IDE integration
- **Production agents** — lean, task-specific, no interpreter, no dev tools

| Task | Needs code execution? | Agent class |
|---|---|---|
| Resume screening | No | Production (lean) |
| Contract analysis | No | Production (lean) |
| Security triage | No | Production (lean) |

Match the agent to the task, not to the developer's IDE.

<!--
The key reframing — we're not replacing anything. We're
introducing a new class for workloads that don't need a full
dev environment. Claude Code, Copilot, Cursor — keep them for
engineering teams. Lean agents for business automation at scale.
Timing: ~75s
-->

---

# Five principles for <span class="accent">production</span> agents

1. **Minimal footprint** — single-digit MiB on Kubernetes, fit in device RAM
2. **No self-modification** — can't install packages or expand capabilities at runtime
3. **Admin-controlled capabilities** — a ConfigMap defines what the agent can do
4. **Signed skill delivery** — OCI-packaged, versioned, verified through existing supply chains
5. **Infrastructure-grade observability** — Prometheus metrics, OpenTelemetry traces, health probes

From data centers to $5 microcontrollers — the same principles apply.

<!--
The manifesto condensed. Counterarguments to address verbally:
1. "You'll run out of features" → features come from the LLM
2. "Dynamic plugins are flexible" → flexibility = attack surface
3. "Developers should own config" → developers build it,
   platform teams deploy it
4. "OCI is heavyweight" → it's infrastructure you already have
5. "Too much telemetry" → you'd instrument any other pod
Full manifesto at leanagents.dev/manifesto
Timing: ~75s
-->

---

# Python agent vs <span class="accent">lean</span> agent

| | Python/TS agent | Lean agent (Go) |
|---|---|---|
| **Memory per pod** | 200–500 MiB | ~10 MiB |
| **Startup time** | 2–5 seconds | <100 ms |
| **Attack surface** | Python + pip + shell | Static binary only |
| **Container image** | 500 MiB–1.5 GiB | ~15 MiB (scratch) |
| **1,000 agents** | 500 GiB reserved | 10 GiB reserved |

<!--
The most shareable slide in the deck.
The bottom row makes the K8s resource reservation concrete —
50× density difference at scale.
Numbers come from actual measurements on OpenShift.
Timing: ~60s
-->

---

# Let me <span class="accent">show</span> you

**Live demo on OpenShift:**

- 10 HR screening agents, each processing 10 resumes
- One job description → 100 candidate reports
- Watch the memory — all 10 agents under 150 MiB total
- Watch the clock — done in about one minute

<!-- TODO: add screenshot of the OpenShift dashboard or terminal -->

<!--
Set expectations before switching to the demo.
Tell the audience what to watch: the memory column in the
dashboard and the completion time. They should know what
"success" looks like before they see it.
Timing: ~60s, then switch to live demo for ~3 minutes
-->

---

<!-- _class: section-title -->

# <span class="accent">Change my mind</span>

<img src="change_my_mind.jpg" class="fit-image">

[leanagents.dev](https://leanagents.dev) · [GitHub](https://github.com/pavelanni/leanagents)

<!--
Callback to the opening. The meme lands as the closing punchline.
Clear invitation: challenge this thesis. What integrations are
missing? Where does the lean approach fall short?
Timing: ~45s
-->

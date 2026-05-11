# Lean Agents — project description

## What is Lean Agents?

Lean Agents is a movement and community advocating for
resource-efficient AI agent runtimes built with compiled
languages (Go, Rust, C/C++) instead of interpreted ones
(Python, TypeScript). The goal is to shift the industry
conversation from "what can agents do?" to "how efficiently
can we run them — from data centers to microcontrollers?"

The project maintains:

- **leanagents.dev** — community site with manifesto, member
  projects, benchmarks, and resources
- **The Lean Agent Manifesto** — principles for building
  production-grade agent runtimes
- **A benchmark methodology** — standardized measurement of
  agent resource footprint
- **A curated registry** of lean agent projects

## The problem

AI agent frameworks today are built for prototyping, not
production. The problem manifests at both ends of the
computing spectrum:

**Scale out (data centers):** A typical Python-based agent pod
on Kubernetes consumes 200-500 MiB of memory. At that
footprint:

- 100 agents = 20-50 GiB of cluster memory
- 1,000 agents = impractical
- Per-user agents = impossible at enterprise scale

**Scale down (embedded):** An ESP32 microcontroller has 520 KiB
of RAM. A Python runtime cannot physically fit. Yet these
devices are increasingly expected to act as intelligent agents
— reading sensors, making decisions, controlling actuators —
with LLM assistance.

In both cases, the agent is not the bottleneck — the LLM API
call takes seconds regardless of whether the caller is Python
or Go. But the runtime sitting idle between calls still
consumes memory, still presents an attack surface, and still
costs money (or doesn't fit at all).

## The insight

AI coding assistants eliminated the developer productivity
gap between compiled and interpreted languages. The app that
took days in Go now takes 30 minutes with AI assistance —
same as Python. The tradeoff that justified interpreted
runtimes no longer exists, but the 20-50x resource penalty
remains.

## Two tracks, one principle

Lean Agents spans two deployment contexts united by the same
constraint — the runtime must be as small as possible:

| Track      | Environment                  | Constraint                  | Example projects             |
| ---------- | ---------------------------- | --------------------------- | ---------------------------- |
| Scale out  | Kubernetes, OpenShift, cloud | Memory cost × 1000s of pods | DocsClaw, ZeroClaw, PicoClaw |
| Scale down | Microcontrollers, edge, IoT  | Physical RAM limits (KiB)   | ESP-Claw                     |

The principles below apply to both. A 10 MiB Go agent on
Kubernetes and a 200 KiB C agent on an ESP32 are both lean
agents — they differ in degree, not in kind.

## The Lean Agent Manifesto

Five principles for production-grade agent runtimes:

1. **Minimal footprint.** The runtime is not the workload —
   the LLM is. An idle agent on Kubernetes should consume
   single-digit MiB. An embedded agent should fit in the
   device's available RAM. Don't waste resources on the caller.

2. **No self-modification.** The agent cannot install packages,
   download code, or expand its own capabilities at runtime.
   Capabilities are defined at deployment time by the
   administrator, not discovered at runtime by the agent.

3. **Admin-controlled capabilities.** The agent's personality
   (system prompt), tools, and skills are configuration, not
   code. A ConfigMap, a firmware image, or a mounted volume
   defines what the agent can do — not a requirements.txt.

4. **Signed, immutable skill delivery.** Skills are packaged,
   versioned, and signed artifacts — distributed through the
   same supply chain enterprises already trust for container
   images (OCI registries, sigstore, image volumes).

5. **Infrastructure-grade observability.** Agents are
   infrastructure. On Kubernetes: structured logs, Prometheus
   metrics, OpenTelemetry traces, health endpoints. On
   embedded: serial logging, heartbeat signals, OTA update
   status. The agent is managed like any other workload in
   its environment.

## Member projects

### DocsClaw

- **Language:** Go
- **Repository:** https://github.com/redhat-et/docsclaw
- **Website:** https://docsclaw.dev
- **Focus:** ConfigMap-driven agent runtime for OpenShift/K8s
- **Footprint:** ~10 MiB per pod
- **Key features:** A2A protocol, OCI skill delivery via
  image volumes, multi-provider LLM support, agentic tool
  loops, session persistence
- **Organization:** Red Hat Emerging Technologies (https://next.redhat.com/)

### ZeroClaw

- **Language:** Rust
- **Repository:** https://github.com/zeroclaw-labs/zeroclaw
- **Website:** https://www.zeroclawlabs.ai/
- **Focus:** A provider-agnostic agent runtime with 30+ channels
  (Discord, Telegram, Matrix, email, voice, etc.)
- **Organization:** ZeroClaw Labs (https://zeroclawlabs.ai)

### PicoClaw

- **Language:** Go
- **Repository:** https://github.com/sipeed/picoclaw
- **Website:** https://picoclaw.io
- **Focus:** Ultra-lightweight personal AI assistant inspired by NanoBot.
  Runs on $10 hardware with <10MB RAM
- **Organization:** Sipeed (https://sipeed.com)

### OpenFang

- **Language:** Rust
- **Repository:** https://github.com/RightNow-AI/openfang
- **Website:** https://openfang.sh
- **Focus:** open-source Agent Operating System. Not a chatbot framework.
  Not a Python wrapper around an LLM. Not a "multi-agent orchestrator."
  A full operating system for autonomous agents, built from scratch in Rust.
- **Organization:** RightNow Research Lab (https://www.rightnowai.co/)

### ESP-Claw (scale-down track)

- **Language:** C/C++ (ESP-IDF) with Lua for scripted tasks
- **Repository:** github.com/espressif/esp-claw
- **Website:** https://esp-claw.com
- **Focus:** Edge agent framework for ESP32 microcontrollers;
  chat-as-coding paradigm for IoT devices
- **Footprint:** Runs on ESP32 (520 KiB RAM)
- **Key features:** MCP server and client, on-chip long-term
  memory, hybrid execution (LLM for dynamic decisions, Lua
  for deterministic tasks), offline operation, millisecond
  response times for cached behaviors
- **Organization:** Espressif Systems (https://www.espressif.com/)

### MimiClaw

- **Language:** C
- **Repository:** https://github.com/memovai/mimiclaw
- **Website:** https://mimiclaw.io/
- **Focus:** A fully functional Claude-powered AI assistant,
  compiled to bare-metal C, running on a $5 ESP32-S3 chip at 0.5W.
  Accessible via Telegram. Remembers across reboots.
- **Footprint:** Runs on ESP32 (520 KiB RAM)
- **Organization:** MemoV, Inc. (https://www.memov.ai/)

## Benchmark methodology

A standardized way for lean agent projects to report
comparable resource metrics.

### Scale-out metrics (Kubernetes)

Measured with `kubectl top` / `oc adm top pod`:

| Metric       | How to measure                                             |
| ------------ | ---------------------------------------------------------- |
| Idle memory  | Pod memory 60s after startup, no active requests           |
| Peak memory  | Maximum memory during a 10-turn conversation with tool use |
| Startup time | Time from pod creation to readiness probe passing          |
| Image size   | Compressed container image size                            |
| Binary size  | Uncompressed binary (excludes base image)                  |

### Scale-down metrics (embedded)

Measured with platform-specific tooling (e.g., ESP-IDF memory
analysis, `size` command):

| Metric             | How to measure                                    |
| ------------------ | ------------------------------------------------- |
| Idle RAM           | Heap + stack usage after boot, no active requests |
| Peak RAM           | Maximum heap during an agent interaction          |
| Flash usage        | Firmware image size                               |
| Boot time          | Time from power-on to ready state                 |
| Offline capability | Can the agent function without network?           |

### Reference comparison

Projects should also report the same metrics for at least one
comparable framework — Python-based for scale-out projects, or
a cloud-dependent alternative for embedded projects.

### Reporting format

Projects submit a YAML file to the registry:

```yaml
# Scale-out example
project: docsclaw
track: scale-out
language: go
version: 0.7.0
platform: OpenShift 4.20
arch: amd64
measurements:
  idle_memory_mib: 9
  peak_memory_mib: 14
  startup_seconds: 0.3
  image_size_mib: 12
  binary_size_mib: 10
comparison:
  framework: langchain
  idle_memory_mib: 240
  peak_memory_mib: 380
  startup_seconds: 4.2
  image_size_mib: 890
```

```yaml
# Scale-down example
project: esp-claw
track: scale-down
language: c
version: 0.1.0
platform: ESP32-S3
arch: xtensa
measurements:
  idle_ram_kib: 180
  peak_ram_kib: 320
  flash_kib: 1400
  boot_seconds: 1.2
  offline_capable: true
```

## Site structure (leanagents.dev)

```text
/                     Landing page: problem, insight, manifesto
/manifesto            Full manifesto with rationale
/projects             Registry of lean agent projects
/benchmarks           Methodology and submitted results
/blog                 Articles, case studies, conference talks
/llms.txt             Agent-friendly site summary
/llms-full.txt        Full site content for agents
```

### Landing page narrative

1. **The hook:** "From 9 MiB on Kubernetes to 180 KiB on an
   ESP32. Agents belong everywhere — if the runtime lets them."
2. **The problem:** Python agent runtimes consume 200-500 MiB
   in the data center and can't fit on embedded devices at all.
3. **The insight:** AI assistants eliminated the productivity
   gap. Compiled languages are now equally fast to develop in.
4. **Two tracks:** Scale out (thousands of agents on clusters)
   and scale down (agents on microcontrollers and edge devices).
5. **The manifesto:** Five principles (summary, link to full).
6. **The projects:** Cards for each member project with key
   metrics, organized by track.
7. **The benchmark:** "Don't take our word for it. Here's how
   to measure."
8. **Call to action:** "Building a lean agent? Add it to the
   registry."

## Target audience

| Audience                 | What they care about                                   |
| ------------------------ | ------------------------------------------------------ |
| IT Ops / Platform teams  | Resource cost, pod density, cluster sizing             |
| Security teams           | Attack surface, no self-modification, signed artifacts |
| Enterprise architects    | Scalability, governance, audit trails                  |
| Embedded / IoT engineers | RAM constraints, offline operation, firmware size      |
| Agent developers         | Patterns for building efficient runtimes               |
| CTOs / VPs Engineering   | Cost per agent, agents-per-user economics              |

## Immediate next steps

1. Register `leanagents.dev` (done)
2. Create the repository (github.com/leanagents or similar)
3. Write the landing page (Hugo, Astro, or plain HTML)
4. Publish the manifesto as a standalone document
5. Submit DocsClaw as the first registry entry
6. Add `/llms.txt` and `/llms-full.txt`
7. Write a blog post announcing the project (cross-post to
   LinkedIn, dev.to, Reddit r/kubernetes)
8. Present at a meetup or conference (KubeCon, DevConf,
   OpenShift Commons)

## Relationship to other projects

- **skillimage.dev** — complementary: defines how skills are
  packaged and distributed; lean agents consume them
- **agent-registry** (agentoperations/agent-registry) —
  complementary: metadata and governance for agents; lean
  agents are a category of registered agents
- **Kagenti** — compatible: lean agents can run on Kagenti
  platforms, though the Envoy sidecar overhead (~200 MiB)
  should be measured separately from the agent itself
- **ESP-IDF** — Espressif's development framework; ESP-Claw
  builds on it to bring agent capabilities to ESP32 chips
- **MCP** — Model Context Protocol is emerging as the standard
  tool interface across both tracks; ESP-Claw and DocsClaw
  both support it

## Open questions

- Should the manifesto be versioned (1.0, 2.0) or living?
- Should the benchmark include LLM token throughput or just
  runtime metrics?
- Should projects need to meet a threshold (e.g., under 50 MiB
  idle for scale-out, under 500 KiB for scale-down) to be
  listed, or is it a self-reported registry?
- Should there be a "Lean Agent Certified" badge for projects
  that pass the benchmark?
- GitHub org name: `leanagents`, `lean-agents`,
  `leanagents-dev`?
- How to handle projects that span both tracks (e.g., a Rust
  agent that runs on both Kubernetes and embedded Linux)?
- Should we reach out to Espressif about listing ESP-Claw, or
  wait for them to discover the project organically?

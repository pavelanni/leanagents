---
title: "Lean Agents"
description: "Resource-efficient AI agent runtimes. From 9 MiB on Kubernetes to 180 KiB on an ESP32."
---

{{< lead >}}
From 9 MiB on Kubernetes to 180 KiB on an ESP32.
Agents belong everywhere --- if the runtime lets them.
{{< /lead >}}

## The problem

AI agent frameworks today are built for prototyping, not production.
The problem shows up at both ends of the computing spectrum.

**Scale out (data centers).** A typical Python-based agent pod on
Kubernetes consumes **200--500 MiB** of memory. At that footprint,
100 agents need 20--50 GiB of cluster memory. A thousand agents?
Impractical. Per-user agents at enterprise scale? Impossible.

**Scale down (embedded).** An ESP32 microcontroller has **520 KiB**
of RAM. A Python runtime cannot physically fit. Yet these devices
are increasingly expected to act as intelligent agents --- reading
sensors, making decisions, controlling actuators --- with LLM
assistance.

In both cases, the agent is not the bottleneck --- the LLM API call
takes seconds regardless of whether the caller is Python or Go. But
the runtime sitting idle between calls still consumes memory, still
presents an attack surface, and still costs money.

## The insight

AI coding assistants eliminated the developer productivity gap
between compiled and interpreted languages. The app that took days
in Go now takes 30 minutes with AI assistance --- same as Python.

**The tradeoff that justified interpreted runtimes no longer exists,
but the 20--50x resource penalty remains.**

## Two tracks, one principle

Lean Agents spans two deployment contexts united by the same
constraint --- the runtime must be as small as possible.

| Track | Environment | Constraint | Example projects |
| --- | --- | --- | --- |
| Scale out | Kubernetes, cloud | Memory cost × 1000s of pods | DocsClaw, ZeroClaw, PicoClaw |
| Scale down | Microcontrollers, edge | Physical RAM limits (KiB) | ESP-Claw, MimiClaw, WireClaw |

A 10 MiB Go agent on Kubernetes and a 200 KiB C agent on an ESP32
are both lean agents --- they differ in degree, not in kind.

## The manifesto

Five principles for production-grade agent runtimes:

1. **Minimal footprint.** The runtime is not the workload --- the
   LLM is.
2. **No self-modification.** Capabilities are defined at deploy
   time, not discovered at runtime.
3. **Admin-controlled capabilities.** Configuration, not code.
4. **Signed, immutable skill delivery.** Same supply chain you
   trust today.
5. **Infrastructure-grade observability.** Agents are
   infrastructure. Manage them like it.

{{< button href="/manifesto/" >}}
Read the full manifesto
{{< /button >}}

## Member projects

- **[DocsClaw](https://docsclaw.dev)** --- Go agent runtime for
  OpenShift/Kubernetes (~10 MiB per pod)
- **[ZeroClaw](https://www.zeroclawlabs.ai/)** --- Rust agent
  runtime with 30+ communication channels
- **[PicoClaw](https://picoclaw.io)** --- Go personal AI assistant
  (<10 MB RAM)
- **[OpenFang](https://openfang.sh)** --- Rust agent operating
  system built from scratch
- **[ESP-Claw](https://esp-claw.com)** --- C/C++ edge agent for
  ESP32 microcontrollers (520 KiB RAM)
- **[MimiClaw](https://mimiclaw.io/)** --- C agent on bare-metal
  ESP32-S3 at 0.5 W
- **[WireClaw](https://wireclaw.io/)** --- C++ agent on ESP32,
  controls real hardware via Telegram

{{< button href="/projects/" >}}
View all projects
{{< /button >}}

## Building a lean agent?

{{< alert >}}
If your agent runtime is compiled, minimal, and infrastructure-grade,
it belongs here. Add your project to the registry.
{{< /alert >}}

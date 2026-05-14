---
title: "The lean agent manifesto"
description: "Five principles for production-grade agent runtimes."
showDate: false
showReadingTime: true
showAuthor: false
showBreadcrumbs: true
showTableOfContents: true
---

{{< lead >}}
Five principles for building agent runtimes that belong in
production --- from data centers to microcontrollers.
{{< /lead >}}

## The runtime is not the workload

Every AI agent makes the same fundamental trade: it spends seconds
waiting for an LLM API response, then milliseconds processing the
result. The runtime is a thin wrapper around a network call. Yet
most agent frameworks ship hundreds of megabytes of interpreter,
dependencies, and abstraction layers that sit idle 99% of the time.

This manifesto is for teams who build the wrapper --- and want it
to disappear.

## Principle 1: minimal footprint

> An idle agent on Kubernetes should consume single-digit MiB.
> An embedded agent should fit in the device's available RAM.
> Don't waste resources on the caller.

The LLM is the workload. The runtime is plumbing. When a single
Python-based agent pod consumes 200--500 MiB, you can fit maybe
five agents per gigabyte of cluster memory. A Go agent at 10 MiB
fits fifty. A C agent at 200 KiB fits five thousand.

This matters in two directions. In the data center, memory cost
multiplied by thousands of pods determines whether per-user agents
are economically viable. On a microcontroller with 520 KiB of RAM,
a large runtime does not just waste resources --- it physically
cannot fit.

The principle is the same at both scales: measure your idle
footprint, and make it as small as the language allows.

## Principle 2: no self-modification

> The agent cannot install packages, download code, or expand its
> own capabilities at runtime. Capabilities are defined at
> deployment time by the administrator, not discovered at runtime
> by the agent.

A Python agent that can `pip install` arbitrary packages at runtime
has an unbounded attack surface. Every package it installs is code
that was never reviewed, never scanned, and never approved by the
team responsible for the workload.

Compiled agents enforce this naturally. A Go binary or a C firmware
image cannot modify itself. The capabilities available at deploy
time are the capabilities available at runtime --- nothing more.

This is not a limitation. It is the same property that makes
containers trustworthy: immutability. An agent that cannot change
itself can be audited, scanned, and signed with confidence.

## Principle 3: admin-controlled capabilities

> The agent's personality, tools, and skills are configuration,
> not code. A ConfigMap, a firmware image, or a mounted volume
> defines what the agent can do --- not a requirements.txt.

Who decides what an agent can do? In most frameworks, the
developer decides at coding time by importing libraries and
writing tool functions. The operations team inherits whatever was
committed to the repository.

In a lean agent, capabilities are configuration. On Kubernetes,
a ConfigMap or mounted volume defines the system prompt, available
tools, and skill packages. On an embedded device, the firmware
image contains the full capability set. In both cases, the
administrator --- not the developer, and certainly not the
agent --- controls what the agent can do.

This separation matters for governance. When capabilities are
configuration, you can audit them with the same tools you use for
any other infrastructure: policy engines, admission controllers,
change management workflows.

## Principle 4: signed, immutable skill delivery

> Skills are packaged, versioned, and signed artifacts ---
> distributed through the same supply chain enterprises already
> trust for container images.

Agent skills --- the functions an agent can call, the tools it can
use --- are software. They should be treated like software:
versioned, packaged, signed, and distributed through a trusted
supply chain.

On Kubernetes, this means OCI artifacts stored in container
registries, verified with sigstore or similar signing
infrastructure, and delivered as image volumes mounted into the
agent pod. On embedded devices, this means skills baked into the
firmware image and verified at boot.

The goal is zero new supply chain infrastructure. Enterprises
already have registries, signing keys, and promotion pipelines.
Lean agent skills flow through the same channels as container
images.

## Principle 5: infrastructure-grade observability

> Agents are infrastructure. On Kubernetes: structured logs,
> Prometheus metrics, OpenTelemetry traces, health endpoints.
> On embedded: serial logging, heartbeat signals, OTA update
> status.

An agent that cannot be monitored cannot be trusted. If it runs in
a cluster, it needs the same observability as any other pod:
structured logs that feed into the cluster's logging pipeline,
Prometheus metrics that appear in Grafana dashboards,
OpenTelemetry traces that connect agent actions to upstream and
downstream services, and health endpoints that the kubelet can
probe.

If it runs on a microcontroller, it needs serial logging for
debugging, heartbeat signals for liveness monitoring, and OTA
update status for fleet management.

The agent is not special. It is a workload. Manage it like one.

---

## Joining the movement

The Lean Agents movement is open to any project that builds agent
runtimes following these principles. If your runtime is compiled,
minimal, and observable, it belongs in the
[project registry](/projects/).

{{< alert >}}
**Want to add your project?** [Open an issue](https://github.com/pavelanni/leanagents/issues/new)
on our GitHub repository.
{{< /alert >}}

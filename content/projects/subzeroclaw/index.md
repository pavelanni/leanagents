---
title: "SubZeroClaw"
description: "Ultra-minimal agentic runtime in C for resource-constrained devices"
summary: "A ~380-line C runtime that connects an LLM to a shell in a loop. Runs autonomous agents on Raspberry Pis at 54 KB binary size and ~2 MB RAM."
tags: ["c", "edge", "minimal"]
showDate: false
showAuthor: false
showReadingTime: false
---

| | |
| --- | --- |
| **Language** | C |
| **Track** | Edge / minimal |
| **Organization** | [GenLayer Labs](https://genlayer.com) |
| **Repository** | [genlayerlabs/subzeroclaw](https://github.com/genlayerlabs/subzeroclaw) |
| **Website** | [subzeroclaw.com](https://subzeroclaw.com/) |

## Key features

- ~380 lines of C, 54 KB binary, ~2 MB runtime RAM
- Single tool: shell via `popen()` — inherits every CLI tool
  on the system
- Skills are plain markdown files, no schema or registry
- Context compaction via LLM summarization when history grows
- Watchdog process for daemon mode with crash recovery

<div class="cta-row">

{{< button href="https://subzeroclaw.com/" target="_blank" >}}
Visit website
{{< /button >}}

{{< button href="https://github.com/genlayerlabs/subzeroclaw" target="_blank" >}}
Visit repository
{{< /button >}}

</div>

---
title: "Khieron"
description: "Kubernetes-native agentic operator built with Go and Google ADK"
summary: "A lightweight Kubernetes operator that turns Skill CRDs into autonomous agents with human-in-the-loop approval via Advisories."
tags: ["go", "kubernetes", "operator"]
showDate: false
showAuthor: false
showReadingTime: false
---

| | |
| --- | --- |
| **Language** | Go |
| **Track** | Kubernetes-native |
| **Organization** | [Khieron](https://github.com/khieron) |
| **Repository** | [khieron/khieron](https://github.com/khieron/khieron) |

## Key features

- Kubernetes operator using Google's adk-go SDK, no Python
  dependencies
- Skills are CRDs backed by ConfigMap-based Skill.md files
  conforming to the [Agent Skill Specification](https://agentskills.io/specification)
- Advisories provide human-in-the-loop approval via
  `kubectl patch`
- Supports Gemini, Claude, or self-hosted models via ADK
- UBI 9 minimal image under 265 MB, non-root execution,
  scoped ServiceAccounts per Skill
- Token usage tracking and automatic Skill pausing on
  persistent failures

<div class="cta-row">

{{< button href="https://github.com/khieron/khieron" target="_blank" >}}
Visit repository
{{< /button >}}

</div>

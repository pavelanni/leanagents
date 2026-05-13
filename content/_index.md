---
title: "Lean Agents"
description: "Resource-efficient AI agent runtimes. From 9 MiB on Kubernetes to 180 KiB on an ESP32."
showTitle: true
---

{{< figure src="lean_agents_hero.png" alt="Three lean agents collaborating — analyzing data, writing code, and designing architecture" figureClass="hero-figure" nozoom=true >}}

{{< stats items=`[
  {"value": "10 MiB", "label": "Lean Agent Pod", "comparison": "vs 300 MiB traditional", "multiplier": "30×"},
  {"value": "5,000", "label": "Agents per 50 GiB", "comparison": "vs 100 traditional", "multiplier": "50×"},
  {"value": "0", "label": "Runtime Deps", "comparison": "vs Python + pip + OS pkgs", "multiplier": "Static binary"},
  {"value": "10 ms", "label": "Startup Time", "comparison": "vs seconds", "multiplier": "Instant"}
]` >}}

## The problem

AI agent frameworks are built for prototyping, not production. A
typical Python agent pod consumes 200--500 MiB. At that footprint,
100 agents need 50 GiB. Meanwhile, an ESP32 has 520 KiB total ---
Python can't even fit.

## The insight

AI coding assistants eliminated the productivity gap between compiled
and interpreted languages. The tradeoff that justified heavy runtimes
no longer exists --- but the 20--50× resource penalty remains.

<div class="two-tracks">
  <div class="track-card">
    <div class="track-icon">☁️</div>
    <div class="track-title">Scale Out</div>
    <div class="track-desc">Kubernetes · Cloud<br>Memory cost × 1000s of pods</div>
  </div>
  <div class="track-card">
    <div class="track-icon">
      <img src="/img/esp32-board.png" alt="ESP32 microcontroller board">
    </div>
    <div class="track-title">Scale Down</div>
    <div class="track-desc">Microcontrollers · Edge<br>Physical RAM limits (KiB)</div>
  </div>
</div>

<div class="cta-row">

{{< button href="/manifesto/" >}}
Read the manifesto
{{< /button >}}

{{< button href="/projects/" >}}
View projects
{{< /button >}}

{{< button href="/journey/" >}}
The journey
{{< /button >}}

</div>

---
layout: default
title: Research overview
permalink: /
description: An independent, open research project about making AI-assisted engineering evidence more inspectable.
---

<section class="hero" aria-labelledby="hero-title">
  <div class="hero-content">
    <div class="eyebrow">Independent research / Work in progress</div>
    <h1 id="hero-title">Can an AI agent show <em>what it actually checked?</em></h1>
    <p class="hero-lede">Exploring evidence-gated agentic systems: a general-purpose approach to scope, graph analysis, source integrity, authorization, and accountable human decisions. Model-Based Systems Engineering is the reference application—not the limit of the idea.</p>
    <div class="hero-actions">
      <a class="btn btn-primary" href="{{ '/whitepaper/' | relative_url }}">Read the working white paper</a>
      <a class="btn btn-outline" href="{{ '/adversarial-review/' | relative_url }}">Challenge the architecture</a>
    </div>
    <p class="hero-note">Research by Corey Steinwand · November 2026 · No product, certification, or performance claim</p>
  </div>
</section>

<div class="section-kicker">The research question</div>

## A complete traversal can still be wrong.

A verifier can confirm that an agent inspected every required part of a **pinned, authorized graph snapshot**. It cannot prove that the graph contained every real-world dependency. This distinction is the starting point of the project, not a footnote.

A proposed harness would separate deterministic duties—permissions, task scope, required-node enumeration, evidence bookkeeping, consent, and audit—from probabilistic reasoning. Whether that separation needs a **new harness at all** remains an open, testable question.

<div class="section-kicker">Explore the work</div>

## Read the argument and try to break it.

<div class="cards">
  <div class="card">
    <div class="card-tag">Architecture / Draft</div>
    <h3>White paper</h3>
    <p>Philosophy, trust boundaries, graph coverage contract, risk override policy, and the MBSE reference workflow.</p>
    <a href="{{ '/whitepaper/' | relative_url }}">Read the proposal →</a>
  </div>
  <div class="card">
    <div class="card-tag">Criticism / Active</div>
    <h3>Adversarial review</h3>
    <p>Why Codex[^codex], managed agents, graph databases, and existing MBSE tools might already be enough.</p>
    <a href="{{ '/adversarial-review/' | relative_url }}">Read the counterarguments →</a>
  </div>
  <div class="card">
    <div class="card-tag">Experiment / Proposed</div>
    <h3>Validation protocol</h3>
    <p>A deliberately cheap, no-LLM first test using historical engineering escapes and as-of-time graph snapshots.</p>
    <a href="{{ '/validation/' | relative_url }}">See how the idea can fail →</a>
  </div>
  <div class="card">
    <div class="card-tag">Formalization / Baseline</div>
    <h3>SysML v2[^sysml] architecture</h3>
    <p>A textual model of the proposed framework, with requirements and verification cases—declared, not executed.</p>
    <a href="{{ '/model/' | relative_url }}">Explore model sources →</a>
  </div>
  <div class="card">
    <div class="card-tag">Boundaries / Explicit</div>
    <h3>What it cannot prove</h3>
    <p>Unmodeled edges, incomplete scopes, tainted evidence, human automation bias, and post-action effects.</p>
    <a href="{{ '/assurance-boundaries/' | relative_url }}">Inspect the limits →</a>
  </div>
  <div class="card">
    <div class="card-tag">Prior art / Living index</div>
    <h3>Existing approaches</h3>
    <p>Assurance cases, provenance, tool qualification, policy engines, agent harnesses, and engineering platforms.</p>
    <a href="{{ '/prior-art/' | relative_url }}">Browse references →</a>
  </div>
</div>

<div class="research-callout">
  <h3>The first experiment uses no LLM.</h3>
  <p>For 20–30 historical engineering escapes, reconstruct the model as it existed before the escape. Were the missed dependencies present and reachable, present but out of scope, absent from the model, or impossible to establish? If model incompleteness dominates, we should change direction before writing an elaborate agent harness.</p>
</div>

<div class="meta-grid">
  <div>
    <span class="status-pill">Working draft v0.2</span>
    <h3>Open to correction</h3>
    <p>Claims are separated into architecture proposals, hypotheses, and observed results. The project presently has no performance results, certified safety argument, or independent peer review.</p>
  </div>
  <div>
    <span class="status-pill">Personal research</span>
    <h3>Independent by design</h3>
    <p>This is Corey Steinwand’s personal exploration of an engineering idea. Please keep confidential engineering models and customer data out of public discussions.</p>
  </div>
</div>

[Read the research roadmap]({{ '/roadmap/' | relative_url }}) · [Review the source audit]({{ '/reference-audit/' | relative_url }}) · [Follow the research log]({{ '/research-log/' | relative_url }}) · [Raise a counterexample](https://github.com/madhatter5501/Exploring-AI-in-MBSE/issues)


## Source footnotes and acknowledgements

These notes acknowledge existing tools, standards, and methods at their first substantive mention. Sources establish only their described scope; they do not validate this research architecture.

[^codex]: OpenAI Codex is a candidate coding-agent host, not a demonstrated MBSE assurance solution. Vendor overview: [Codex as a Platform](https://developers.openai.com/blog/codex-as-a-platform); [source repository](https://github.com/openai/codex).

[^sysml]: OMG SysML v2 is an established modeling language. Parser acceptance or tool export is not validation of engineering-model semantics. [OMG v2 specification](https://www.omg.org/spec/SysML/2.0); [reference releases](https://github.com/Systems-Modeling/SysML-v2-Release).

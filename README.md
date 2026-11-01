# Exploring AI in MBSE

> **Independent research · Work in progress · Not a product or certified assurance system**

An open investigation into **evidence-gated agentic systems**: how can an AI-assisted engineering workflow show what it examined, expose what it cannot establish, and keep human decisions accountable without confusing probabilistic judgments with deterministic authority?

**Model-Based Systems Engineering (MBSE)** is the reference application. The underlying questions—bounded scope, trusted inputs, permission boundaries, evidence provenance, and independent verification—are intended to apply more generally.

**Research by Corey Steinwand.** This is a personal research exploration, shared in progress.

## Start here

- GitHub Pages website — source is in [`docs/`](docs/index.md); publication will be enabled in the repository's Pages settings.
- [Architectural white paper](docs/whitepaper.md) — revised working draft, not peer reviewed.
- [Adversarial review](docs/adversarial-review.md) — arguments against building the harness and known failure modes.
- [Reference and claim audit](docs/reference-audit.md) — checked links, source-scope corrections, footnotes, and unresolved assertions.
- [Assurance boundaries](docs/assurance-boundaries.md) — what coverage and evidence checks do *not* prove.
- [Validation plan](docs/validation.md) — Phase 0 historical escapes, baselines, and proposed falsification tests.
- [Research roadmap](docs/roadmap.md) — near-term milestones and stop/reframe decisions.
- [SysML v2 model](models/Evidence_Attested_Agentic_Harness.sysml)[^sysml] — formalized architecture; executable product behavior is **not** implied.

## The central question

A deterministic checker can verify that an agent accounted for every node and edge *represented in an authorized, pinned graph snapshot*. It cannot establish that every real-world dependency was modeled. A clean traversal of the wrong graph can be confidently wrong.

This project distinguishes:

1. **Modeled-graph coverage**: Which required nodes, edges, and leaves were inspected under a frozen contract?
2. **Engineering source fidelity**: Which necessary dependencies or trace links are missing from the model?
3. **Authorization and consent**: Who may act, who may acknowledge risk, and which separate waivers or roles are required?
4. **Claim grounding and uncertainty**: What do sources support, what remains inferred, and what was never checked?
5. **Human decision effects**: Can an apparently reassuring coverage badge increase reviewer complacency?

## Current evidence status

| Item | Status |
|---|---|
| Architecture and trust boundaries | Proposed |
| SysML v2 textual syntax | Parsed with the strict OpenSysML/MBSE4U checker[^mbse4u]; cross-tool import not established |
| Requirements and verification cases | Declared in model; **not executed** |
| Real-world completeness of source graphs | Unknown |
| Independent corroboration and sibling-pattern benefit | Hypotheses |
| Historical-escape evaluation | Planned, no results yet |
| Commercial viability or regulatory qualification | Not claimed |

No completeness percentages, proof claims, certifications, or measured safety improvements are asserted in the absence of executed evidence.

## Immediate research gate: no-LLM Phase 0

Recover 20–30 historical engineering escapes and the engineering graph **as it existed at the time**. Classify each relevant dependency as:

- Present and reachable under the then-approved roots and scope.
- Present in the model but excluded from scope.
- Absent from the historical model.
- Indeterminate because archival evidence is insufficient.

If most costly misses depended on absent links, a traversal gate is not the right primary answer. The project must **reframe or stop**, rather than optimize an inadequate mechanism.

## How to participate

Issues describing reproducible counterexamples, prior art, architectural objections, or independent results are particularly welcome. Please do not post confidential engineering data, proprietary customer models, or personal information.

## Scope and attribution

This repository documents a research idea, not a production service, safety case, or qualified verification tool. Third-party standards, papers, and tools are cited for context; their existence and capabilities should not be interpreted as endorsements of this work.

Licensing and reuse terms will be selected deliberately; public visibility alone does not grant an open-source license.

## Source footnotes

[^sysml]: [OMG SysML v2](https://www.omg.org/spec/SysML/2.0) is the external modeling-language standard; syntax conformance and independent model assurance are different questions.

[^mbse4u]: [MBSE4U's online checker](https://mbse4u.com/tools/sysml-check/) is the reported parser used on an earlier snapshot; a second independent tool has not yet validated this export.

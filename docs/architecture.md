---
layout: default
title: Conceptual architecture
permalink: /architecture/
description: High-level boundaries and responsibilities for a proposed evidence-gated agentic system.
---

# Conceptual architecture

*One possible decomposition; not a settled implementation.*

The architectural hypothesis is simple: **a reasoning model should analyze evidence without also deciding what counts as permission, coverage, or reliable provenance.** Whether those duties are delivered by a dedicated harness, an existing agent runtime, a graph database, a policy engine, or several composed tools is open.

## Responsibilities by boundary

| Responsibility | Proposed deterministic authority | Probabilistic reasoning role |
|---|---|---|
| Principal and tenant permission | Identity and policy control plane | None |
| Graph roots, scope, and visibility | Pinned approved profile / snapshot | May suggest a change, never silently adopt it |
| Required nodes and relevant relations | Graph query / obligation enumerator | Inspects assigned obligations |
| Evidence record validity | Schemas, provenance, policy, freshness | Explains and classifies evidence with uncertainty |
| Claims about findings | Grounding checks, unresolved-status rules | Drafts human-readable analysis |
| Tool actions | Exact invocation authorization and execution re-check | Proposes an action |
| Risk disposition | Authorized human roles, separate waiver policy | Summarizes possible consequences |
| Audit and continuation | Durable log and state machine | Supplies bounded outputs |

## One side-effecting action

1. **Preauthorize** principal, tool, action class, and data visibility. Deny without running potentially revealing checks where policy demands.
2. **Freeze** task roots, scope, graph version, source identity, and budgets.
3. **Enumerate** expected inspections and other domain-specific obligations.
4. **Analyze** evidence under constrained profiles; check provenance, source trust, constraints, and claim grounding.
5. **Aggregate** all currently knowable findings into one review packet for this individual action; identify indeterminate checks and budget limits.
6. **Evaluate combined effects** of the plan or batch, not just the individual step.
7. **Receive human disposition** when a side effect requires it; keep acknowledgement, risk waiver, and authority separate.
8. **Reauthorize exact parameters** at execution and validate the snapshot/plan has not become stale.
9. **Execute or deny**, then preserve results and any post-execution findings for follow-up.

For read-only, appropriately disclosed answers, mandatory acknowledgement is generally unnecessary. Permission denial, timeout, and inconclusive verification have distinct paths.

## Why MBSE first?

Engineering change impact provides a useful falsifiable reference:

- model entities and typed relations exist;
- a change should have constrained roots and traversal semantics;
- incomplete trace links are a well-known failure mode;
- specialized user-maintained profiles can express engineering practices;
- reviewer decisions have costs and consequences.

The model itself is not assumed complete. The first experiment tests whether missing real-world relations swamp any benefit from exhaustive traversal.

## Implementation deliberately undecided

This project does **not** commit to a particular graph database, UI, model provider, workflow engine, or solver. That choice follows the Phase 0 study and build-versus-buy matrix.

[White paper]({{ '/whitepaper/' | relative_url }}) · [Validation]({{ '/validation/' | relative_url }}) · [SysML v2[^sysml] model]({{ '/model/' | relative_url }})


## Source footnotes and acknowledgements

These notes acknowledge existing tools, standards, and methods at their first substantive mention. Sources establish only their described scope; they do not validate this research architecture.

[^sysml]: OMG SysML v2 is an established modeling language. Parser acceptance or tool export is not validation of engineering-model semantics. [OMG v2 specification](https://www.omg.org/spec/SysML/2.0); [reference releases](https://github.com/Systems-Modeling/SysML-v2-Release).

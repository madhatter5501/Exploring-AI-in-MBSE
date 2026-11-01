---
layout: default
title: Validation protocol
permalink: /validation/
description: A falsifiable, no-LLM-first research protocol for engineering graph coverage and agent review.
---

# Validation before implementation

*Proposed protocol · No results reported*

The first decision is **whether the bottleneck is traversing modeled dependencies or modeling the dependencies in the first place**. It is possible that conventional graph queries, improved traceability, and a small verifier outperform a new agentic harness.

## Phase 0 — Historical engineering escapes, no LLM

**Sample:** aim for 20–30 known historical engineering misses/escapes representing different subsystems and change types. Use publicly releasable or permissioned material only; do not publish confidential graphs.

For each event, reconstruct:

1. The engineering graph **as it stood before the missed impact was discovered**—not the cleaned-up current model.
2. The relevant change, pinned roots, authorized visibility, and scope that were knowable at the time.
3. The missed dependency or trace relation and whether it was explicit, inferable only from another source, or absent.
4. The historical consequence and the evidence quality of the reconstruction.

Classify the missed dependency:

| Class | Definition | What it means for the proposed gate |
|---|---|---|
| A — Present, reachable | Correct root, authorized scope, and modeled relation expose it | Traversal/obligation checks may help |
| B — Present, excluded | Relation existed but configured root or scope missed it | Scope governance may help |
| C — Absent from baseline | Dependency or trace link did not exist in the historical model | Traversal coverage cannot find it |
| D — Indeterminate | Historical evidence is insufficient | Exclude from efficacy numerator; report uncertainty |

Record independent reviewer classifications and disagreement. Avoid changing historical graphs to make the proposed solution look effective.

### Phase 0 stop/reframe decision

If a large share of meaningful escapes are **Class C**, or there is no reliable access to as-of-time graphs, stop treating exhaustive traversal as the main value proposition. Reframe toward model-quality assurance, trace-link discovery, or existing tool integrations. Set the final quantitative threshold before analyzing outcomes; a suggested initial sensitivity scenario is 50% Class C, **not** a pre-registered or validated cutoff.

Publish a summary with counts, exclusions, uncertainty, and anonymization decisions. **No Phase 0 dataset or outcome exists in this repository yet.**

## Phase 1 — Competing baselines

Use the same frozen graph and tasks to compare:

- **Baseline A:** standard MBSE search and requirements traceability tools.
- **Baseline B:** deterministic graph queries plus a generated checklist; no LLM.
- **Baseline C:** a general-purpose coding/agent tool configured with retrieval, prompts, and existing permissions.
- **Baseline D:** a managed agent/workflow platform with approval and policy components.
- **Candidate E:** a minimal graph-coverage and evidence-receipt extension.
- **Candidate F:** a new harness only if preceding baselines leave a material gap.

Measure total cost of ownership, deployment friction, coverage of explicit obligations, permission failures, time, and reviewer workload.

## Phase 2 — Purposefully adversarial test corpus

Inject cases where:

- A root name resolves to the wrong entity.
- The agent sees every required ID but provides vacuous analysis.
- An essential graph edge is missing entirely.
- The agent explores a valid extra branch beyond scope.
- A sibling model establishes a misleading local pattern.
- A retrieved document instructs the model to override policy or consent text.
- The graph or permissions change between review and execution.
- Budget is exhausted mid-walk.
- A batch of individually permissible actions has an unsafe combined effect.
- A read-only report encourages an incorrect engineering sign-off.

Expect **inconclusive/failed** where the assurance contract cannot be met. A percentage without scope and evidence limits is not a meaningful success metric.

## Phase 3 — Humans in the loop

Recruit reviewers with relevant engineering experience where feasible. Randomize equivalent tasks with and without a coverage badge and with differing evidence presentation formats.

Measure:

- Mistakes correctly identified and missed, including false negatives.
- Incorrect sign-offs, unsafe waivers, and reviewer complacency.
- Time to decision, additional review hours, and disagreement.
- Whether critical issues are overlooked when all findings are acknowledged together.

The one-packet-per-action design is a **policy hypothesis**; test whether it invites rubber-stamping. Consider risk-ranked summaries and separate role-bound waivers.

## Phase 4 — Economics and qualification boundary

Evaluate **net**, not gross, economic effect:

```text
Net benefit = avoided engineering rework
            - incremental review labor
            - integration, inference, operating, and maintenance costs
            - training and qualification overhead
```

For safety-critical domains, separately investigate applicable regulatory and process expectations (e.g. tool qualification). A research prototype is not a qualified development or verification tool.

## Evidence publication rules

For each claim, maintain the dataset version, graph snapshot identifier, frozen scope definition, test code or query, expected result, observed result, and limitations. Report failures and unresolved disagreements alongside successes. Keep proprietary inputs out of the public repository.

**Decision principle:** a small extension that meets the actual need is a win, even if the proposed general-purpose harness is never built.

---

[Read the critique]({{ '/adversarial-review/' | relative_url }}) · [Assurance boundaries]({{ '/assurance-boundaries/' | relative_url }}) · [Roadmap]({{ '/roadmap/' | relative_url }})

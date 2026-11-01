---
layout: default
title: Assurance boundaries
permalink: /assurance-boundaries/
description: What the proposed verification contract can and cannot establish.
---

# Assurance boundaries

*Working constraints, not demonstrated guarantees · November 2026*

The research should be judged on a narrow, explicit claim: **given an authorized, frozen, correctly resolved model snapshot and a precisely defined obligation set, can a deterministic checker verify that the required inspections produced structured evidence?**

That is not equivalent to certifying an engineering change as safe, proving all dependencies exist, or knowing an agent understood each object.

## 1. Graph coverage is conditional on graph completeness

An agent could walk every modeled edge and still miss a dependency that was never modeled. A faulty root resolver or too-narrow scope could also produce a misleading 100% figure.

**Proposed control:** roots and traversal scope are pinned by the control plane or approved reasoning profile; any attempted deviation is recorded. Enumerate the required nodes and applicable relations from the frozen graph. Check structured result records, not repeated IDs or a generic “complete” statement.

**Remaining gap:** there is no general proof that the source graph includes real-world engineering relationships. Historical engineering escapes and cross-source checks—not a traversal badge—must test that assumption.

## 2. The harness must own obligations

When the harness can compute a required set, it should present or assign each obligation to the agent and verify the resulting evidence record. It need not rely on the model to discover every node on its own.

A simple proposed contract is:

```text
Approved snapshot + pinned roots + scope policy
        -> deterministic obligation enumerator
        -> required node / relation set R
        -> structured inspection records V
        -> gate checks R ⊆ V, validity, provenance, and freshness
        -> report excess exploration separately
```

**Present in scope** is not the same as **meaningfully analyzed**. Required result schemas and deterministic validity checks must be domain-specific. An exhaustive-looking report could still be semantically wrong.

## 3. Source trust does not improve merely because an LLM classified it

Untrusted source text can contain instructions to the agent and to downstream reviewers. Classification is a diagnostic signal, not permission to promote source content into trusted instructions.

A deterministic label-propagation policy should preserve the most restrictive applicable source constraints. Consent displays must be rendered from trusted action schemas, immutable parameters, and escaped, labeled findings—not from model-authored instructions pretending to describe an authorized operation.

## 4. Findings, acknowledgements, and authority are distinct

For each **individual side-effecting action**, the human receives one review packet containing the classified findings for that action. A single acknowledgement may register that the packet was seen, including high or critical findings, but it never modifies permissions.

Acknowledgement is not the same as permission, and some waiver classes require a separate risk owner or another legally required role. Read-only answers can disclose uncertainty without demanding an acknowledgement. Plans and batches also need combined-effect analysis, even when individual steps appear harmless.

## 5. Preauthorization and execution re-checks

Permission denial may stop evaluation before exposing model content or findings. Authorized requests can be evaluated and reviewed; the exact action is authorized again just before execution. A post-execution discovery cannot retroactively block an action already performed; it requires incident, remediation, or follow-up handling.

## 6. Limits, visibility, and stale evidence

A budget interruption, timeout, denied edge, hidden object, stale snapshot, solver `UNKNOWN`, or inconclusive classifier is an **incomplete result**. It must not be scored as pass or rounded up to 100%.

A completeness statement is relative to what the authorized actor could see, and must not reveal restricted counts or identities to another actor.

## 7. “Verified,” “attested,” and “proof-carrying” mean different things

- **Verified under contract:** checks passed for the explicitly scoped contract, inputs, and snapshot.
- **Attested:** use only where the evidence record's integrity, origin, and signing/verification mechanism are specified and exercised.
- **Proof-carrying:** avoid claiming formal proof or cryptographic protection without actual formal artifacts, relevant assumptions, and tamper-evident verification.

The SysML v2 file declares proposed requirements and test cases; that is not evidence that the tests have run or that the system exists.

## 8. The human reviewer is in the threat model

A green badge may increase overconfidence and reduce independent scrutiny. The pilot must measure reviewer error, false reassurance, decision time, and downstream misses—not just how often a graph algorithm returns a correct set.

---

**Next:** [Proposed validation protocol]({{ '/validation/' | relative_url }}) · [White paper]({{ '/whitepaper/' | relative_url }}) · [Adversarial review]({{ '/adversarial-review/' | relative_url }})

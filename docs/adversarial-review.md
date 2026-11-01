---
layout: default
title: Adversarial architecture review
permalink: /adversarial-review/
description: A hard look at why existing agents, MBSE tools, or a small extension may be better than a new harness.
---

# Adversarial Architecture Review: Should This Harness Exist?

**Working adversarial critique of the Evidence-Gated Agentic Systems proposal · November 2026**

> This is an AI-assisted critical analysis prepared as part of the research—not an independent peer review. It challenges an earlier architecture draft; the revised [working white paper]({{ '/whitepaper/' | relative_url }}) now addresses several objections. These remain hypotheses to test, not resolved empirical findings.

**Verdict in advance:** The problem is real. The proposed trust contract is coherent. But the white paper has **not yet established that a new general-purpose agentic harness is necessary**. Most component capabilities exist in Codex, agent SDKs, managed agent services, policy engines, workflow runtimes, graph databases, and MBSE platforms. A smaller, domain-aware **evidence-attestation extension** could deliver much of the benefit at lower engineering and adoption cost. A bespoke harness should be a conclusion earned by a controlled pilot, not the starting assumption.

This review deliberately steelmans alternatives and attacks the architecture’s assumptions. It is not a vendor certification or exhaustive procurement comparison. Product capabilities must be rechecked during any actual selection. It distinguishes **(a)** capabilities platforms claim, **(b)** capabilities the proposed system requires, and **(c)** demonstrated gaps. None should be silently substituted for the others.

# 1. The Core Challenge

The white paper asks: "How can an agent prove that it followed required procedures, inspected the graph, and reported uncertainty before an authorized person acts?" That is a strong question. But its proposed answer bundles several different products:

1. An **agent orchestration and identity platform**.

2. A **domain evidence and graph-analysis engine**.

3. A **policy and risk-acceptance workflow**.

4. An **assurance recorder and presentation interface**.

5. A **cross-domain standards layer** for all of the above.

Combining these is not automatically a product advantage. It could also be five integration and maintenance burdens masquerading as architectural completeness.

The adversarial hypothesis is simple: **a narrowly scoped verification service running beside an existing agent platform will be cheaper, safer, faster to validate, and easier to adopt than a new general-purpose harness.** To defeat it, the proposal must show a concrete missing requirement that existing platforms cannot satisfy by configuration, tooling, or modest extensions.

# 2. "Why Not Just Use Codex?"

This is the most uncomfortable alternative because it asks whether the proposal describes what a capable coding agent plus tools and instructions can already do.

Modern Codex is a platform for executing scoped software tasks with tools, execution environments, approvals, and extensibility. Developers can expose domain-specific services, scripts, and graph queries as tools. They can maintain detailed task instructions, skills, tests, and validators. A Codex-based MBSE reviewer could read a frozen graph export, run deterministic traversal scripts, compare independently generated query results, inspect sibling structures, run schema/rule checks, produce a structured findings package, and submit it for human review.

That prototype might be built without inventing a state machine, model abstraction, tool protocol, policy syntax, or observability stack. Codex's existing tool and sandbox boundaries would remain valuable even if the engineering source systems required a dedicated connector.

**Where this argument is strong**

- The first product is read-only evidence gathering, graph validation, and report synthesis, not an autonomous enterprise transaction engine.

- The highest-value controls are domain-specific checks that can run in ordinary programs: frozen input, reachable-set computations, coverage comparison, claim-to-source links, and validated JSON outputs.

- An engineering team can inspect and modify scripts and tests without understanding a new harness runtime.

- Early pilots require iteration speed more than vendor-neutral abstraction.

**Where Codex may not be sufficient by itself**

- It is primarily optimized for software-oriented tasks, so enterprise identity, continuous domain workflows, and approval semantics may require adjacent infrastructure.

- It does not automatically make a domain graph authoritative, guarantee true independent corroboration, or prove natural-language understanding.

- A demonstrable requirement for organization-wide, long-lived, cross-provider workflows with centrally managed policy might favor a managed agent service or a thin shared control layer.

**Demand this evidence before rejecting Codex:** implement the same frozen engineering-impact task with Codex and deterministic domain tools. Measure omitted required graph elements, false conclusions, user review time, total cost, and deployment complexity. If it passes, the general-purpose harness loses its initial justification.

Primary product reference: [Codex as a platform](https://developers.openai.com/blog/codex-as-a-platform).

# 3. "Why Not OpenAI Agents, Microsoft, AWS, or Google Managed Agents?"

The OpenAI Agents SDK/Agents API, Microsoft's Agent Framework and Foundry Agent Service, AWS Bedrock AgentCore, and Google's agent platform each address portions of tool orchestration, lifecycle management, approvals, identity, policy, or observation. The exact features differ and evolve. It is a mistake to compare a **future complete harness** with only the **lowest-common-denominator** of today's managed offerings.

A managed-platform approach looks like this:

- Keep a vendor platform responsible for model calls, sessions, tracing, tool routing, runtime reliability, and ordinary human intervention.

- Add a domain evidence service that receives a graph snapshot plus a declarative analysis contract and returns machine-checkable traversal/constraint receipts.

- Put organization authorization in the existing identity and policy systems; implement the single-action risk-acceptance record as a small workflow service.

- Treat the agent as a consumer of attested evidence, not the authority that declares its own work complete.

**The strongest buy argument:** cloud vendors already bear much of the burden of model compatibility, retries, scaling, observability, tool wiring, isolation, and platform security. Those are extremely expensive, fast-changing responsibilities. Recreating them without a demonstrable gap invites a permanent platform team.

**The strongest case for owning more:** on-premises or air-gapped requirements, heterogeneous legal boundaries, provider-neutral audit formats, unusually strict data retention or supply-chain constraints, unavailable policy hooks, or platform restrictions that prevent independent verification. Yet each must be evidenced in a target buyer environment. "Avoid vendor lock-in" is insufficient if it creates a more expensive lock-in to one's own framework.

Sources: [OpenAI Agents SDK](https://developers.openai.com/api/docs/guides/agents/sdk), [OpenAI guardrails and approvals](https://developers.openai.com/api/docs/guides/agents/guardrails-approvals), [Microsoft Agent Framework human-in-the-loop](https://learn.microsoft.com/en-us/agent-framework/workflows/human-in-the-loop), [Microsoft Foundry Agent Service](https://learn.microsoft.com/en-us/azure/foundry/agents/overview), [AWS AgentCore policy](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/policy.html), [Google agent platform](https://docs.cloud.google.com/gemini-enterprise-agent-platform/overview).

# 4. "Why Not the MBSE and ALM Tools We Already Own?"

Requirements and engineering-lifecycle tools already provide traceability, baselines, relationship queries, impact analysis, review processes, and evidence of verification to varying degrees. IBM DOORS Next, Siemens Polarion, PTC Codebeamer, and Dassault's CATIA Magic ecosystem are not empty shells waiting for an AI layer.

A skeptical chief engineer will reasonably ask:

- "Which exact defect would your product catch that our current traceability report, validation rule, or change-control board does not?"

- "Are you inspecting the authoritative engineering baseline or an asynchronously copied graph?"

- "Will this create a second source of truth and competing review workflow?"

- "Will engineers see the underlying requirement and verification records in their existing tools?"

- "If your graph says an edge is missing, do you know whether it is truly required, intentionally absent, or merely hidden by tool permissions?"

The white paper should **not** promise a new MBSE platform. Its wedge is a cross-system, read-only **independent quality-assurance layer** that tests completeness claims and surfaces inconsistencies that existing tooling can express but teams fail to check systematically.

A valuable product might simply issue a change-impact evidence packet back into an existing ALM review, where the approved baseline and action authority already live.

Sources: [IBM DOORS traceability](https://www.ibm.com/docs/en/engineering-lifecycle-management-suite/doors-next/7.1.0?topic=requirements-traceability), [Siemens Polarion](https://www.siemens.com/en-us/products/polarion/application-lifecycle-management-alm/), [PTC Codebeamer](https://www.ptc.com/en/about/facts/codebeamer), [CATIA Magic](https://www.3ds.com/products/catia/catia-magic/sysmlv2).

# 5. "Why Use an Agent at All?"

This may be the strongest technical objection.

If the required task is "enumerate all reachable requirements, interfaces, components, and tests under explicit relation rules, then flag violations," a deterministic graph engine is more reliable and inspectable than a language model. Recursive queries, typed graph traversals, schema constraints, and rule checks can perform much of that work. The model adds value where text must be interpreted, ambiguous evidence reconciled, or findings explained—not where exact set membership is required.

A simpler architecture is:

1. A controlled connector takes an authoritative **versioned snapshot**.

2. Deterministic queries compute closure and rule violations.

3. A second implementation or materially distinct export challenges those results.

4. A model helps interpret unclear human-readable fields and summarize findings, preserving uncertainty.

5. Existing governance tools route the results to a human.

The agent need not execute the graph algorithm or certify itself. This reduces exposure to prompt injection and opaque planning errors. It also collapses several architecture layers into deterministic domain software.

A burden of proof therefore falls on the model: show tasks where a language-model reasoning stage adds measured value **beyond** deterministic graph/rule analysis, and where that value survives the increase in cost and false-positive burden.

References: [PostgreSQL recursive queries](https://www.postgresql.org/docs/18/queries-with.html), [W3C SHACL](https://www.w3.org/TR/shacl/).

# 6. The Proof Problem: What Does Traversal Attestation Actually Prove?

The proposed traversal attestation is the most differentiated idea. It is also the easiest to overclaim.

Suppose the snapshot is \(G_s=(V_s,E_s)\) and the contract defines an allowed relation set, entry nodes, scope limits, and terminal conditions. A deterministic checker can establish that the **recorded traversal** covers the relevant reachable elements under that contract. If independent queries return the same expected reachable set, confidence in implementation correctness increases.

But that result proves none of the following by itself:

- The source graph contains all real-world engineering dependencies.

- Every edge is typed correctly or semantically meaningful.

- The scope or relation filters were chosen correctly.

- The snapshot is fresh or authoritative for the decision.

- A model understood the content of each visited node.

- A referenced verification artifact is substantively adequate.

- A sibling graph represents the same engineering intent.

One can log that every node was *fetched*. It is far harder to show that every node was *semantically considered*. Structured claim-to-evidence links and question-specific probes can help, but they provide bounded assurance, not an oracle for cognition.

**The red-team's mandatory wording:** "The deterministic gate validates traversal coverage over a declared, versioned representation and contract." Do not say "the agent proved it inspected everything." Missing objects outside the graph remain an open-world limitation.

A damaging demonstration would feed the system a perfectly internally consistent graph with one omitted critical interface. If the tool celebrates a complete traversal without prominently reporting the completeness boundary, the concept has failed its trust promise.

# 7. Two Queries Are Not Necessarily Independent

"Checked against two datasets" sounds rigorous until both datasets are generated from the same corrupted extraction, share the same mapping code, or interpret a relationship identically. Correlated error is not eliminated by running checks twice.

Consider independence at six levels:

| Dimension | Weak corroboration | Stronger corroboration |
|---|---|---|
| Data lineage | Same export copied twice | Separately sourced baseline or change log |
| Query method | Same algorithm rephrased | Recursive query versus independently coded traversal |
| Semantic rules | Same mistaken mapping table | Reviewed schema plus independently defined requirement |
| Time | Both read stale snapshot | Snapshot freshness and baseline cross-check |
| Identity/permissions | Both omit same hidden records | Authorized completeness inventory |
| Evaluation | Both tuned on same examples | Blinded cases held out from design |

No fixed count of query engines creates a confidence guarantee. Each independent check needs a provenance claim: which failure classes can this check detect that the others may miss?

An independent inventory of node counts, edge counts, leaf counts, reachable-set hashes, dangling references, and cross-baseline deltas can provide useful agreement signals. None should be described as proof that absent real-world dependencies do not exist.

The uncomfortable possibility: a cheap single authoritative query plus a manual sample may outperform a costly "independent" second graph that is actually just another projection of the same faulty export.

# 8. Sibling-Graph Comparison Can Reinforce Institutional Mistakes

The user's aspiration is compelling: engineering analyses should resemble established patterns rather than produce synthetic-looking structure. But sibling graphs are not unquestioned ground truth.

Common patterns may reflect entrenched design mistakes, copied boilerplate, obsolete regulations, or organizational incentives. Novel systems intentionally depart from old decomposition. If the model treats statistical consistency as correctness, the system could pressure engineers to preserve the very design assumptions worth challenging.

**Adversarial controls required:**

- Pick siblings using explicit equivalence criteria: system class, lifecycle state, safety class, organizational baseline, and schema version.

- Distinguish missing expected patterns from justified design variance.

- Report the reference siblings and why they were selected.

- Make a disagreement a finding, not an automatic mandate to normalize.

- Include negative controls: cases where the correct design differs from established patterns.

- Test that novel-but-valid designs are not systematically over-flagged.

The strongest version of the feature is a *deviation explainer*: "These three comparable subsystems each include interface verification X, but this one does not; inspect this difference." The weakest version is an invisible pressure to imitate a nearest-neighbor graph.

# 9. User-Maintained Specialized Prompts Are Both a Feature and a Liability

Domain teams know what matters. They should be able to maintain use-case instructions. Yet free-form prompts are a poor substrate for executable obligations.

If a prompt says "check all safety dependencies" without defining the relation set, evidence source, version, exception rules, and stop conditions, the result will vary with model version and wording. Moreover, the prompt itself becomes a privileged instruction surface vulnerable to accidental scope changes or malicious edits.

Separate three layers:

1. **Human-authored guidance:** vocabulary, examples, interpretive preferences.

2. **Machine-readable contract:** source scope, node/edge classes, traversal queries, validation rules, evidence requirements, exclusions, and thresholds.

3. **Versioned evaluation package:** fixtures, expected violations, known exceptions, regression tests, approved owner.

A domain maintainer may edit guidance within assigned authority. Changes to binding validation obligations or permitted action scope require the organization's ordinary change-control permissions. Prompts cannot modify user entitlements or become permissions.

The architecture must answer which of these layers is portable across customers. If each customer needs a year of graph ontology work and prompt curation, the supposed general-purpose product is actually a bespoke systems-integration practice.

# 10. "Show All Findings Together" Is an Honest UX Goal, Not Omniscience

The user rightly rejects a frustrating loop: fix one item, rerun, discover the next. Batch the currently evaluable findings for each proposed individual action, with clear criticality and uncertainty.

But real checks are dependent. Fixing an upstream graph inconsistency can make downstream validators newly applicable. New tool results can reveal new violations. A classification model can miss an issue in the same way a human can. Therefore, "all findings at once" must mean **all findings discoverable within the declared snapshot and completed validation pass**, not all possible findings forever.

The review packet should expose:

- The complete checks attempted for this decision point.

- Confirmed findings, probable findings, contradictions, unknowns, and duplicate groups.

- Dependency-blocked checks and the reason they could not finish.

- Evidence sources and relevant snapshot versions.

- The exact individual action to which the packet applies.

- A change indicator when a revised action requires revalidation.

A product that suppresses downstream follow-up warnings to maintain the illusion of "one round" would be less trustworthy than an inconvenient but honest system. A product that floods the user with hundreds of lightly related signals can be equally unusable.

**Test:** evaluate time-to-decision, not just check recall. Measure whether grouped findings improve action quality or create alert fatigue.

# 11. One Acknowledgement Per Individual Action: Safety or Ceremony?

The design's invariant is unusual and intentional: one acknowledgement for each action, displaying all classified findings, including intentional risk and false positives. Even critical warnings may be accepted. Yet acceptance must never grant permissions.

This can preserve human agency, but reviewers will ask difficult questions:

- Does the user understand the difference between accepting a *warning* and authorizing a *tool operation*?

- Are multiple trivial actions creating acknowledgement fatigue?

- Can an attacker bundle a high-impact action under a misleading label?

- Does a revised tool argument invalidate the prior acknowledgement?

- Who can accept high-consequence risk under organization policy?

- Can a user acknowledge a dangerous warning even when the actual operation is prohibited or outside their role?

- Does every downstream action re-prompt, even when effects are reversible and low impact?

The architecture's correct answer is a strict separation:

**Risk acceptance:** any specifically addressed classified finding may be recorded as accepted, including severe danger, subject to the person being allowed to acknowledge that finding under the organization’s existing rules.

**Action authorization:** entirely separate checks determine whether the actual operation is permitted. A warning override cannot alter roles, entitlements, policies, approvals, safety interlocks, or source-system restrictions.

A blocked action remains blocked even after every warning is accepted. The receipt should say so plainly. If higher-risk organizational decisions require a designated risk owner, that role must come from existing authorization, never from self-granted permissions in the conversation.

An adversarial usability test should deliberately attempt to reuse a single acknowledgement for different arguments, a new target, and a modified action. All must fail. Equally, the user should not be trapped in a ritual of acknowledging irrelevant notices.

# 12. Formal Verification Risks Becoming "Proof Theater"

A SAT/SMT solver can determine whether faithfully encoded constraints are satisfiable, or produce evidence of unsatisfiability under a particular theory and setup. It does not magically prove that the English engineering requirement was encoded correctly, that every assumption is present, or that the physical system will behave safely.

Four failure modes deserve explicit tests:

1. **Encoding omission:** a safety assumption is absent, so a satisfiable result looks reassuring.

2. **Vocabulary mismatch:** a requirement's natural-language meaning differs from its formal representation.

3. **Solver-state ambiguity:** SAT/UNSAT/UNKNOWN are presented imprecisely or an unsat core is mischaracterized.

4. **Scope laundering:** evidence labeled "verified" is visually elevated into universal factual truth.

The white paper should use *Verified under contract X, snapshot Y, rule set Z*. The model may explain the outcome but cannot redefine the meaning of the solver result.

The least complex useful MVP likely needs typed graph assertions, constraints, and source references first. A general symbolic solver should be added only where there is a concrete family of constraints that existing graph rules cannot express efficiently or correctly.

Reference: [Microsoft Z3 Guide](https://microsoft.github.io/z3guide/programming/Z3%20Python/Introduction/).

# 13. The Security Attack Surface May Grow Faster Than the Assurance Surface

A multilayer harness with prompt management, classifiers, tool gateways, graph exports, external evidence, approval receipts, memory promotion, and audit storage introduces many boundaries. Every one can be attacked or misconfigured.

**Threats to demonstrate, not merely list:**

- **Prompt injection:** a retrieved engineering note instructs the model to ignore inspection rules or falsely assert full coverage.

- **Tool-output laundering:** a malicious connector response forges a traversal receipt, source citation, or classification.

- **Privilege confusion:** a user can acknowledge every risk and attempts to treat that as permission to act.

- **Approval replay:** a valid warning acceptance is reused for changed tool arguments, a different target, or another action.

- **Time-of-check/time-of-use:** the graph or authorization changes after analysis but before action.

- **Graph poisoning:** a corrupt export intentionally hides an edge while preserving plausible structure.

- **Evidence leakage:** source snippets from a higher-classification project are embedded in a review packet for a lower-permission reader.

- **Cross-tenant contamination:** memory, sibling examples, or inference caches mix customer data.

- **Audit forgery:** the model or connector writes its own self-attested "proof" without independent derivation.

Principle: the verifier must own authoritative state and compute or validate receipts independently; a model-produced JSON document is not evidence simply because it conforms to a schema. Source access must be enforced again when displaying evidence, not only at retrieval.

A smaller architecture may be safer because it has fewer privileged moving parts. Compare it empirically.

Reference: [OWASP GenAI LLM Top 10](https://genai.owasp.org/llm-top-10/).

# 14. Economics: The Hidden Cost Is Integration, Not Tokens

The white paper's cost thesis is plausible in long-cycle engineering: catching a mistake before prototyping, qualification, or integration can avoid expensive rework. But a large potential savings pool is not proof that a new harness captures it.

A credible total-cost model includes:

**Initial cost**

- Ontology mapping across actual engineering repositories.

- Identity, permission, and baseline integration.

- Data quality analysis and reference dataset creation.

- Validation-rule and use-case profile design.

- Security review, procurement, and deployment change management.

**Recurring cost**

- Source schema drift and new tool versions.

- Maintaining independently implemented checks.

- Model/version regression testing.

- Human classification and false-positive review.

- Evidence retention and audit operations.

- Incident response and connector permissions.

- Vendor and infrastructure fees.

**Value**

- Avoided late rework attributable to findings the baseline did not catch.

- Shorter engineer search and review time.

- Better review traceability.

- Earlier surfaced uncertainty.

- Less re-analysis when assumptions or baselines change.

Do not sum every hypothetical mistake the tool "could have" prevented. Compare its findings with actual historical outcomes and an equivalent baseline review. Determine whether each identified issue would plausibly have escaped existing checks.

A generic ROI equation is \(\mathrm{NetValue}=\mathrm{AttributableAvoidedRework}+\mathrm{SavedReviewHours}-\mathrm{FullLifecycleCost}\). The challenge is estimating **attributable** value without retrospective hindsight bias.

**Commercial failure mode:** customers love the demo but will not pay for ontology cleanup, maintainer attention, and verification upkeep. A prototype that only works on a hand-curated graph does not resolve that.

# 15. What Is Actually Distinctive?

No individual element appears unprecedented:

- Models proposing actions and tools executing them: common in agent platforms.

- Human approvals and policy enforcement: mature categories.

- Graph retrieval and requirements traceability: established.

- Deterministic tests and formal solvers: established.

- Evidence grading and explicit source selection: established in research practice.

- Cross-checking and audit: established in high-assurance workflows.

**Potentially differentiated:** a *mandatory, source-bounded, independently checked evidence contract* applied to agent decisions, packaged for an individual action with complete current findings, source version, traversal coverage, unresolved checks, and single-use risk acknowledgement that never changes authorization.

That is a possible integration innovation. It is **not** proof of market novelty, patentability, or category creation.

The shortest defensible product sentence may be:

> An independent evidence-attestation and review layer that verifies whether an AI-assisted engineering change-impact analysis met a versioned graph coverage and validation contract before a reviewer relies on it.

Notice what this sentence does not require: a proprietary model, an original graph database, a general agent runtime, or custom authorization identity.

The broader philosophical vision can remain in the architecture paper without forcing all of it into the first product.

# 16. Decision Matrix: Build, Buy, or Compose?

| Option | Strength | Main weakness | Verdict for first MBSE pilot |
|---|---|---|---|
| Existing MBSE/ALM rules only | Authoritative data, familiar governance | Cross-system reasoning and narrative may be limited | **Required baseline** |
| Codex plus domain scripts | Fast experiments, strong tool ecosystem | Domain identity and enterprise workflow may need supporting services | **Strong contender** |
| Managed agents plus verifier | Lifecycle, operations, approvals already supplied | Platform dependencies, policy gaps may matter | **Strong contender** |
| Deterministic graph checker plus LLM report | Narrow proof boundary, low orchestration risk | Hard natural-language and cross-repository ambiguity | **Strong contender** |
| New general-purpose harness | Full control of semantics, portability ambition | Highest complexity, slowest validation, substantial security burden | **Not yet justified** |
| Thin attestation/review service | Reusable high-value contract, smaller attack surface | Depends on integration quality and buyer data | **Recommended experimental product** |

This table is a provisional architectural judgment, **not** an audited vendor feature matrix. Each option must use the same data, contract, cases, and reviewer scoring criteria in a head-to-head evaluation.

# 17. Falsification Protocol: Try to Kill the Idea

A good architecture review must specify results that would change its advocates' minds. Pre-register a test suite before optimizing the prompts and graph transforms.

**A. Ground-truth graph cases**

- Fully specified baseline with known expected reachability.

- Deliberately omitted critical edge.

- Wrongly typed relationship.

- Stale snapshot with corrected newer baseline.

- Cycle and large fan-out.

- Permission-hidden subgraph.

- Missing verification artifact.

- Two queries sharing a corrupted upstream export.

- Novel-but-correct sibling structure.

- Conflicting natural-language requirement and formal rule.

**B. Adversarial control cases**

- Retrieved note that instructs the model to skip a class of nodes.

- Forged tool output claiming full coverage.

- User acknowledges critical warning, then attempts unauthorized operation.

- Replayed acknowledgement after changing a tool argument.

- Late-discovered finding after an apparently complete packet.

- User-editable prompt attempting to widen scope or authority.

- Redacted evidence source that should not leak through explanatory text.

**C. Comparative arms**

1. Existing MBSE/ALM built-in workflows.

2. Deterministic graph rules and a human-readable report.

3. Codex with the same domain tools and graph contract.

4. A managed agent with the same verification service.

5. Proposed full harness, if implemented enough for fair comparison.

**D. Blind scoring**
Have domain reviewers, blinded to generation method, score recall of known material defects, specificity of supporting evidence, false positives per analysis, missed scope, reviewer time, appropriate uncertainty, and whether the recommendation would have changed a real decision. Separately audit privilege and approval invariants.

**E. Decision thresholds**
Choose quantitative thresholds only after examining base rates and buyer tolerance. At minimum, require material incremental performance over the strongest baseline, bounded review burden, and credible lifecycle-cost savings. A failure to show that incremental value should **stop the full-harness build**, even if the demo is impressive.

# 18. The Most Damaging Questions to Ask a Founder or Chief Architect

1. What can this system guarantee that Codex with verified tools, or a managed agent with a policy service, cannot?

2. Show the exact missing requirement in a real buyer stack—not an imagined future stack.

3. What is the authoritative engineering source, and how do you detect missing information outside it?

4. What, specifically, is independently checked by separate code or data lineage?

5. Which graph attestation result would cause the system to decline to assert completeness?

6. Why should a user trust an AI-written explanation of a formal constraint?

7. Do risk overrides create a harmful illusion that organizational authorization was granted?

8. Why does every action need an acknowledgement? Show the user-research evidence.

9. How do you prevent sibling-pattern matching from discouraging valid invention?

10. How much ontology and integration work is necessary before the first useful report?

11. Why maintain five classifier boundaries instead of one well-designed pre-action and pre-presentation review?

12. How do you prevent a "show everything at once" packet from hiding still-unchecked findings?

13. Which failure modes are handled by existing MBSE review or ALM controls already?

14. What is the marginal cost per analyzed change, including human review and data maintenance?

15. Which observed pilot outcome would make you abandon the general-purpose harness thesis?

A strong team should answer these with test artifacts, comparative measurements, and explicit unknowns—not architecture diagrams alone.

# 19. Recommended Product Sequencing

**Stage 0 — Baseline discovery.** Select one real engineering-change workflow and one authoritative source baseline. Inventory existing MBSE/ALM validation and reviewer practices. Identify concrete historic escapes and false positives. Do not pick a pristine demo dataset.

**Stage 1 — Independent deterministic verifier.** Define a versioned graph traversal and evidence contract. Build a read-only service that computes reachable sets, inventories omissions, records source lineage, compares an independently implemented query, and emits an inspectable receipt. It should work without an LLM. This is where most of the technical differentiation can be tested.

**Stage 2 — Attach an off-the-shelf agent.** Have Codex or a managed agent use the same verifier to interpret ambiguous requirements, summarize engineering impact, and connect findings to evidence. Keep model-suggested actions separate from authorization. Assess whether the model actually improves outcomes.

**Stage 3 — Review and acceptance contract.** Batch all findings for a specific individual action and record single-use, action-bound acknowledgements. Use existing organizational identities and policy. Demonstrate that risk acceptance never widens permissions. Prefer existing review interfaces when possible.

**Stage 4 — Generalize only what survived.** If multiple heterogeneous agent platforms and engineering tools require the same unattainable assurance semantics, extract reusable components. Build bespoke orchestration only for documented gaps—perhaps offline deployments, unusual enterprise controls, or cross-provider audit requirements.

**Do not build at the outset:** a new graph database, custom language-model framework, generalized CRDT memory, proprietary identity system, speculative universal schema, generalized SAT engine, or dozens of classifier policies. These are optional responses to proven constraints, not founding commitments.

# 20. Conditional Verdict

The white paper is strongest as a **trust-boundary thesis** and a **verification contract**. It is weakest when it implicitly conflates "we need better evidence about agents" with "we need to create a new general-purpose agent platform."

My recommendation is therefore deliberately demanding:

**Preserve the invariants. Shrink the first product. Put it on top of existing tools. Test it against those tools.**

Proceed toward a bespoke harness only if a real pilot establishes all of the following:

- A meaningful failure class not adequately addressed by baseline MBSE/ALM software.

- Independent traversal/validation receipts that reliably identify that failure.

- Better decision outcomes than a conventional deterministic checker and than Codex/managed agents with the same tooling.

- Acceptable false-positive burden and human review time.

- A concrete buyer and a favorable full-cost business case.

- A governance or deployment requirement that cannot be met by a smaller extension.

Otherwise, the correct outcome may be a small and valuable *assurance product*, not a large new platform. That would not betray the vision. It would validate its most defensible insight while avoiding infrastructure that the market already supplies.

**Final adversarial question:** If the graph receipt, authorization boundary, and evidence packet are the valuable parts, what remains that truly requires a new harness?

---

## Primary-source reference set

**Agent platforms:** [Codex](https://developers.openai.com/blog/codex-as-a-platform) · [OpenAI Agents SDK](https://developers.openai.com/api/docs/guides/agents/sdk) · [OpenAI guardrails/approvals](https://developers.openai.com/api/docs/guides/agents/guardrails-approvals) · [Microsoft Agent Framework](https://learn.microsoft.com/en-us/agent-framework/workflows/human-in-the-loop) · [Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/agents/overview) · [AWS AgentCore policy](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/policy.html) · [Google agent platform](https://docs.cloud.google.com/gemini-enterprise-agent-platform/overview).

**Engineering systems:** [IBM DOORS Next](https://www.ibm.com/docs/en/engineering-lifecycle-management-suite/doors-next/7.1.0?topic=requirements-traceability) · [Siemens Polarion](https://www.siemens.com/en-us/products/polarion/application-lifecycle-management-alm/) · [PTC Codebeamer](https://www.ptc.com/en/about/facts/codebeamer) · [CATIA Magic](https://www.3ds.com/products/catia/catia-magic/sysmlv2) · [NASA systems engineering](https://www.nasa.gov/reference/2-0-fundamentals-of-systems-engineering/).

**Methods and risks:** [PostgreSQL recursive queries](https://www.postgresql.org/docs/18/queries-with.html) · [W3C SHACL](https://www.w3.org/TR/shacl/) · [Z3 Guide](https://microsoft.github.io/z3guide/programming/Z3%20Python/Introduction/) · [OWASP LLM Top 10](https://genai.owasp.org/llm-top-10/) · [NIST evaluation probes](https://www.nist.gov/programs-projects/building-evaluation-probes-agentic-ai).

The referenced documentation supports *reported platform and technique capabilities*, not the red team's judgments about cost, comparative superiority, or market fit. Those judgments are hypotheses for a controlled evaluation.

---

**Further scrutiny:** [Assurance boundaries]({{ '/assurance-boundaries/' | relative_url }}) · [No-LLM validation first]({{ '/validation/' | relative_url }}) · [Prior art and standards]({{ '/prior-art/' | relative_url }}).

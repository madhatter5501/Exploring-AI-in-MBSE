---
layout: default
title: References and prior art
permalink: /prior-art/
description: Standards, methods, platforms, and primary research to test the proposed harness against.
---

# References and prior art

*An evolving starting bibliography—not a claim of novelty or an exhaustive systematic review.*

The hard question is not whether graph databases, agent frameworks, approval workflows, or provenance tools exist. They do. The question is whether a specific **combined contract** is missing, valuable, and measurable enough to justify another layer of infrastructure.

## Assurance, engineering, and qualification

- [Goal Structuring Notation (GSN)](https://www.goalstructuringnotation.info/) — structured argumentation for claims, strategies, and evidence. A source of established assurance-case patterns.
- [FAA AC 20-115D](https://www.faa.gov/airports/resources/advisory_circulars/index.cfm/go/document.information/documentNumber/20-115D) — the FAA recognition context for DO-178C and related software assurance standards. DO-330 qualification questions matter where a software verification tool replaces otherwise required assurance activities.
- [SAE ARP4754B](https://saemobilus.sae.org/standards/arp4754b-guidelines-development-civil-aircraft-systems) — guidelines for developing civil aircraft and systems.
- [ISO 26262](https://www.iso.org/standard/68383.html) — automotive functional-safety standard series. Applicability depends on the actual role and scope of a proposed tool.
- [OMG SysML v2](https://www.omg.org/sysml/sysmlv2/) — the language specification and companion infrastructure for textual/system-model representation.
- [OSLC specifications](https://open-services.net/specifications/) — linked data and integration standards for lifecycle tooling; relevant to cross-tool traceability.
- [NASA software bidirectional traceability guidance](https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695427/SWE-052%2B-%2BBidirectional%2BTraceability) — established trace-link governance questions.
- [Bohner & Arnold, *Software Change Impact Analysis*](https://dl.acm.org/doi/book/10.5555/281506) — historic change-impact analysis and over-approximation themes. Verify publication details before using it in a formal literature review.

## Provenance, attestation, and source integrity

- [W3C PROV-O](https://www.w3.org/TR/prov-o/) — a vocabulary for representing provenance relationships.
- [in-toto specification](https://in-toto.io/docs/specs/) — supply-chain layout and verification patterns; not directly an agent answer-verification mechanism.
- [SLSA specification](https://slsa.dev/spec/v1.2/) — supply-chain provenance and integrity levels, useful conceptual precedent rather than evidence that this research architecture is implemented.
- [W3C SHACL](https://www.w3.org/TR/shacl/) — graph constraint validation; a possible deterministic alternative to model self-report.
- [PostgreSQL recursive queries](https://www.postgresql.org/docs/current/queries-with.html) — mature graph-like closure calculation without AI.

## Agent policy, approval, and prompt-injection defenses

- [Microsoft Agent Framework security guidance](https://learn.microsoft.com/en-us/agent-framework/agents/security) — includes FIDES policy-mediated approval concepts binding a decision to a concrete invocation. This **overlaps with** the proposed exact-action consent model and weakens any novelty claim. Maturity and runtime applicability must be checked.
- [CaMeL research paper](https://arxiv.org/abs/2503.18813) — control/data separation for prompt-injection defense, an essential comparison for deterministic trust propagation.
- [OWASP Top 10 for LLM Applications](https://genai.owasp.org/llm-top-10/) — prompt injection, excessive agency, and related risks.
- [NIST agentic AI evaluation probes](https://www.nist.gov/programs-projects/building-evaluation-probes-agentic-ai) — adversarial evaluation context; the cited work discusses LLM-based evaluators and should **not** be portrayed as a deterministic or independent gate.

## Existing engineering and agent platforms

- [IBM DOORS Next](https://www.ibm.com/docs/en/engineering-lifecycle-management-suite/doors-next/7.1.0?topic=requirements-traceability), [Siemens Polarion](https://www.siemens.com/en-us/products/polarion/application-lifecycle-management-alm/), [PTC Codebeamer](https://www.ptc.com/en/products/codebeamer), [CATIA Magic / SysML](https://www.3ds.com/products/catia/catia-magic) — candidate baseline solutions for requirements, traceability, and modeling.
- [OpenAI Codex](https://openai.com/codex/) and [OpenAI Agents SDK](https://openai.github.io/openai-agents-python/) — general-purpose agent workflows and tool orchestration; compare actual capabilities in a controlled test.
- [Microsoft Agent Framework](https://learn.microsoft.com/en-us/agent-framework/) — agent composition and workflow control.
- [AWS Bedrock AgentCore](https://aws.amazon.com/bedrock/agentcore/) and [Google Agent Development Kit](https://google.github.io/adk-docs/) — alternative managed and SDK-based foundations.
- [Temporal](https://docs.temporal.io/) — durable execution patterns that a new harness should not reimplement casually.

## Biomedical evidence workflows as analogy, not proof

- [PRISMA 2020](https://www.prisma-statement.org/prisma-2020), [Cochrane Handbook](https://training.cochrane.org/handbook/current), [GRADE](https://www.gradeworkinggroup.org/) — evidence search, study inclusion, and certainty practices; not agent-authorization or graph-completeness implementations.
- [MedGraphRAG](https://aclanthology.org/2025.acl-long.1381/) and [MedCEG](https://aclanthology.org/2026.findings-emnlp.1088/) — graph-assisted biomedical research. Their contribution is not equivalent to a runtime deterministic coverage receipt.

## Interpretation rule

Each link is **a prompt to evaluate prior art**, not an endorsement, a verified feature-by-feature comparison, or a claim that it solves the complete contract. Source versions and tool capabilities change. The [white paper references]({{ '/whitepaper/' | relative_url }}) and [adversarial review]({{ '/adversarial-review/' | relative_url }}) discuss further sources and caveats.

The intended publication process is to mark whether each source **implements, partially overlaps, contradicts, or merely inspires** a proposed mechanism, with an evidence link and a date checked.

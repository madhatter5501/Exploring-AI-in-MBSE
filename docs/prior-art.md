---
layout: default
title: References and prior art
permalink: /prior-art/
description: Standards, methods, platforms, and primary research to test the proposed harness against.
---

# References and prior art

*An evolving starting bibliography—not a claim of novelty or an exhaustive systematic review.*

A [reference and claim audit]({{ '/reference-audit/' | relative_url }}) documents link checks, misattribution corrections, and unresolved validations.

The hard question is not whether graph databases, agent frameworks, approval workflows, or provenance tools exist. They do. The question is whether a specific **combined contract** is missing, valuable, and measurable enough to justify another layer of infrastructure.

## Assurance, engineering, and qualification

- [Goal Structuring Notation (GSN)](https://scsc.uk/gsn)[^gsn] — structured argumentation for claims, strategies, and evidence. A source of established assurance-case patterns.
- [FAA AC 20-115D](https://www.faa.gov/airports/resources/advisory_circulars/index.cfm/go/document.information/documentNumber/20-115D)[^faa] — the FAA recognition context for DO-178C and related software assurance standards. DO-330 qualification questions matter where a software verification tool replaces otherwise required assurance activities.
- [SAE AIR6276 (2026)](https://saemobilus.sae.org/standards/air6276-use-models-tools-aircraft-systems-development-a-strategy-development-assurance-aspects-examples)[^air6276] — official information report about development-assurance risks from using models and tools; not proof of this architecture.
- [SAE ARP4754B](https://saemobilus.sae.org/standards/arp4754b-guidelines-development-civil-aircraft-systems)[^sae] — guidelines for developing civil aircraft and systems.
- [ISO 26262-1:2018](https://www.iso.org/standard/68383.html)[^iso] — scope and vocabulary within the automotive functional-safety standard series. The full series was not reviewed.
- [OMG SysML v2](https://www.omg.org/sysml/sysmlv2/)[^sysml] — the language specification and companion infrastructure for textual/system-model representation.
- [OSLC specifications](https://open-services.net/specifications/)[^oslc] — linked data and integration standards for lifecycle tooling; relevant to cross-tool traceability.
- [NASA software bidirectional traceability guidance](https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695427/SWE-052%2B-%2BBidirectional%2BTraceability)[^nasa] — established trace-link governance questions.
- [Bohner & Arnold, *Software Change Impact Analysis*](https://www.wiley-vch.de/en?isbn=9780818673849&option=com_eshop&title=Software+Change+Impact+Analysis&view=product)[^impact] — historic change-impact, source-dependency and traceability analysis. Publisher record confirms the 1996 book and its discussion of source dependency and traceability; it is not a measurement of this proposed harness.

## Provenance, attestation, and source integrity

- [W3C PROV-O](https://www.w3.org/TR/prov-o/)[^prov] — a vocabulary for representing provenance relationships.
- [in-toto specification](https://in-toto.io/docs/specs/)[^intoto] — supply-chain layout and verification patterns; not directly an agent answer-verification mechanism.
- [SLSA specification](https://slsa.dev/spec/v1.2/)[^slsa] — supply-chain provenance and integrity levels, useful conceptual precedent rather than evidence that this research architecture is implemented.
- [W3C SHACL](https://www.w3.org/TR/shacl/)[^shacl] — graph constraint validation; a possible deterministic alternative to model self-report.
- [PostgreSQL recursive queries](https://www.postgresql.org/docs/current/queries-with.html)[^postgres] — mature graph-like closure calculation without AI.

## Agent policy, approval, and prompt-injection defenses

- [Microsoft Agent Framework security guidance](https://learn.microsoft.com/en-us/agent-framework/agents/security)[^msframework] — includes FIDES[^fides] policy-mediated approval concepts binding a decision to a concrete invocation. This **overlaps with** the proposed exact-action consent model and weakens any novelty claim. Maturity and runtime applicability must be checked.
- [CaMeL research paper](https://arxiv.org/abs/2503.18813)[^camel] — control/data separation for prompt-injection defense, an essential comparison for deterministic trust propagation.
- [OWASP Top 10 for LLM Applications](https://genai.owasp.org/llm-top-10/)[^owasp] — prompt injection, excessive agency, and related risks.
- [NIST agentic AI evaluation probes](https://www.nist.gov/programs-projects/building-evaluation-probes-agentic-ai)[^nistprobes] — adversarial evaluation context; the cited work discusses LLM-based evaluators and should **not** be portrayed as a deterministic or independent gate.

## Existing engineering and agent platforms

- [IBM DOORS Next](https://www.ibm.com/docs/en/engineering-lifecycle-management-suite/doors-next/7.1.0?topic=requirements-traceability)[^ibm], [Siemens Polarion](https://www.siemens.com/en-us/products/polarion/application-lifecycle-management-alm/)[^siemens], [PTC Codebeamer](https://www.ptc.com/en/products/codebeamer)[^codebeamer], [CATIA SysML v2](https://www.3ds.com/products/catia/catia-magic/sysmlv2)[^catia] — candidate baseline solutions for requirements, traceability, and modeling.
- [OpenAI Codex](https://openai.com/codex/)[^codex] and [OpenAI Agents SDK](https://openai.github.io/openai-agents-python/)[^agents] — general-purpose agent workflows and tool orchestration; compare actual capabilities in a controlled test.
- [Microsoft Agent Framework](https://learn.microsoft.com/en-us/agent-framework/) — agent composition and workflow control.
- [AWS Bedrock AgentCore](https://aws.amazon.com/bedrock/agentcore/)[^aws] and [Google Agent Development Kit](https://google.github.io/adk-docs/)[^google] — alternative managed and SDK-based foundations.
- [Temporal](https://docs.temporal.io/)[^temporal] — durable execution patterns that a new harness should not reimplement casually.

## Biomedical evidence workflows as analogy, not proof

- [PRISMA 2020](https://www.prisma-statement.org/prisma-2020)[^prisma], [Cochrane Handbook, Chapter 4](https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-04)[^cochrane], [GRADE Handbook](https://gdt.gradepro.org/app/handbook/handbook.html)[^grade] — evidence search, study inclusion, and certainty practices; not agent-authorization or graph-completeness implementations.
- [MedGraphRAG](https://aclanthology.org/2025.acl-long.1381/)[^medgraph] and [MedCEG](https://aclanthology.org/2026.findings-emnlp.1088/)[^medceg] — graph-assisted biomedical research. Their contribution is not equivalent to a runtime deterministic coverage receipt.

## Interpretation rule

Each link is **a prompt to evaluate prior art**, not an endorsement, a verified feature-by-feature comparison, or a claim that it solves the complete contract. Source versions and tool capabilities change. The [white paper references]({{ '/whitepaper/' | relative_url }}) and [adversarial review]({{ '/adversarial-review/' | relative_url }}) discuss further sources and caveats.

The intended publication process is to mark whether each source **implements, partially overlaps, contradicts, or merely inspires** a proposed mechanism, with an evidence link and a date checked.


## Source footnotes and acknowledgements

These notes acknowledge existing tools, standards, and methods at their first substantive mention. Sources establish only their described scope; they do not validate this research architecture.

[^codex]: OpenAI Codex is a candidate coding-agent host, not a demonstrated MBSE assurance solution. Vendor overview: [Codex as a Platform](https://developers.openai.com/blog/codex-as-a-platform); [source repository](https://github.com/openai/codex).

[^agents]: OpenAI Agents SDK documents tool orchestration, guardrails, approvals, and tracing; it does not certify external engineering-graph completeness. [SDK](https://developers.openai.com/api/docs/guides/agents/sdk); [guardrails and approvals](https://developers.openai.com/api/docs/guides/agents/guardrails-approvals).

[^msframework]: Microsoft's agent framework and workflow documentation provide relevant orchestration and review features; compatibility must be checked by language/runtime version. [Framework](https://learn.microsoft.com/en-us/agent-framework/workflows/); [human-in-the-loop](https://learn.microsoft.com/en-us/agent-framework/workflows/human-in-the-loop).

[^aws]: AWS AgentCore provides managed agent capabilities including policy tooling; the exact applicability to this research is untested. [Policy documentation](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/policy.html).

[^google]: Google's agent tooling is an alternative platform/SDK, not a verified implementation of this research contract. [ADK documentation](https://google.github.io/adk-docs/); [managed platform](https://docs.cloud.google.com/gemini-enterprise-agent-platform/overview).

[^temporal]: Temporal documents durable workflow execution and recovery semantics; this does not by itself verify engineering claims. [Official workflow documentation](https://docs.temporal.io/workflow-execution).

[^postgres]: PostgreSQL supports recursive common-table expressions over modeled relationships. Completeness is conditional on query semantics and source data. [Official recursive-query documentation](https://www.postgresql.org/docs/current/queries-with.html).

[^shacl]: W3C SHACL specifies RDF graph shape constraints; pySHACL is an available implementation. Shape validation does not discover arbitrary absent real-world links. [W3C specification](https://www.w3.org/TR/shacl/); [implementation](https://github.com/RDFLib/pySHACL).

[^fides]: Microsoft Agent Framework FIDES propagates restrictive data labels and can bind an approval to one exact invocation. The documentation states it is experimental and currently Python-only, not available for .NET agents. [Official security documentation](https://learn.microsoft.com/en-us/agent-framework/agents/security).

[^sysml]: OMG SysML v2 is an established modeling language. Parser acceptance or tool export is not validation of engineering-model semantics. [OMG v2 specification](https://www.omg.org/spec/SysML/2.0); [reference releases](https://github.com/Systems-Modeling/SysML-v2-Release).

[^nasa]: NASA's Systems Engineering Handbook and traceability guidance motivate requirements, interfaces, and verification practice; they do not validate this proposed harness. [Handbook](https://www.nasa.gov/reference/2-0-fundamentals-of-systems-engineering/); [bidirectional traceability guidance](https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695427/SWE-052%2B-%2BBidirectional%2BTraceability).

[^owasp]: OWASP's LLM/GenAI risks identify prompt injection and excessive agency; a risk taxonomy is not a tested mitigation. [Official LLM Top 10](https://genai.owasp.org/llm-top-10/).

[^prov]: W3C PROV-O defines provenance semantics; a provenance record does not alone establish factual correctness or cryptographic signing. [W3C specification](https://www.w3.org/TR/prov-o/).

[^intoto]: in-toto specifies signed supply-chain layout and verification concepts; analogical prior art, not agent answer certification. [Official specification](https://in-toto.io/docs/specs/).

[^slsa]: SLSA v1.2 documents software supply-chain provenance/integrity requirements, not universal truth of model-generated engineering claims. [Specification](https://slsa.dev/spec/v1.2/).

[^gsn]: Goal Structuring Notation (GSN) is established safety/assurance-case notation, maintained by the SCSC working group. The official page opened in a browser, although automated crawlers may face access challenges. [SCSC standards page](https://scsc.uk/gsn).

[^faa]: FAA AC 20-115D recognizes RTCA DO-178C and DO-330, but the circular is an acceptable means rather than a regulation itself. Tool qualification applicability must be decided for the actual use case. [FAA AC 20-115D](https://www.faa.gov/airports/resources/advisory_circulars/index.cfm/go/document.information/documentNumber/20-115D); [RTCA overview](https://www.rtca.org/do-178/).

[^iso]: The linked primary source is ISO 26262-1:2018, the scope/vocabulary part of the road-vehicle functional-safety series. This review did not examine the complete paid standard. [ISO Part 1](https://www.iso.org/standard/68383.html).

[^sae]: SAE ARP4754B is a recommended practice for civil aircraft and systems development; applicability and qualification requirements are domain-specific. [SAE publication](https://saemobilus.sae.org/standards/arp4754b-guidelines-development-civil-aircraft-systems).

[^oslc]: OSLC specifies linked lifecycle resources across tooling; implementation support varies. [Official specifications](https://open-services.net/specifications/).

[^impact]: Robert Arnold and Shawn Bohner edited/authored *Software Change Impact Analysis* (1996), prior art on dependency and traceability analysis; its findings are not a test of this architecture. [Wiley publisher record](https://www.wiley-vch.de/en?isbn=9780818673849&option=com_eshop&title=Software+Change+Impact+Analysis&view=product).

[^camel]: CaMeL's research proposes separating trusted control/data flow from untrusted material to address prompt injection. The research artifact is not a supported security product. [Primary paper](https://arxiv.org/abs/2503.18813); [authors' code](https://github.com/google-research/camel-prompt-injection).

[^codebeamer]: PTC describes Codebeamer requirements, traceability, risk, and ALM features. These are vendor claims, not a verified instance of this research's coverage receipt. [Official product page](https://www.ptc.com/en/products/codebeamer).

[^ibm]: IBM documents DOORS Next trace links, impact analysis, and coverage reporting. The exact documentation URL was indexed but direct automated fetch was restricted during this audit. [IBM traceability documentation](https://www.ibm.com/docs/en/engineering-lifecycle-management-suite/doors-next/7.1.0?topic=requirements-traceability).

[^siemens]: Siemens describes Polarion ALM requirements, workflow and traceability capabilities; feature breadth/versions require hands-on validation. [Official ALM page](https://www.siemens.com/en-us/products/polarion/application-lifecycle-management-alm/).

[^catia]: Dassault describes CATIA SysML v2 modeling and text/diagram synchronization. Conformance percentages on the vendor page are marketing claims and were not independently tested here. [Official page](https://www.3ds.com/products/catia/catia-magic/sysmlv2).

[^medgraph]: MedGraphRAG is biomedical graph-assisted retrieval research; it is not a runtime deterministic traversal receipt. [ACL Anthology paper](https://aclanthology.org/2025.acl-long.1381/).

[^medceg]: MedCEG uses critical evidence graphs for clinical-model training and reward evaluation, not a general runtime permission or coverage gate. [ACL Anthology paper](https://aclanthology.org/2026.findings-emnlp.1088/).

[^prisma]: PRISMA 2020 supplies systematic-review reporting guidelines, not an agent runtime guarantee. [Official PRISMA statement](https://www.prisma-statement.org/prisma-2020).

[^cochrane]: Cochrane's Handbook describes searching and selecting studies with explicit scope and exclusions; it is a methodological analogy, not an AI product control. [Current Chapter 4](https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-04).

[^grade]: GRADE provides an evidence-certainty framework for reviews; its ratings do not translate directly into software-verification status labels. [GRADE handbook](https://gdt.gradepro.org/app/handbook/handbook.html).

[^air6276]: SAE AIR6276 (issued 2026) is a report about risk considerations for models and tools in aircraft systems development. Its full text was not assessed here. [SAE publication](https://saemobilus.sae.org/standards/air6276-use-models-tools-aircraft-systems-development-a-strategy-development-assurance-aspects-examples).

[^nistprobes]: NIST describes adversarial evaluation probes using rubric-based LM judges against curated reference corpora. Do not call them independent deterministic verifiers. [NIST project](https://www.nist.gov/programs-projects/building-evaluation-probes-agentic-ai).

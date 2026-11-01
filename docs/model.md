---
layout: default
title: SysML v2 architecture model
permalink: /model/
description: Textual SysML v2 architecture model, modular packages, and known modeling limits.
---

# SysML v2 reference architecture

The repository includes a **textual SysML v2[^sysml] representation** of the proposed evidence-gated agentic architecture, its MBSE reference application, adversarial cases, requirements, and declared verification cases.

[**Open the complete model**](https://github.com/madhatter5501/Exploring-AI-in-MBSE/blob/main/models/Evidence_Attested_Agentic_Harness.sysml) · [Browse all model files](https://github.com/madhatter5501/Exploring-AI-in-MBSE/tree/main/models) · [Import guidance](https://github.com/madhatter5501/Exploring-AI-in-MBSE/blob/main/models/HOLARCH_IMPORT_GUIDE.md)

## What the model represents

- Principals, authorization boundaries, reasoning profiles, trusted graph snapshots, source labels, and evidence records.
- Work execution, one-packet-per-individual-action review, plan-level risk, durable audit, and waiver rules.
- Root and scope pinning, structured inspection obligations, graph/sibling comparisons, and risk classification.
- Architecture and threat models, requirements, verification cases, trade studies, and document traceability.
- MBSE engineering change-impact analysis as a reference scenario.

## What has been verified

The consolidated textual model was previously checked with the [OpenSysML / MBSE4U online SysML v2 parser](https://mbse4u.com/tools/sysml-check/)[^mbse4u] and returned zero reported syntax diagnostics for that snapshot.

That means **the source parsed in one tool**. It does **not** mean:

- A second modeling tool has imported the model correctly.
- The model fully captures every revised statement in the current white paper and critique.
- Declared verification cases have executed or passed.
- Requirements have been validated against an implemented product.
- The assurance architecture has been independently verified.

The white paper has evolved since earlier model drafts. Traceability review and cross-tool import are explicit open work items.

## Suggested review

1. Import the consolidated `.sysml` file first.
2. Run syntax and semantic checks in a second conformant tool.
3. Inspect declared requirements and trace relationships.
4. Challenge the model against the [assurance boundaries]({{ '/assurance-boundaries/' | relative_url }}).
5. File a reproducible discrepancy—including tool version and minimized excerpt—as a GitHub issue.

The project favors counterexamples and reproducible defects over an unsupported “100% complete” status.


## Source footnotes and acknowledgements

These notes acknowledge existing tools, standards, and methods at their first substantive mention. Sources establish only their described scope; they do not validate this research architecture.

[^sysml]: OMG SysML v2 is an established modeling language. Parser acceptance or tool export is not validation of engineering-model semantics. [OMG v2 specification](https://www.omg.org/spec/SysML/2.0); [reference releases](https://github.com/Systems-Modeling/SysML-v2-Release).

[^mbse4u]: MBSE4U offers an online SysML v2 syntax checker; passing one parser is not independent model validation. [Checker](https://mbse4u.com/tools/sysml-check/).

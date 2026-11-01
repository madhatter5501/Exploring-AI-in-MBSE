# SysML v2 reference model — import guidance

*Working model baseline · Updated November 2026*

This repository contains 13 modular SysML v2 package files plus the consolidated [Evidence_Attested_Agentic_Harness.sysml](Evidence_Attested_Agentic_Harness.sysml). The packages represent proposed trust boundaries, architecture, behavior, requirements, verification objectives, and mappings to the working papers. **They are not an implemented agent, executed test suite, or independent proof of architecture completeness.**

## Holarch: possible import destination

The [Holarch sign-in page](https://app.holarch.app/)[^holarch] was reachable in a browser during this audit, but its model-import interface is behind authentication. We have **not** verified the exact menu sequence or successfully imported these files there.

1. Use a new or disposable project for experimentation.
2. Obtain the 13 `EAH_*.sysml` package files from this repository. If a tool requires a ZIP archive, create one from those files; **no import ZIP is currently committed here**.
3. Follow the current tool's import process and inspect all diagnostics before applying.
4. If multi-file references fail, try the consolidated `Evidence_Attested_Agentic_Harness.sysml` as a single-source model.
5. Document the tool version and any unsupported grammar, namespace, or semantic errors before treating the model as imported.

A tool may implement a subset of the language or interpret constructs differently. This possibility is a compatibility question to test, not a claim about Holarch's current capabilities.

## Strict textual syntax check

A prior pass of the consolidated source using the [MBSE4U SysML v2 checker](https://mbse4u.com/tools/sysml-check/)[^mbse4u] reported no syntax diagnostics for that snapshot. The underlying language is [OMG SysML v2](https://www.omg.org/spec/SysML/2.0)[^sysml]. This audit has **not** rerun a second independent parser or checked alignment with every revision of the white paper.

If you have an appropriate OpenSysML command-line parser installed, a representative *local* syntax-check command is:

```sh
sysml -strict -validate Evidence_Attested_Agentic_Harness.sysml
```

Check the installed version's CLI flags rather than assuming this command works in every distribution.

## Source inventory

1. `EAH_Common.sysml`
2. `EAH_Protocols.sysml`
3. `EAH_Architecture.sysml`
4. `EAH_Behavior.sysml`
5. `EAH_Requirements.sysml`
6. `EAH_Verification.sysml`
7. `EAH_MBSE_Reference.sysml`
8. `EAH_ThreatModel.sysml`
9. `EAH_AdversarialEvaluation.sysml`
10. `EAH_TradeStudies.sysml`
11. `EAH_DataAndOperations.sysml`
12. `EAH_AssuranceCase.sysml`
13. `EAH_DocumentTraceability.sysml`

Cross-tool import, requirement coverage, model semantics, source-graph fidelity, and executable verification remain open. [Known assurance limits](../docs/assurance-boundaries.md) and the [validation plan](../docs/validation.md) take precedence over any unqualified completeness claim.

## Source footnotes and acknowledgements

[^holarch]: Holarch is an external MBSE modeling application. Its public [sign-in page](https://app.holarch.app/) was accessible on November 1, 2026; authenticated import features were not examined.

[^mbse4u]: MBSE4U provides a [SysML v2 checker](https://mbse4u.com/tools/sysml-check/). Acceptance by one parser says nothing by itself about cross-tool conformance or engineering correctness.

[^sysml]: [OMG SysML v2 specification](https://www.omg.org/spec/SysML/2.0) and [official release examples](https://github.com/Systems-Modeling/SysML-v2-Release). Language syntax is distinct from architecture assurance.

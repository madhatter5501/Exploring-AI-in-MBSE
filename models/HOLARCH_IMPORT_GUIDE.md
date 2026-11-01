# Evidence-Attested Agentic Harness — SysML v2 import guide

This export contains 13 SysML v2 textual package files representing the architecture, MBSE reference application, requirements, proposed verification cases, trust boundaries, historical-escape evaluation, trade studies, assurance-case limits, and mapping back to 17 white-paper chapters and 20 adversarial-review chapters.

## Option A — Holarch (multi-file)

1. Open [Holarch](https://app.holarch.app/), create or sign in to an account, and create a **SysML v2** project.
2. From **Project Files**, select **Import SysML v2 Files…**.
3. Select **Evidence_Attested_Agentic_Harness_Holarch.zip**. The ZIP contains only the 13 `.sysml` package files; import them together so cross-package qualified names resolve.
4. Inspect the preview and diagnostics before applying. Preserve your existing model if you already have one; use a new project when experimenting.
5. Explore `EAH_Architecture::EvidenceAttestedHarness`, `EAH_Requirements`, `EAH_Verification`, `EAH_MBSE_Reference`, `EAH_AdversarialEvaluation`, and `EAH_DocumentTraceability`.

## Option B — strict textual checker (single-file)

Use the separate **Evidence_Attested_Agentic_Harness.sysml** file with OpenSysML:

```sh
sysml -strict -validate Evidence_Attested_Agentic_Harness.sysml
```

The full source was also validated with the strict mode of the OpenSysML WebAssembly engine used at [MBSE4U SysML Check](https://mbse4u.com/tools/sysml-check/). The tool reported no parser diagnostics for the exported source. This is a grammar/reference analysis, **not** execution of verification cases or proof of semantic completeness.

## Scope and limitations

- The model expresses **proposed** requirements, actions, verification objectives, and assurance boundaries. It is not executable agent software.
- A graph receipt proves coverage only of a pinned, visible, archived model scope. Missing source links remain a separate and critical failure mode.
- The first empirical gate is a **no-language-model historical-escape analysis of 20–30 past engineering misses**, classified by whether the missing dependency was present/reachable, present/out of scope, absent from the contemporaneous model, or indeterminate.
- Risk acknowledgement is per individual action; it never grants permissions or substitutes for a policy-required different-role waiver.
- The five classifier boundaries, deterministic taint propagation, trusted consent rendering, plan-level effects, and two-stage authorization are modeled as distinct obligations.
- Holarch explicitly supports a **subset** of SysML v2, so it may report unsupported constructs even when a different strict validator accepts the model. Import compatibility with Holarch is not yet independently confirmed.
- The trace ledger uses stable document-section IDs and requirement ID strings. They support review but are not executable evidence of complete satisfaction.

The ZIP includes only these 13 source packages:

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

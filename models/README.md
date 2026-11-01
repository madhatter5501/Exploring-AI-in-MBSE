# SysML v2 architecture baseline

These are working **textual SysML v2 architecture sources**, not an implemented harness or independently validated assurance case.

## Where to start

- [Evidence_Attested_Agentic_Harness.sysml](Evidence_Attested_Agentic_Harness.sysml) — consolidated textual model.
- [HOLARCH_IMPORT_GUIDE.md](HOLARCH_IMPORT_GUIDE.md) — import notes.
- `EAH_*.sysml` — modular source packages corresponding to architecture, behavior, threats, assurance, tests, and document traceability.

The consolidated file previously passed the OpenSysML/MBSE4U strict parser with **zero reported syntax diagnostics**. Cross-parser semantics, external tool import, executable conformance, and alignment with the later revised working paper remain **unverified**. Declared requirement-to-verification relationships are not executed test results.

A syntax check is evidence about a parser result, not proof of architecture completeness. The white paper now explicitly discusses missing graph edges and source-model fidelity, and the SysML baseline should be audited for those distinctions.

[Research site](https://madhatter5501.github.io/Exploring-AI-in-MBSE/model/) · [Working white paper](../docs/whitepaper.md) · [Assurance boundaries](../docs/assurance-boundaries.md)

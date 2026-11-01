# SysML v2 architecture baseline

These are working **textual SysML v2[^sysml] architecture sources**, not an implemented harness or independently validated assurance case.

## Where to start

- [Evidence_Attested_Agentic_Harness.sysml](Evidence_Attested_Agentic_Harness.sysml) — consolidated textual model.
- [HOLARCH_IMPORT_GUIDE.md](HOLARCH_IMPORT_GUIDE.md) — import notes.
- `EAH_*.sysml` — modular source packages corresponding to architecture, behavior, threats, assurance, tests, and document traceability.

The consolidated file previously passed the OpenSysML[^mbse4u]/MBSE4U strict parser with **zero reported syntax diagnostics**. Cross-parser semantics, external tool import, executable conformance, and alignment with the later revised working paper remain **unverified**. Declared requirement-to-verification relationships are not executed test results.

A syntax check is evidence about a parser result, not proof of architecture completeness. The white paper now explicitly discusses missing graph edges and source-model fidelity, and the SysML baseline should be audited for those distinctions.

[Model overview](../docs/model.md) · [Working white paper](../docs/whitepaper.md) · [Assurance boundaries](../docs/assurance-boundaries.md)


## Source footnotes and acknowledgements

These notes acknowledge existing tools, standards, and methods at their first substantive mention. Sources establish only their described scope; they do not validate this research architecture.

[^sysml]: OMG SysML v2 is an established modeling language. Parser acceptance or tool export is not validation of engineering-model semantics. [OMG v2 specification](https://www.omg.org/spec/SysML/2.0); [reference releases](https://github.com/Systems-Modeling/SysML-v2-Release).

[^mbse4u]: MBSE4U offers an online SysML v2 syntax checker; passing one parser is not independent model validation. [Checker](https://mbse4u.com/tools/sysml-check/).

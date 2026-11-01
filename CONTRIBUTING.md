# Contributing to Exploring AI in MBSE

This is an independent research notebook. The most valuable contributions are careful criticisms, reproducible counterexamples, corrections to cited sources, and small, falsifiable experiments.

## Useful issue types

- A concrete engineering change where a complete walk of the recorded graph missed an important dependency.
- A prior-art implementation that already supports some or all of the proposed trust contract.
- A syntax, semantic, or completeness problem in the SysML v2[^sysml] representation, ideally with the tool version and minimal reproducer.
- A reviewer-experience failure: unsafe rubber-stamping, misleading badges, or plan-level risk missed by individual-action review.
- A proposed test that would disprove a central claim economically and quickly.

## Evidence quality

Please distinguish observed behavior from inference and speculation. Cite direct primary sources where possible, including exact versions and dates. Report negative results as clearly as positive results.

**Do not submit** proprietary, customer, confidential, export-controlled, or sensitive personal data. Use synthetic or authorized public examples.

This project currently has no license; do not assume unrestricted redistribution or reuse of contributed code or documents until explicit terms are published. Filing an issue does not require a contribution license.


## Source footnotes and acknowledgements

These notes acknowledge existing tools, standards, and methods at their first substantive mention. Sources establish only their described scope; they do not validate this research architecture.

[^sysml]: OMG SysML v2 is an established modeling language. Parser acceptance or tool export is not validation of engineering-model semantics. [OMG v2 specification](https://www.omg.org/spec/SysML/2.0); [reference releases](https://github.com/Systems-Modeling/SysML-v2-Release).

---
layout: default
title: Research log
permalink: /research-log/
description: A dated record of what is proposed, challenged, tested, and still unknown.
---

# Research log

## 2026-11-01 — Reference, claim, and acknowledgment audit

**Status: citations strengthened; research outcomes still untested.**

- Audited external links and source-to-claim fit, replacing generic or insufficient references with precise publisher, regulator, standards, and product pages where available.
- Added point-of-use tooling footnotes to the research papers and related pages, including experimental-feature limitations and vendor-claim qualifications.
- Published a [claim audit]({{ '/reference-audit/' | relative_url }}) and [link inventory]({{ '/link-inventory/' | relative_url }}) with blocked or login-gated access clearly marked.
- Used small deterministic examples to show both the intended coverage-gate behavior and its false pass when the authoritative graph lacks a real edge.
- Corrected import instructions that referred to a ZIP not present in the repository. No authenticated Holarch[^holarch] import test has been performed.

**No real engineering benchmark, reviewer study, or cross-tool semantic verification resulted from this audit.**

## 2026-11-01 — Public working baseline

**Status: architecture proposed; empirical validation not started.**

- Established this independent research repository and a GitHub Pages-ready companion site.
- Published the working white paper, adversarial critique, explicit assurance boundaries, and a staged validation protocol.
- Recorded central objections: an agent can inspect an incomplete graph perfectly and still miss the actual impact; human reviewers can over-trust coverage indicators; a new harness may offer no advantage over existing tools.
- Provided SysML v2[^sysml] textual architecture files from the prior modeling exercise, with parsing history and import limitations noted.
- Identified the first falsifiable study: 20–30 engineering escapes against their historical model snapshots, with no LLM in the first stage.

**No new experiments or empirical performance results are claimed.**

## How entries will evolve

Each substantive experiment should carry a date, question, source/data constraints, versioned method, observed result, counterexamples, and a decision or next falsification step. Corrections to earlier assertions should be recorded plainly.

[Propose a study or correction](https://github.com/madhatter5501/Exploring-AI-in-MBSE/issues) · [Research roadmap]({{ '/roadmap/' | relative_url }})


## Source footnotes and acknowledgements

These notes acknowledge existing tools, standards, and methods at their first substantive mention. Sources establish only their described scope; they do not validate this research architecture.

[^sysml]: OMG SysML v2 is an established modeling language. Parser acceptance or tool export is not validation of engineering-model semantics. [OMG v2 specification](https://www.omg.org/spec/SysML/2.0); [reference releases](https://github.com/Systems-Modeling/SysML-v2-Release).

[^holarch]: Holarch is referenced as a possible model-import destination. Its current availability and successful import of these files were not independently established. [Application entry point](https://app.holarch.app/).

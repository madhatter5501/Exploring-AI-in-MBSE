---
layout: default
title: Reference and claim audit
permalink: /reference-audit/
description: What was checked, corrected, and left unresolved in the published research references.
---

# Reference and claim audit

*Audit date: November 1, 2026 · Research version: working draft v0.2*

This record exists so readers can distinguish **a reachable URL**, **a correctly described source**, **a mathematically checkable statement**, and **an experimentally validated engineering claim**. Those are different levels of evidence. The first three can be checked in a document audit; the fourth generally needs an actual dataset, executed protocol, and independent review.

## Scope and method

The audit covered the working [white paper]({{ '/whitepaper/' | relative_url }}), [adversarial critique]({{ '/adversarial-review/' | relative_url }}), [prior art]({{ '/prior-art/' | relative_url }}), supporting research pages, repository README, and model import guide.

1. Extracted external URL references, deduplicated their destinations, and attempted automated retrieval or primary-source searches.
2. Replaced non-specific or unsuitable destinations with specific official documentation or publisher records where possible.
3. Compared the source text to high-impact claims about tools, standards, cryptographic provenance, solver outcomes, and biomedical analogies.
4. Added footnotes identifying existing tools/standards **at the first substantive use in each document**, with caveats where source authors are vendors or tests have not been run.
5. Ran simple deterministic examples of the graph-coverage contract and independently recalculated the illustrative economic arithmetic.
6. Checked Markdown footnote marker/definition parity and repository-internal model/document paths.

This is an intensive **editorial, citation, and logical audit**, not an exhaustive independent reproducibility study, legal review, certification assessment, or full-text review of paywalled standards.

[Complete URL inventory and access notes]({{ '/link-inventory/' | relative_url }}).

## Material citation corrections

| Issue | Disposition | Why it matters |
|---|---|---|
| A generic Wiley homepage and inaccessible ACM record were used for Bohner/Arnold's book | Replaced with the [publisher's ISBN-specific record](https://www.wiley-vch.de/en?isbn=9780818673849&option=com_eshop&title=Software+Change+Impact+Analysis&view=product) | Identifies the actual 1996 work, without claiming it measured this architecture |
| Generic ISO and SAE homepages cited safety standards | Replaced with [ISO 26262-1:2018](https://www.iso.org/standard/68383.html)[^iso] and [SAE ARP4754B](https://saemobilus.sae.org/standards/arp4754b-guidelines-development-civil-aircraft-systems)[^sae] | The ISO link is **Part 1 only**, not the whole paid series |
| GSN home address timed out in automated retrieval | Replaced with the [SCSC GSN standards page](https://scsc.uk/gsn)[^gsn] | Official page opened in the browser; automated retrieval sometimes receives an access challenge |
| Older Cochrane[^cochrane] technical-supplement URL could not be retrieved | Replaced with [current Chapter 4](https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-04) | Supports search/selection practice, not software gate correctness |
| PTC grounding-page reference might look like independent verification | Replaced with the [primary Codebeamer product page](https://www.ptc.com/en/products/codebeamer)[^codebeamer] | Feature descriptions are **vendor statements**, not test results |
| NIST evaluation probes[^nistprobes] appeared beside formal constraint checking | Moved to a **model-evaluation** evidence category | The NIST work uses adversarial, rubric-based **LM judges**, not a deterministic solver |
| Microsoft FIDES[^fides] was insufficiently credited for exact approvals | Added detailed citations noting exact-invocation, one-time grants and restrictive labels | These concepts substantially overlap the proposal; FIDES is experimental and Python-only |
| Holarch[^holarch] import guide referenced a ZIP that is not in the repository | Removed that instruction and documented the available 13 modules and one consolidated file | Eliminates a non-existent artifact and avoids claiming verified import menus |
| The unpublished GitHub Pages address appeared as a clickable destination | Removed it from outward-facing README/model/citation links pending publication | A draft site address currently returning 404 should not be promoted as a working source |

## Claim and assumption ledger

| ID | Statement examined | Audit disposition |
|---|---|---|
| C01 | Engineering change-impact analysis uses requirements, interfaces, trace links and verification | **Externally supported context:** NASA[^nasa] and [IBM traceability guidance](https://www.ibm.com/docs/en/engineering-lifecycle-management-suite/doors-next/7.1.0?topic=requirements-traceability). Not evidence that this harness improves outcomes |
| C02 | Deterministic queries can enumerate modeled reachable sets | **Supported and logically testable:** [PostgreSQL recursive queries](https://www.postgresql.org/docs/current/queries-with.html)[^postgres]. Correctness depends on filters, graph representation and authorized scope |
| C03 | A coverage receipt can pass although a real dependency edge is absent | **Verified by construction** in a synthetic test; no production detection rate established |
| C04 | A structured per-node result is stronger than an ID list | **Design hypothesis:** schemas can reject empty records; they cannot prove cognitive comprehension or semantic adequacy |
| C05 | A pinned control-plane root/scope reduces the wrong-root false-pass problem | **Proposed control:** no production enforcement or pilot result exists |
| C06 | FIDES propagates restrictive labels and consumes exact-invocation approvals once | **Confirmed in [Microsoft documentation](https://learn.microsoft.com/en-us/agent-framework/agents/security)**; experimental, Python-only, .NET support absent as documented October 2026 |
| C07 | CaMeL[^camel] separates control/data flows to defend against injection | **Research-supported mechanism:** [primary paper](https://arxiv.org/abs/2503.18813); authors warn their research artifact may be buggy/insecure |
| C08 | W3C PROV[^prov], in-toto[^intoto] and SLSA[^slsa] offer relevant provenance approaches | **Supported, but bounded:** provenance and supply-chain integrity do not certify engineering claim truth |
| C09 | Z3 supports SAT, UNSAT and UNKNOWN over encoded constraints | **Documented semantics:** [Z3 guide](https://microsoft.github.io/z3guide/programming/Z3%20Python/Introduction/)[^z3]. A timeout must be handled as non-passing; no production solver integration tested |
| C10 | Transactional outbox[^outbox] differs from CRDT replication | **Architecturally supported distinction:** linked [Microsoft example](https://learn.microsoft.com/en-us/azure/architecture/databases/guide/transactional-out-box-cosmos) is **Cosmos DB-specific**, not a generic implementation specification |
| C11 | NIST evaluation probes act as deterministic independent verifiers | **Rejected/misrepresentation corrected:** [NIST says](https://www.nist.gov/programs-projects/building-evaluation-probes-agentic-ai) rubric-based LM judges and adversarial evaluation probes |
| C12 | MedCEG is a runtime deterministic coverage gate | **Rejected:** [MedCEG](https://aclanthology.org/2026.findings-emnlp.1088/)[^medceg] uses critical evidence graphs in model training and reward evaluation |
| C13 | Poincaré embeddings establish exact constant-time reachability | **Rejected:** [research](https://ai.meta.com/research/publications/poincare-embeddings-for-learning-hierarchical-representations/) concerns hierarchical representations, not graph closure |
| C14 | GSN, DO-178C[^faa]/DO-330, ISO 26262, ARP4754B and AIR6276 are relevant prior art | **Primary-source context supported:** standards and regulators describe assurance processes. Full paid texts, applicability and qualification obligations **not assessed** |
| C15 | Existing MBSE/ALM vendors provide some traceability and modeling capabilities | **Vendor-documented:** product pages of IBM, Siemens, PTC, Dassault, Ansys and Jama. No independent feature-by-feature deployment test |
| C16 | Sibling graphs and independent queries improve omission discovery | **Untested hypothesis:** shared lineage may cause correlated false reassurance |
| C17 | One findings packet per consequence-bearing action improves human decisions | **Policy/UX hypothesis:** needs reviewer study, role-waiver testing and automation-bias measurement |
| C18 | The example yields $450,000 gross avoided cost, $300,000 extra labor, $150,000 before other costs | **Arithmetic verified** below; all input assumptions are synthetic, not market data |
| C19 | The SysML architecture model is complete or conformance-certified | **Not established:** earlier single-parser syntax result was reported; no second parser, cross-tool import or executed verification results |
| C20 | A thin verifier or existing agent platform may be preferable to a new harness | **Adversarial hypothesis**, not a measured cost/performance comparison |
| C21 | Holarch can import the exact files with the listed menu choices | **Unverified:** public sign-in is accessible, authenticated workflow not inspected |
| C22 | A green coverage badge may increase reviewer complacency | **Risk hypothesis worth testing**; the research has not executed a human-factors study |

## Simple deterministic checks run during this audit

The following were **small conceptual test cases written for the audit**, not tests of working harness software or model implementations:

| Test | Expected observation | Observed |
|---|---|---|
| Full modeled graph, structured results for required nodes | Pass the bounded gate | Pass |
| Request changes a pinned root | Fail on scope deviation | Failed |
| Agent echoes node IDs without valid evidence | Fail structured-inspection requirement | Failed |
| Inspects an authorized extra node | Satisfy required subset and report excess | Pass; extra reported |
| Budget exhausted | No complete coverage claim | Failed |
| Evidence from a stale snapshot | No complete coverage claim | Failed |
| Source graph omits a real safety interface, but agent covers all modeled nodes | Graph gate may pass although engineering completeness is false | **Passed: expected false assurance outside its contract** |

This last case is the strongest falsification warning. No amount of internal traversal bookkeeping repairs a missing authoritative trace link.

The white paper's arithmetic was independently recalculated:

```text
500 changes × 2% costly escapes × $150,000 × 30% avoided = $450,000 gross
500 changes × 4 reviewer hours × $150/hour = $300,000 added labor
$450,000 – $300,000 = $150,000 before all other costs
```

These are **illustrative parameters**, not observed savings or a viability forecast.

## Access restrictions and outstanding verification

- **IBM DOORS Next[^ibm] and Siemens Polarion[^siemens]** — official content was corroborated in search-index results. Direct automated retrieval was limited, and normal-browser access was blocked in this environment. Access should be confirmed from the reader's network before formal circulation.
- **GSN/SCSC:** the official standards page opened successfully in a browser, although automated retrieval sometimes received a verification challenge.
- **Holarch:** public sign-in reachable; authenticated import cannot be claimed tested.
- **Standards:** FAA AC 20-115D is accessible; DO-330, ISO 26262 series, SAE documents may require licensed full-text access and qualified domain interpretation.
- **Product features:** statements sourced from vendor pages are attributed as such, not independently demonstrated.
- **Publication:** GitHub Pages must be enabled before the website address is a live reference.
- **Research:** no historical-escape dataset, preregistered study, independent model semantics verification, reviewer trial or cross-platform benchmark has been conducted here.

## Editorial rules for future changes

1. Every newly mentioned named tool, standard, or research precedent gets a **point-of-use footnote** with a primary URL and a scope caveat.
2. A reachable URL is not enough: note the exact statement that page supports and whether it is an independent result or vendor claim.
3. Generic homepages are not acceptable evidence for a specific feature, book, or standard.
4. Keep proposal, source-supported fact, computed result, and untested hypothesis separate.
5. If a source cannot be checked, record **unverified**—never silently mark it confirmed.
6. Do not attach a safety, qualified-tool, cryptographic, or independent-attestation label without the corresponding executed evidence.

[Full link inventory]({{ '/link-inventory/' | relative_url }}) · [Prior-art index]({{ '/prior-art/' | relative_url }}) · [Research roadmap]({{ '/roadmap/' | relative_url }})

## Source footnotes and acknowledgements

[^postgres]: PostgreSQL supports recursive common-table expressions over modeled relationships. Completeness is conditional on query semantics and source data. [Official recursive-query documentation](https://www.postgresql.org/docs/current/queries-with.html).

[^z3]: Z3 is a constraint solver. SAT/UNSAT/UNKNOWN apply to the supplied encoding, not physical truth; timeouts need explicit handling. [Z3 programming guide](https://microsoft.github.io/z3guide/programming/Z3%20Python/Introduction/); [source](https://github.com/Z3Prover/z3).

[^fides]: Microsoft Agent Framework FIDES propagates restrictive data labels and can bind an approval to one exact invocation. The documentation states it is experimental and currently Python-only, not available for .NET agents. [Official security documentation](https://learn.microsoft.com/en-us/agent-framework/agents/security).

[^nasa]: NASA's Systems Engineering Handbook and traceability guidance motivate requirements, interfaces, and verification practice; they do not validate this proposed harness. [Handbook](https://www.nasa.gov/reference/2-0-fundamentals-of-systems-engineering/); [bidirectional traceability guidance](https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695427/SWE-052%2B-%2BBidirectional%2BTraceability).

[^prov]: W3C PROV-O defines provenance semantics; a provenance record does not alone establish factual correctness or cryptographic signing. [W3C specification](https://www.w3.org/TR/prov-o/).

[^intoto]: in-toto specifies signed supply-chain layout and verification concepts; analogical prior art, not agent answer certification. [Official specification](https://in-toto.io/docs/specs/).

[^slsa]: SLSA v1.2 documents software supply-chain provenance/integrity requirements, not universal truth of model-generated engineering claims. [Specification](https://slsa.dev/spec/v1.2/).

[^gsn]: Goal Structuring Notation (GSN) is established safety/assurance-case notation, maintained by the SCSC working group. The official page was opened in a browser; automated fetchers may still face an access challenge. [SCSC standards page](https://scsc.uk/gsn).

[^faa]: FAA AC 20-115D recognizes RTCA DO-178C and DO-330, but the circular is an acceptable means rather than a regulation itself. Tool qualification applicability must be decided for the actual use case. [FAA AC 20-115D](https://www.faa.gov/airports/resources/advisory_circulars/index.cfm/go/document.information/documentNumber/20-115D); [RTCA overview](https://www.rtca.org/do-178/).

[^iso]: The linked primary source is ISO 26262-1:2018, the scope/vocabulary part of the road-vehicle functional-safety series. This review did not examine the complete paid standard. [ISO Part 1](https://www.iso.org/standard/68383.html).

[^sae]: SAE ARP4754B is a recommended practice for civil aircraft and systems development; applicability and qualification requirements are domain-specific. [SAE publication](https://saemobilus.sae.org/standards/arp4754b-guidelines-development-civil-aircraft-systems).

[^camel]: CaMeL's research proposes separating trusted control/data flow from untrusted material to address prompt injection. The research artifact is not a supported security product. [Primary paper](https://arxiv.org/abs/2503.18813); [authors' code](https://github.com/google-research/camel-prompt-injection).

[^codebeamer]: PTC describes Codebeamer requirements, traceability, risk, and ALM features. These are vendor claims, not a verified instance of this research's coverage receipt. [Official product page](https://www.ptc.com/en/products/codebeamer).

[^ibm]: IBM documents DOORS Next trace links, impact analysis, and coverage reporting. The exact documentation URL was indexed but direct automated fetch was restricted during this audit. [IBM traceability documentation](https://www.ibm.com/docs/en/engineering-lifecycle-management-suite/doors-next/7.1.0?topic=requirements-traceability).

[^siemens]: Siemens describes Polarion ALM requirements, workflow and traceability capabilities; feature breadth/versions require hands-on validation. [Official ALM page](https://www.siemens.com/en-us/products/polarion/application-lifecycle-management-alm/).

[^medceg]: MedCEG uses critical evidence graphs for clinical-model training and reward evaluation, not a general runtime permission or coverage gate. [ACL Anthology paper](https://aclanthology.org/2026.findings-emnlp.1088/).

[^nistprobes]: NIST describes adversarial evaluation probes using rubric-based LM judges against curated reference corpora. Do not call them independent deterministic verifiers. [NIST project](https://www.nist.gov/programs-projects/building-evaluation-probes-agentic-ai).

[^cochrane]: Cochrane's Handbook describes searching and selecting studies with explicit scope and exclusions; it is a methodological analogy, not an AI product control. [Current Chapter 4](https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-04).

[^outbox]: The cited Microsoft guidance presents the transactional outbox in a Cosmos DB architecture. The generic concept is useful; the example must not be mistaken for a universal implementation recipe. [Microsoft architecture guidance](https://learn.microsoft.com/en-us/azure/architecture/databases/guide/transactional-out-box-cosmos).

[^holarch]: Holarch is referenced as a possible model-import destination. Its current availability and successful import of these files were not independently established. [Application entry point](https://app.holarch.app/).

package EAH_Requirements {
    // Requirement usages are obligations, not assertions of satisfaction.

    requirement def HarnessInvariant {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
    }

    requirement def R001_DeterministicAuthority :> HarnessInvariant {
        doc /* Models may suggest interpretations, plans, and tool calls,
               but deterministic components retain policy, executable
               state, verification, and audit authority. */
    }
    requirement def R002_DurableConversation :> HarnessInvariant {
        doc /* A request gets a prompt conversational response after
               durable acceptance, while work continues asynchronously
               and can resume after interruption. */
    }
    requirement def R003_ClassificationAcrossBoundaries :> HarnessInvariant {
        doc /* Run applicable deterministic and semantic checks at
               input, source, proposed-action, tool-output, and
               generated-output boundaries. */
    }
    requirement def R004_NoFirstFailureShortCircuit :> HarnessInvariant {
        doc /* Do not stop the complete applicable validation pass at
               its first warning once scope and authorization permit.
               Aggregate findings within budget. A denied pre-check may
               terminate without inspecting protected evidence. */
    }
    requirement def R005_OneBatchPerIndividualAction :> HarnessInvariant {
        doc /* Show all currently evaluable classified findings for
               one exact action together. Explicitly disclose checks
               that could not run or yielded uncertain outcomes. */
    }
    requirement def R006_OverrideEveryClassifiedFinding :> HarnessInvariant {
        doc /* User acknowledgement and override are possible for
               every finding severity, including critical or dangerous
               warnings. Acceptance does not erase the finding, confer
               permission, or satisfy mandatory different-role waiver. */
    }
    requirement def R007_NoPermissionEscalation :> HarnessInvariant {
        doc /* Acknowledgement shall never grant roles, entitlements,
               resource access, policy changes, or action authority. */
    }
    requirement def R008_SingleUseActionBinding :> HarnessInvariant {
        doc /* One acknowledgement covers the shown finding set for
               exactly one individual action. A new invocation,
               argument change, target change, or changed finding set
               requires a fresh acknowledgement. */
    }
    requirement def R009_RecheckAuthorizationAtUse :> HarnessInvariant {
        doc /* Execution requires a separate current policy decision
               for the exact actor, operation, resource, arguments,
               and relevant source-system constraints. */
    }
    requirement def R010_EvidenceTruthScope :> HarnessInvariant {
        doc /* Each reported claim is grounded and labeled as verified
               under a specified contract, supported, inferred,
               contradicted, or unknown. The system must not present
               plausible unsupported content as verified fact. */
    }
    requirement def R011_TraversalAttestation :> HarnessInvariant {
        doc /* Control plane pins roots and scope. Harness enumerates
               authorized nodes and requires independently validated
               structured inspection results, accounts for all edges
               and leaves, and reports visits beyond the required set.
               This verifies a bounded graph contract, not truth. */
    }
    requirement def R012_IndependentGraphChallenge :> HarnessInvariant {
        doc /* Challenge the primary traversal using an independently
               implemented query or materially distinct method where
               available; disclose correlated failure risks or lack of
               an independent source instead of claiming corroboration. */
    }
    requirement def R013_ExplicitCompletenessBoundary :> HarnessInvariant {
        doc /* Graph coverage is never represented as proof that
               unmodeled real-world dependencies are absent or that
               a language model cognitively understood every node. */
    }
    requirement def R014_SiblingPatternReview :> HarnessInvariant {
        doc /* When suitable siblings exist, compare subgraphs using
               explicit equivalence criteria. Report deviations,
               absence of comparators, and justified design novelty. */
    }
    requirement def R015_GovernedReasoningProfiles :> HarnessInvariant {
        doc /* User-maintained domain prompts and patterns are versioned.
               Executable traversal, validation, output, and policy
               obligations remain machine-readable and change controlled. */
    }
    requirement def R016_ClassifierDisagreement :> HarnessInvariant {
        doc /* Independent deterministic and probabilistic checks may
               both emit findings. Preserve divergent signals and
               evidence instead of hiding inconvenient classifications. */
    }
    requirement def R017_ConstraintSemantics :> HarnessInvariant {
        doc /* A solver result refers only to encoded constraints and
               explicit assumptions. SAT, UNSAT, UNKNOWN, and not-run
               shall not be collapsed into a universal truth claim. */
    }
    requirement def R018_ProvenanceAndFreshness :> HarnessInvariant {
        doc /* Evidence carries source, baseline, timestamps or
               versions, and a freshness determination relative
               to the particular action and its required sources. */
    }
    requirement def R019_GovernedMemory :> HarnessInvariant {
        doc /* Generated hypotheses shall not silently overwrite
               authoritative state or become durable facts without
               provenance and validation policy. */
    }
    requirement def R020_InspectableAudit :> HarnessInvariant {
        doc /* Preserve work IDs, action identity, versioned inputs,
               decisions, acknowledgements, tool results, and checks
               so an independent auditor can reconstruct the process. */
    }
    requirement def R021_NoUnauthorizedDisclosure :> HarnessInvariant {
        doc /* Retrieved evidence and report contents must respect
               source permissions; references must not leak
               inaccessible information into other users' packets. */
    }
    requirement def R022_IntegrityOfProofArtifacts :> HarnessInvariant {
        doc /* The verifier derives or independently validates receipts.
               A model-authored assertion or schema-conforming JSON
               alone is not accepted as proof of completed work. Only
               use cryptographic attestation language for validated
               signatures over canonical payloads and provenance. */
    }
    requirement def R023_GracefulIncompleteOutcome :> HarnessInvariant {
        doc /* Unavailable source inventory, stale graph, resource
               budget exhaustion, and conflicting checks shall yield
               visible incomplete or inconclusive outcomes. */
    }
    requirement def R024_EngineeringSystemIntegration :> HarnessInvariant {
        doc /* The MBSE reference application should read authoritative
               baselines and return reviewable evidence to existing
               engineering workflows without creating a second
               authoritative system of record. */
    }
    requirement def R025_PinnedScopeAndRoot :> HarnessInvariant {
        doc /* Control plane or approved profile pins authorized root
               identifiers, relation rules, and scope. Model deviation
               becomes a finding and cannot self-ratify 100 percent. */
    }
    requirement def R026_PerNodeStructuredInspection :> HarnessInvariant {
        doc /* The deterministic harness enumerates scoped work items
               and validates one meaningful evidence-bearing disposition
               per required node. Repeating node IDs does not pass. */
    }
    requirement def R027_MissingEdgeEvaluation :> HarnessInvariant {
        doc /* Coverage of modeled edges shall not certify unmodeled
               links. Run a no-LLM historical escape study on graph
               baselines as-of the escape date before major investment. */
    }
    requirement def R028_MonotonicTaint :> HarnessInvariant {
        doc /* Trust and confidentiality propagation follows deterministic
               most-restrictive-label rules. Probabilistic classification
               may identify danger but cannot upgrade provenance. */
    }
    requirement def R029_DeterministicConsentRendering :> HarnessInvariant {
        doc /* Render action identity and risk acceptance controls from
               trusted structured data, not model-written instructions.
               Restrict displayed findings to viewer permissions. */
    }
    requirement def R030_SeparateRiskWaiver :> HarnessInvariant {
        doc /* Every severity can be acknowledged, but applicable policy
               may demand waiver by an authorized different principal,
               separate from actor acknowledgement and execution grant. */
    }
    requirement def R031_ReadOnlyDisclosure :> HarnessInvariant {
        doc /* An authorized read-only qualified answer may proceed with
               uncertainty disclosure when policy does not require
               active risk acknowledgement. */
    }
    requirement def R032_PlanAndBatchEffects :> HarnessInvariant {
        doc /* Evaluate combined effects of action sequences, bulk edits,
               and read-then-disclose flows in addition to the mandatory
               single-action review for each executable operation. */
    }
    requirement def R033_TwoPhaseAuthorization :> HarnessInvariant {
        doc /* Preauthorize before sensitive checks or review display;
               deny without revealing unauthorized evidence. At use,
               recheck exact actor, tool, arguments, and current policy. */
    }
    requirement def R034_PostExecutionIncident :> HarnessInvariant {
        doc /* Findings discovered after execution begin incident or
               remediation handling; retroactive acknowledgement does
               not convert an executed action into prior consent. */
    }
    requirement def R035_BudgetAndVisibility :> HarnessInvariant {
        doc /* Budget exhaustion, unavailable data, partial permissions,
               and hidden inventories yield bounded incomplete outputs.
               Never leak counts of inaccessible graph elements. */
    }
    requirement def R036_ClaimInventory :> HarnessInvariant {
        doc /* Probabilistic claim extraction itself is fallible. Check
               report claims against a deterministic obligation inventory,
               and disclose unanswered claims and omitted obligations. */
    }
    requirement def R037_BuildBuyFalsification :> HarnessInvariant {
        doc /* Compare Codex plus tooling, managed agents, existing MBSE,
               deterministic-only analysis, and thin verifier first.
               Set empirical kill criteria before custom harness build. */
    }
    requirement def R038_ReviewerBiasAndNetEconomics :> HarnessInvariant {
        doc /* Evaluate reviewer complacency, false assurance from badges,
               false positives, and human review costs. Distinguish
               gross error avoidance from net organizational value. */
    }
    requirement def R039_BoundedPriorArtClaims :> HarnessInvariant {
        doc /* Existing assurance cases, qualified tools, provenance,
               OSLC and exact invocation approvals constrain novelty
               claims. Treat qualification as buyer-specific obligation. */
    }
    requirement def R040_CompositionalLimits :> HarnessInvariant {
        doc /* Do not treat local gate results as end-to-end assurance.
               Document assumptions, model quality, correlation, races,
               mixed actions, and decision-making risks. */
    }

    // Machine-checkable receipt properties supplement the prose.
    // External deterministic gates must establish the recorded fields.
    requirement def AckIntegrity {
        subject ack : EAH_Common::RiskAcknowledgement;
        require constraint {
            ack.acceptedActionCount == 1 and
            ack.permissionChangeCount == 0
        }
    }
    requirement def ReviewPacketIntegrity {
        subject packet : EAH_Common::ReviewPacket;
        require constraint {
            packet.allCurrentlyEvaluablePresented and
            packet.classifiedFindingCount ==
                packet.disclosedFindingCount
        }
    }
    requirement def BoundedGraphReceiptIntegrity {
        subject receipt : EAH_Common::TraversalReceipt;
        require constraint {
            receipt.allRequiredNodesInspected and
            receipt.allRequiredEdgesAccounted and
            receipt.allRequiredLeavesInspected and
            receipt.excessVisitsDisclosed and
            receipt.structuredNodeDispositionsVerified and
            receipt.entryScopeValid and
            receipt.rootAndScopePinned and
            receipt.scopeDeviationClassified and
            receipt.terminationComplete and
            receipt.externallyRecomputed and
            receipt.limitationsDisclosed and
            receipt.visibilityBounded
        }
    }
    requirement def ConsentRenderingIntegrity {
        subject packet : EAH_Common::ReviewPacket;
        require constraint {
            packet.authorizationPrechecked and
            packet.renderedByTrustedControlPlane and
            packet.viewerScopeAuthorized
        }
    }
    requirement def SeparateWaiverIntegrity {
        subject waiver : EAH_Common::PolicyWaiver;
        require constraint {
            waiver.approvedByDifferentPrincipal and
            waiver.approvalAuthorityVerified
        }
    }
    requirement def NonAuthoritativeModelResponse {
        subject response : EAH_Common::ModelResponse;
        require constraint {
            response.bindingAuthority == false
        }
    }
    requirement def AuthorizationDecisionIntegrity {
        subject decision : EAH_Common::AuthorizationDecision;
        require constraint {
            decision.permissionMutation == false
        }
    }

    // Stable requirement usages for verification case objectives.
    requirement r001 : R001_DeterministicAuthority;
    requirement r002 : R002_DurableConversation;
    requirement r003 : R003_ClassificationAcrossBoundaries;
    requirement r004 : R004_NoFirstFailureShortCircuit;
    requirement r005 : R005_OneBatchPerIndividualAction;
    requirement r006 : R006_OverrideEveryClassifiedFinding;
    requirement r007 : R007_NoPermissionEscalation;
    requirement r008 : R008_SingleUseActionBinding;
    requirement r009 : R009_RecheckAuthorizationAtUse;
    requirement r010 : R010_EvidenceTruthScope;
    requirement r011 : R011_TraversalAttestation;
    requirement r012 : R012_IndependentGraphChallenge;
    requirement r013 : R013_ExplicitCompletenessBoundary;
    requirement r014 : R014_SiblingPatternReview;
    requirement r015 : R015_GovernedReasoningProfiles;
    requirement r016 : R016_ClassifierDisagreement;
    requirement r017 : R017_ConstraintSemantics;
    requirement r018 : R018_ProvenanceAndFreshness;
    requirement r019 : R019_GovernedMemory;
    requirement r020 : R020_InspectableAudit;
    requirement r021 : R021_NoUnauthorizedDisclosure;
    requirement r022 : R022_IntegrityOfProofArtifacts;
    requirement r023 : R023_GracefulIncompleteOutcome;
    requirement r024 : R024_EngineeringSystemIntegration;
    requirement r025 : R025_PinnedScopeAndRoot;
    requirement r026 : R026_PerNodeStructuredInspection;
    requirement r027 : R027_MissingEdgeEvaluation;
    requirement r028 : R028_MonotonicTaint;
    requirement r029 : R029_DeterministicConsentRendering;
    requirement r030 : R030_SeparateRiskWaiver;
    requirement r031 : R031_ReadOnlyDisclosure;
    requirement r032 : R032_PlanAndBatchEffects;
    requirement r033 : R033_TwoPhaseAuthorization;
    requirement r034 : R034_PostExecutionIncident;
    requirement r035 : R035_BudgetAndVisibility;
    requirement r036 : R036_ClaimInventory;
    requirement r037 : R037_BuildBuyFalsification;
    requirement r038 : R038_ReviewerBiasAndNetEconomics;
    requirement r039 : R039_BoundedPriorArtClaims;
    requirement r040 : R040_CompositionalLimits;
    requirement ackIntegrity : AckIntegrity;
    requirement reviewIntegrity : ReviewPacketIntegrity;
    requirement coverageIntegrity : BoundedGraphReceiptIntegrity;
    requirement consentIntegrity : ConsentRenderingIntegrity;
    requirement waiverIntegrity : SeparateWaiverIntegrity;
    requirement modelNonAuthority : NonAuthoritativeModelResponse;
    requirement policyNonMutation : AuthorizationDecisionIntegrity;
}

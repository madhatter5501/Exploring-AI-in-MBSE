package EAH_Verification {
    // These are proposed verification cases; no PASS result is assumed.

    verification def DeterministicAuthorityBoundaryTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r001;
        }
        action injectModelResponseProposingPolicyOverride;
        then action denyModelGeneratedPolicyChange;
        then action verifyControlPlaneOwnsStateAndToolBinding;
    }

    verification def QualifiedReadOnlyDisclosureTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r031;
            verify EAH_Requirements::r005;
        }
        action requestAuthorizedReadOnlyEngineeringSummary;
        then action identifyIncompleteOrQualifiedEvidence;
        then action discloseUncertaintyWithoutForcingAcknowledgement;
        then action requireAcknowledgementForSeparateEffectfulAction;
    }

    verification def ActionRiskOverrideTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r005;
            verify EAH_Requirements::r006;
            verify EAH_Requirements::r007;
            verify EAH_Requirements::r008;
            verify EAH_Requirements::r009;
        }
        action proposeOneDangerousOperation;
        then action injectSeveralClassifierFindings;
        then action presentAllFindingsTogether;
        then action acceptOneActionBoundAcknowledgement;
        then action attemptReplayWithDifferentArguments;
        then action expectReplayRejection;
        then action attemptOperationWithoutExistingPermission;
        then action expectAuthorizationDenial;
        // Risk acceptance must remain possible; execution still denied.
    }

    verification def AcknowledgementReceiptTest {
        subject ack : EAH_Common::RiskAcknowledgement;
        objective {
            verify EAH_Requirements::ackIntegrity;
        }
        action inspectAcceptedActionCount;
        then action inspectPermissionChangeCount;
        then action compareExactActionAndFindingDigests;
    }

    verification def BoundaryClassificationTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r003;
            verify EAH_Requirements::r004;
            verify EAH_Requirements::r005;
            verify EAH_Requirements::r016;
            verify EAH_Requirements::r023;
        }
        action injectInputWarningAndSourceInjection;
        then action injectProposedToolRisk;
        then action injectToolOutputWarning;
        then action injectGeneratedAnswerRisk;
        then action inspectWholeFindingSet;
        then action inspectNonEvaluableCheckDisclosure;
    }

    verification def GraphTraversalGateTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r011;
            verify EAH_Requirements::r012;
            verify EAH_Requirements::r013;
            verify EAH_Requirements::r022;
            verify EAH_Requirements::r023;
            verify EAH_Requirements::r025;
            verify EAH_Requirements::r026;
            verify EAH_Requirements::r035;
        }
        action pinRootsAndScopeOutsideModel;
        then action freezeAuthorizedBaselineAndContract;
        then action computeRequiredReachableNodeEdgeLeafSets;
        then action supplyEachNodeForStructuredInspection;
        then action injectIdEchoMissingDispositionAndPrematureTermination;
        then action testLegitimateExtraNodeVisitAndDisclosure;
        then action independentlyRecomputeRequiredSubset;
        then action refuseCleanReceiptForWrongRootOrBudgetExhaustion;
        // A source-absent trace cannot be caught by this test alone.
    }

    verification def TraversalReceiptDataTest {
        subject receipt : EAH_Common::TraversalReceipt;
        objective {
            verify EAH_Requirements::coverageIntegrity;
        }
        action inspectSubsetCoverageAndStructuredNodeResults;
        then action inspectReportedExcessVisits;
        then action inspectScopeAndTerminationFlags;
        then action confirmIndependentDerivation;
        then action confirmLimitationsVisible;
    }

    verification def ModelHasNoAuthorityTest {
        subject response : EAH_Common::ModelResponse;
        objective {
            verify EAH_Requirements::modelNonAuthority;
        }
        action supplyPromptInjectedToolOutput;
        then action inspectModelResponseAuthorityFlag;
    }

    verification def PolicyNoMutationTest {
        subject decision : EAH_Common::AuthorizationDecision;
        objective {
            verify EAH_Requirements::policyNonMutation;
        }
        action checkUnmodifiedPermissionState;
        then action inspectDecisionForExactAction;
    }

    verification def EvidenceAndMemoryTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r010;
            verify EAH_Requirements::r017;
            verify EAH_Requirements::r018;
            verify EAH_Requirements::r019;
            verify EAH_Requirements::r020;
            verify EAH_Requirements::r021;
        }
        action injectContradictorySourceAndUnknownClaim;
        then action returnUnknownOrInconclusiveSolverOutcome;
        then action preventUnsupportedVerifiedLabel;
        then action preventUnreviewedMemoryPromotion;
        then action redactUnauthorizedEvidence;
        then action inspectReconstructibleAuditTrail;
    }

    verification def SiblingGraphNoveltyTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r014;
            verify EAH_Requirements::r015;
        }
        action chooseEquivalentSiblingGraphs;
        then action insertValidNovelArchitecture;
        then action inspectDeviationWithRationale;
        then action ensureNoveltyNotForcedToConform;
        then action attemptProfilePermissionEscalation;
        then action expectProfileChangeDenial;
    }

    verification def DurableRecoveryTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r002;
            verify EAH_Requirements::r020;
        }
        action durablyAcceptWorkAndRespond;
        then action interruptWorkerMidAnalysis;
        then action resumeWithoutDuplicatingAction;
        then action inspectStateTransitionsAndAuditEntries;
    }
}

package EAH_TradeStudies {
    private import ScalarValues::*;

    enum def CandidateKind {
        CodexPlusDeterministicTools; ManagedAgentWithExternalGates;
        ExistingMbseTooling; DeterministicGraphOnly;
        ThinVerifierAroundExistingAgent; CustomGeneralHarness;
    }
    enum def Disposition {
        Preferred; ViableAlternative; InsufficientEvidence;
        RejectedByConstraint; Deferred;
    }
    item def CandidateArchitecture {
        attribute candidateId : String;
        attribute kind : CandidateKind;
        attribute vendorOrProject : String;
        attribute supportedDeployment : String;
        attribute ownershipBoundary : String;
        attribute dataAndModelIntegrationCost : Real;
        attribute qualificationEvidenceAvailable : Boolean;
        attribute additionalControlsRequired : String;
        attribute currentlyVerifiedCapabilityEvidence : String;
        attribute unsupportedMarketingAssumptions : String;
    }
    item def SelectionCriterion {
        attribute criterionId : String;
        attribute definition : String;
        attribute mandatory : Boolean;
        attribute evidenceRequired : String;
        attribute weightingApprovedBy : String;
        attribute failureThreshold : String;
    }
    item def CandidateScore {
        attribute candidateId : String;
        attribute criterionId : String;
        attribute measuredScore : Real;
        attribute measurementMethod : String;
        attribute uncertaintyDescription : String;
        attribute evidenceId : String;
    }
    item def TradeStudyDecision {
        attribute studyId : String;
        attribute targetUseCase : String;
        attribute selectedCandidateId : String;
        attribute baselineVersion : String;
        item candidates : CandidateArchitecture[0..*];
        item criteria : SelectionCriterion[0..*];
        item scores : CandidateScore[0..*];
        attribute decision : Disposition;
        attribute counterArgumentsAndLimitations : String;
        attribute preRegisteredKillRuleId : String;
        attribute evaluatorIndependence : String;
    }

    part def CodexWithScopedTools {
        // Existing coding agent plus deterministic graph-checking service.
        // Avoid inventing missing abilities; measure them against the task.
    }
    part def ManagedAgentAndPolicyService {
        // Existing orchestrator, memory, access policies and external gates.
    }
    part def ExistingMBSEWorkflow {
        // Native graph queries, change impact, review and safety processes.
    }
    part def DeterministicImpactAnalyzer {
        // No LLM: direct graph and rule queries with human interpretation.
    }
    part def ThinEvidenceVerifier {
        // Adds obligation enumeration, receipt checks and provenance.
        // May be adequate without a new general-purpose orchestration stack.
    }
    part def CustomHarnessCandidate {
        part architecture : EAH_Architecture::EvidenceAttestedHarness;
    }
    part def AlternativePortfolio {
        part codex : CodexWithScopedTools;
        part managed : ManagedAgentAndPolicyService;
        part existingEngineering : ExistingMBSEWorkflow;
        part deterministic : DeterministicImpactAnalyzer;
        part thinService : ThinEvidenceVerifier;
        part purposeBuilt : CustomHarnessCandidate;
    }

    analysis def DecideBuildBuyComposeFirst {
        subject portfolio : AlternativePortfolio;
        action freezeRepresentativeEngineeringChangeDataset;
        then action specifyNonNegotiablePermissionsAndAuditConstraints;
        then action evaluateExistingSysMLGraphQueryAndImpactFeatures;
        then action inspectExistingAgentInvocationBoundConsentAndTaint;
        then action testDeterministicOnlyAgainstHistoricalEscapes;
        then action testCodexAndManagedAgentsWithIdenticalScope;
        then action assessThinVerificationService;
        then action compareQualificationCostsAndOperationalBurdens;
        then action selectLeastComplexCandidateThatMeetsThresholds;
        // An architecture is not selected simply for being agentic.
    }
    verification def ExistingSystemSubstitutionTest {
        subject study : TradeStudyDecision;
        objective {
            verify EAH_Requirements::r037;
            verify EAH_Requirements::r039;
            verify EAH_Requirements::r040;
        }
        action runSameChangesThroughExistingMBSEQueries;
        then action runThroughCodexWithApprovalBoundToExactCall;
        then action runThroughManagedAgentAndPolicyGate;
        then action runThroughThinVerifierPrototype;
        then action compareIncrementalMissesAndUnsafeApprovals;
        then action rejectCustomBuildIfNoIncrementalNetBenefit;
    }
    verification def QualificationBuyerFitTest {
        subject study : TradeStudyDecision;
        objective {
            verify EAH_Requirements::r039;
            verify EAH_Requirements::r024;
        }
        action identifyBuyerDomainAndGoverningAssuranceStandards;
        then action determineWhetherToolOutputReplacesHumanVerification;
        then action identifyToolQualificationAndSafetyCaseObligations;
        then action assessAuditArtifactIntegrityAndReproducibility;
        then action markNonCompliantOrUnknownClaimsExplicitly;
    }
}

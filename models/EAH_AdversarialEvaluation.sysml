package EAH_AdversarialEvaluation {
    private import ScalarValues::*;
    private import EAH_Common::*;

    enum def EvaluationPhase {
        PhaseZeroHistoricalEscapes; BaselineFeasibility;
        DeterministicPrototype; ModelAssistedTrial; BuyerPilot;
    }
    enum def GateDecision {
        Proceed; Reframe; Stop; EvidenceInsufficient;
    }
    enum def DetectionClass {
        ExistingWorkflow; DeterministicGraph;
        ExistingAgentWithTools; NewHarness;
        OutsideAllKnownMethods;
    }
    item def HistoricalEscape {
        attribute escapeId : String;
        attribute eventDate : String;
        attribute affectedSystem : String;
        attribute engineeringFailureDescription : String;
        attribute originalGraphBaselineId : String;
        attribute asOfSnapshotHash : String;
        attribute sourceDataWasRecoverable : Boolean;
        attribute startingRootUnderPolicy : String;
        attribute dependencyClassification : HistoricalEscapeClass;
        attribute contemporaneousLinkEvidence : String;
        attribute outOfScopeReason : String;
        attribute retrospectivelyAddedLink : Boolean;
        attribute independentAdjudicationIds : String;
        attribute disputedOrUnknowable : Boolean;
        // Never repair the historical baseline before assessing detection.
    }
    item def EscapeDataset {
        attribute datasetId : String;
        attribute retrospectiveSelectionRule : String;
        attribute selectedCount : Integer;
        attribute targetMinimum : Integer = 20;
        attribute targetMaximum : Integer = 30;
        attribute samplingBiasLimitations : String;
        attribute evidenceRetentionPolicy : String;
        attribute languageModelsUsedForClassification : Boolean = false;
        item escapes : HistoricalEscape[0..*];
    }
    item def PhaseZeroResult {
        attribute datasetId : String;
        attribute presentAndReachableCount : Integer;
        attribute presentOutOfScopeCount : Integer;
        attribute absentFromModelCount : Integer;
        attribute indeterminateCount : Integer;
        attribute catchableByScopedTraversal : Integer;
        attribute catchableByBetterScopeContract : Integer;
        attribute requiresNewDataOrNewEngineeringProcess : Integer;
        attribute baselineDataIntegrityConfirmed : Boolean;
        attribute decision : GateDecision;
        attribute killOrReframeRationale : String;
        attribute adoptionConditionalOnNewEvidence : Boolean;
    }
    item def PreRegisteredKillCriteria {
        attribute protocolId : String;
        attribute signedBeforeEvaluation : Boolean;
        attribute missingEdgeFractionThreshold : Real;
        attribute minimumRecoverableCases : Integer;
        attribute requiredIncrementalRecall : Real;
        attribute maximumFalsePositivePerChange : Real;
        attribute maximumReviewerHoursPerChange : Real;
        attribute maximumLatencyPerChange : Real;
        attribute allowableAutomationBiasIncrease : Real;
        attribute requiredNetValueThreshold : Real;
        attribute safetyQualificationFeasible : Boolean;
        attribute applicableBaseline : String;
        // Values are to be approved by a buyer, not invented by the model.
    }
    item def EvaluationArm {
        attribute armId : String;
        attribute method : DetectionClass;
        attribute modelAndPromptVersions : String;
        attribute sameAuthorizedEvidenceDigest : String;
        attribute sameBudgetEnvelope : String;
        attribute blindedReviewerAssignment : String;
        attribute sourceDataVersion : String;
        attribute independentScoringProtocol : String;
    }
    item def EvaluationMetrics {
        attribute sampleId : String;
        attribute latentCriticalEscapes : Integer;
        attribute trueFindings : Integer;
        attribute missedFindings : Integer;
        attribute falsePositiveFindings : Integer;
        attribute unsupportedClaims : Integer;
        attribute coverageGateFalsePasses : Integer;
        attribute meanReviewHours : Real;
        attribute medianEndToEndLatency : Real;
        attribute reviewerUnsafeAcceptanceCount : Integer;
        attribute reviewerMissedCriticalWarningCount : Integer;
        attribute uncertaintyIntervalDescription : String;
        attribute smallSampleLimitation : String;
    }
    item def ReviewerBiasTrial {
        attribute trialId : String;
        attribute randomizedAssignment : Boolean;
        attribute conditionShowsCoverageBadge : Boolean;
        attribute verifiedScopeWarningShown : Boolean;
        attribute artificialFalseAssuranceInjected : Boolean;
        attribute hiddenErrorsInScenario : Integer;
        attribute errorsCaughtByReviewer : Integer;
        attribute unsafeSignoffs : Integer;
        attribute reviewerTimeMinutes : Real;
        attribute consentRubberStampRate : Real;
        attribute debriefAndEthicsProcess : String;
    }
    item def EconomicScenario {
        attribute scenarioId : String;
        attribute changesPerYear : Integer;
        attribute eventsAvoided : Integer;
        attribute grossAvoidedFailureCost : Real;
        attribute incrementalReviewerHours : Real;
        attribute loadedReviewerHourlyRate : Real;
        attribute extraEvaluationAndComputeCost : Real;
        attribute qualificationAndIntegrationCost : Real;
        attribute ongoingMaintenanceAndIncidentCost : Real;
        attribute netValueAfterCosts : Real;
        attribute confidenceOrSensitivityBounds : String;
        // Example: four extra hours x 500 changes x $150 = $300,000.
        // Gross avoided cost is not the project's return on investment.
    }
    item def EvaluationReport {
        attribute reportId : String;
        attribute phase : EvaluationPhase;
        item phaseZero : PhaseZeroResult[0..1];
        item criteria : PreRegisteredKillCriteria;
        item arms : EvaluationArm[0..*];
        item measures : EvaluationMetrics[0..*];
        item biasTrials : ReviewerBiasTrial[0..*];
        item economics : EconomicScenario[0..*];
        attribute limitationsAndUnmeasuredRisks : String;
        attribute recommendation : GateDecision;
        attribute independentReproducibilityEvidence : String;
    }

    action def ExecutePhaseZeroWithoutModel {
        in item dataset : EscapeDataset;
        out item result : PhaseZeroResult;
        action preregisterSamplingAndKillRule;
        then action selectTwentyToThirtyHistoricalEngineeringEscapes;
        then action recoverGraphAndPermissionsAsTheyExistedAtEvent;
        then action identifyOriginalScopeRootsAndRelevantDependencies;
        then action classifyPresentReachablePresentOutOfScopeOrAbsent;
        then action independentlyAdjudicateDisputedCases;
        then action estimateWhichEscapesTraversalCouldHaveCaught;
        then action decideStopReframeOrProceedWithoutLanguageModels;
    }
    action def ConductControlledComparison {
        in item criteria : PreRegisteredKillCriteria;
        out item evaluation : EvaluationReport;
        action lockDatasetAndBaselineSourcePermissions;
        then action compareExistingEngineeringWorkflow;
        then action compareDeterministicQueryAndGraphBaseline;
        then action compareCodexAndManagedAgentWithSameEvidence;
        then action compareThinVerifierAndFullHarness;
        then action independentlyScoreClaimCompletenessAndFalsePositives;
        then action compareLatencyCostsAndSafetyReviewOutcomes;
        then action reportConfidenceIntervalsAndCorrelatedErrors;
        then action applyPreRegisteredStopCriteria;
    }
    action def MeasureReviewerAutomationBias {
        in item trial : ReviewerBiasTrial;
        out item result : ReviewerBiasTrial;
        action obtainEthicallyAppropriateTestApproval;
        then action randomizeBadgeAndEvidencePresentation;
        then action assignBlindedReviewers;
        then action embedKnownDocumentedMisses;
        then action measureErrorsCaughtAndUnsafeApprovals;
        then action compareComplacencyAcrossConditions;
        then action debriefAndRecordLimitations;
    }
    analysis def FalsificationBeforeImplementation {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        action identifyValueHypothesesAndTestableCounterfactuals;
        then action recoverHistoricalModelBaseline;
        then action classifyEscapesWithoutLanguageModel;
        then action issueProceedOrStopDecision;
        then action compareMinimumViableAlternative;
        then action testReviewerPerformanceAndEconomicNetValue;
        // A statistically small pilot supports a decision, not a claim
        // of general effectiveness or safety qualification.
    }
    verification def HistoricalEscapeClassificationTest {
        subject dataset : EscapeDataset;
        objective {
            verify EAH_Requirements::r027;
            verify EAH_Requirements::r037;
            verify EAH_Requirements::r013;
        }
        action injectUnmodeledDependencyIntoHistoricalEscape;
        then action loadOnlyContemporaneousBaseline;
        then action compareReachabilityAgainstArchivedScope;
        then action classifyDependencyAsAbsentFromBaseline;
        then action ensureCoverageGateDoesNotClaimRealWorldCompleteness;
        then action refuseToRetrospectivelyBackfillHistoricalGraph;
    }
    verification def PinnedScopeCounterexampleTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r025;
            verify EAH_Requirements::r011;
        }
        action modelSuggestsWrongBatterySubsystemRoot;
        then action deterministicScopeAuthorityRejectsSubstitution;
        then action introduceArtificiallyNarrowRelationSet;
        then action reportPolicyDeviationAsFinding;
        then action assertNoCleanCoverageLabel;
    }
    verification def IncompleteBudgetTest {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        objective {
            verify EAH_Requirements::r023;
            verify EAH_Requirements::r035;
        }
        action constructDenseCyclicTraceabilityGraph;
        then action exhaustDeclaredNodeAndTimeBudget;
        then action observeIncompleteNonPassingOutcome;
        then action compareTwoVisibilityLimitedActors;
        then action verifyNeitherLearnsHiddenCountOrIdentity;
    }
    verification def ReviewerComplacencyTest {
        subject trial : ReviewerBiasTrial;
        objective {
            verify EAH_Requirements::r038;
            verify EAH_Requirements::r040;
        }
        action randomizeCoverageBadgeVisibility;
        then action includeKnownBlindSpotUnmodeledLink;
        then action scoreReviewerMistakesAndRubberStamping;
        then action evaluateWhetherBadgeHarmsJudgment;
        then action rejectDeploymentIfUnsafeBiasExceedsThreshold;
    }
    verification def EconomicKillGateTest {
        subject result : EvaluationReport;
        objective {
            verify EAH_Requirements::r037;
            verify EAH_Requirements::r038;
        }
        action calculateGrossErrorAvoidance;
        then action accountForIncrementalReviewerTime;
        then action accountForRuntimeIntegrationAndQualificationCost;
        then action compareNetValueAgainstCheapestAdequateAlternative;
        then action enforcePreRegisteredStopOrReframeThreshold;
    }
}

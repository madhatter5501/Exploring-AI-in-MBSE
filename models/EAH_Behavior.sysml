package EAH_Behavior {
    private import ScalarValues::*;
    private import EAH_Common::*;

    action def IntakeAndRespond {
        in item request : UserRequest;
        out item reply : ImmediateReply;
        out item ticket : WorkTicket;

        action captureAndIdentify;
        then action durablyEnqueue;
        then action sendImmediateConversationalReply;
        // The queued work proceeds asynchronously after the reply.
    }

    action def RunFiveBoundaryClassification {
        in item ticket : WorkTicket;
        out item findings : ClassificationBatch;

        action inspectUserInput;
        then action inspectRetrievedSources;
        then action inspectProposedAction;
        then action inspectToolOutputsWhenAvailable;
        then action inspectGeneratedOutput;
        then action normalizeAndDeduplicate;
        // These steps describe required coverage, not sequential blocking.
        // Deferred boundaries are recorded as not yet evaluable.
    }

    action def AssessContextAndPlan {
        in item ticket : WorkTicket;
        out item modelResponse : ModelResponse;

        action selectVersionedProfile;
        then action assessContextSufficiency;
        then action requestMissingContextWhenNecessary;
        then action useLargerReasonerWhenApplicable;
        // Model responses remain non-authoritative.
    }

    action def VerifyGraphTraversal {
        in item graphSnapshot : GraphSnapshot;
        in item contract : TraversalContract;
        out item traversal : TraversalReceipt;

        action freezeSnapshotAndConfirmAccess;
        then action checkControlPlanePinnedRootsAndScope;
        then action deriveRequiredReachabilityWithinBudget;
        then action provideEachNodeToReasoningWorker;
        then action collectStructuredDispositionPerRequiredNode;
        then action independentlyValidateDispositionsAndEdges;
        then action checkRequiredSubsetAndReportExtraVisits;
        then action classifyScopeDeviationMissingLinksAndBudgetGaps;
        then action validateTerminationAndLimitations;
        // Does not establish correctness of absent source-model links.
    }

    action def IndependentlyChallengeTraversal {
        in item traversal : TraversalReceipt;
        out item corroboration : CorroborationReceipt;

        action selectAlternativeMethod;
        then action documentDataLineage;
        then action independentlyEnumerate;
        then action compareCanonicalResults;
        then action classifyCorrelatedFailureRisks;
        then action reportDifferencesAndUnresolvedChecks;
    }

    action def CompareSiblingSubgraphs {
        in item request : SiblingComparisonRequest;
        out item result : SiblingComparisonResult;

        action selectComparableSiblings;
        then action recordSelectionCriteria;
        then action extractEstablishedPatterns;
        then action findDeviations;
        then action preserveJustifiedNovelty;
        then action attachSiblingEvidence;
    }

    action def PrepareActionReview {
        in item ticket : WorkTicket;
        out item packet : ReviewPacket;

        action preauthorizeActionAndViewerScope;
        then action denyEarlyWithoutLeakingProtectedFindings;
        then action runAllApplicableDeterministicChecks;
        then action runAllApplicableSemanticChecks;
        then action combinePlanLevelEffects;
        then action collectGraphConstraintAndModelFindings;
        then action deduplicateAndClassifyByAction;
        then action renderSanitizedFindingsByTrustedControlPlane;
        then action discloseIncompleteChecks;
        then action bindPacketToExactActionDigest;
        // Early authorization denial may skip sensitive downstream checks.
        // No model-written instruction can alter the displayed consent target.
    }

    action def RecordSingleActionDisposition {
        in item packet : ReviewPacket;
        out item acknowledgement : RiskAcknowledgement;

        action showAllFindingsTogether;
        then action acceptUserDisposition;
        then action bindActorActionDigestAndFindingSet;
        then action recordSingleUseAcknowledgement;
        then action checkWhetherSeparateRoleWaiverIsNeeded;
        // Severity never disables acknowledgement; policy may require
        // a distinct authorized approver before execution.
    }

    action def CheckPermissionAndExecute {
        in item actionProposal : ProposedAction;
        in item acknowledgement : RiskAcknowledgement;
        out item outcome : ToolOutcome;

        action verifyExactActionAndReceiptBinding;
        then action verifyRequiredDistinctRoleWaivers;
        then action checkCurrentResourcePermissions;
        then action checkSnapshotAndPolicyFreshness;
        then action denyOrExecuteAccordingToPolicy;
        then action inspectToolOutcome;
        then action initiateIncidentIfNewPostExecutionFinding;
        then action appendAuditRecord;
        // No action executes because a finding was overridden.
    }

    action def PublishGroundedResult {
        in item evidence : EvidencePacket;
        out item report : FinalReport;

        action assignClaimSpecificEvidenceStatus;
        then action rejectUnsupportedVerificationClaims;
        then action classifyGeneratedNarrative;
        then action redactUnauthorizedEvidence;
        then action showScopeAndUnresolvedChecks;
        then action emitReportAndAuditRecord;
    }

    action def PromoteMemoryWithProvenance {
        in item request : MemoryOperation;
        out item decision : MemoryDecision;

        action confirmSourceAndActorPermission;
        then action preserveSourceAndVersion;
        then action evaluateConfidenceAndContradictions;
        then action recordPromotionOrRejection;
    }

    state def DurableWorkLifecycle {
        entry;
        then acceptedWork;
        state acceptedWork;
        state queued;
        state processing;
        state waitingForClarification;
        state waitingForReview;
        state completed;
        state failed;
        state cancelled;

        transition first acceptedWork then queued;
        transition first queued then processing;
        transition first processing then waitingForClarification;
        transition first waitingForClarification then processing;
        transition first processing then waitingForReview;
        transition first waitingForReview then processing;
        transition first processing then completed;
        transition first processing then failed;
        transition first queued then cancelled;
        // Operational guards, retry policy and timeouts are external rules.
    }

    state def IndividualActionLifecycle {
        in attribute hasFindings : Boolean;
        in attribute preauthorized : Boolean;
        in attribute allEvaluableFindingsDisclosed : Boolean;
        in attribute checksCurrent : Boolean;
        in attribute acknowledgementValid : Boolean;
        in attribute waiverRequired : Boolean;
        in attribute waiverValid : Boolean;
        in attribute readOnlyDisclosureSufficient : Boolean;
        in attribute permissionGranted : Boolean;
        in attribute actionUnchanged : Boolean;
        in attribute toolFinished : Boolean;
        in attribute hasPostExecutionFindings : Boolean;

        entry;
        then proposed;
        state proposed;
        state prechecking;
        state evaluating;
        state reviewReady;
        state awaitingAcknowledgement;
        state awaitingWaiver;
        state awaitingAuthorization;
        state executing;
        state evaluated;
        state incidentReview;
        state denied;
        state invalidated;
        state inconclusive;

        transition first proposed then prechecking;
        transition first prechecking if preauthorized then evaluating;
        transition first prechecking if not preauthorized then denied;
        transition first evaluating
            if allEvaluableFindingsDisclosed and checksCurrent
            then reviewReady;
        transition first evaluating
            if not checksCurrent
            then inconclusive;
        transition first reviewReady
            if hasFindings and not readOnlyDisclosureSufficient
            then awaitingAcknowledgement;
        transition first reviewReady
            if not hasFindings or readOnlyDisclosureSufficient
            then awaitingAuthorization;
        transition first awaitingAcknowledgement
            if acknowledgementValid and actionUnchanged and waiverRequired
            then awaitingWaiver;
        transition first awaitingAcknowledgement
            if acknowledgementValid and actionUnchanged and not waiverRequired
            then awaitingAuthorization;
        transition first awaitingAcknowledgement
            if not actionUnchanged
            then invalidated;
        transition first awaitingWaiver if waiverValid then awaitingAuthorization;
        transition first awaitingWaiver if not actionUnchanged then invalidated;
        transition first awaitingAuthorization
            if permissionGranted and actionUnchanged and checksCurrent
            then executing;
        transition first awaitingAuthorization
            if not permissionGranted
            then denied;
        transition first awaitingAuthorization
            if not actionUnchanged or not checksCurrent
            then invalidated;
        transition first executing
            if toolFinished and not hasPostExecutionFindings
            then evaluated;
        transition first executing
            if toolFinished and hasPostExecutionFindings
            then incidentReview;
        // A changed action or changed finding set needs a fresh receipt.
    }

    state def TraversalAssuranceLifecycle {
        in attribute snapshotFrozen : Boolean;
        in attribute pinnedRootsAndScope : Boolean;
        in attribute requiredNodesInspected : Boolean;
        in attribute requiredEdgesAccounted : Boolean;
        in attribute requiredLeavesInspected : Boolean;
        in attribute structuredDispositionsValid : Boolean;
        in attribute excessVisitsDisclosed : Boolean;
        in attribute budgetAvailable : Boolean;
        in attribute alternativeChecksSatisfied : Boolean;
        in attribute staleSnapshot : Boolean;

        entry;
        then unexamined;
        state unexamined;
        state evaluating;
        state verifiedUnderContract;
        state incomplete;
        state inconsistent;
        state stale;

        transition first unexamined then evaluating;
        transition first evaluating
            if snapshotFrozen and pinnedRootsAndScope
               and requiredNodesInspected and requiredEdgesAccounted
               and requiredLeavesInspected and structuredDispositionsValid
               and excessVisitsDisclosed and budgetAvailable
               and alternativeChecksSatisfied and not staleSnapshot
            then verifiedUnderContract;
        transition first evaluating
            if not requiredNodesInspected or not requiredEdgesAccounted
               or not requiredLeavesInspected or not structuredDispositionsValid
               or not budgetAvailable or not pinnedRootsAndScope
            then incomplete;
        transition first evaluating
            if not alternativeChecksSatisfied
            then inconsistent;
        transition first evaluating
            if staleSnapshot
            then stale;
    }

    use case def EvidenceBasedEngineeringChangeReview {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        actor reviewer : EAH_Architecture::HumanReviewer;
        objective {
            doc /* Explain engineering change impact with scoped graph
                   coverage, independent challenges, disclosed findings,
                   and a governed single-action decision. */
        }
        action submitChangeRequest;
        then action precheckAuthorizationAndEnumerateScopedGraph;
        then action inspectEvidencePacketAndPlanEffects;
        then action discloseOrAcknowledgePerIndividualAction;
        then action obtainDistinctRoleWaiverWhenRequired;
        then action receiveGroundedResult;
    }

    analysis def ComparativeAssuranceEvaluation {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        action classifyHistoricalEscapesWithoutLanguageModel;
        then action evaluateMissingLinkRecoverabilityAndKillGate;
        then action compareBuildBuyOrComposeAlternatives;
        then action selectBlindedHistoricalChanges;
        then action runExistingMBSEWorkflow;
        then action runDeterministicGraphBaseline;
        then action runCodexOrManagedAgentBaseline;
        then action runProposedCoverageAndReviewContract;
        then action scoreRecallFalsePositivesAndAutomationBias;
        then action assessGrossValueMinusReviewerAndLifecycleCost;
        // Study results, not this declaration, establish added value.
    }
}

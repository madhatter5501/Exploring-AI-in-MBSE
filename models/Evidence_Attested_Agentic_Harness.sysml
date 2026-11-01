package EAH_Common {
    private import ScalarValues::*;

    // Vocabulary is provider-neutral and does not grant authority.
    enum def RiskSeverity {
        Informational; Low; Moderate; High; Critical;
    }
    enum def FindingKind {
        Safety; Injection; SensitiveData; PolicyConflict;
        ConstraintViolation; GraphGap; Inconsistency;
        InsufficientEvidence; StaleSource; MissingTraceLink;
        RootScopeDeviation; CombinedEffect; Other;
    }
    enum def FindingStatus {
        Open; AcceptedRisk; FalsePositive; Resolved; Superseded;
    }
    enum def EvidenceStatus {
        VerifiedUnderContract; Supported; Inferred;
        Contradicted; Unknown; Stale; Inconclusive; Disputed;
    }
    enum def ClassifierBoundary {
        UserInput; RetrievedSource; ProposedAction;
        ToolOutput; GeneratedOutput;
    }
    enum def CheckStatus {
        Passed; Failed; Inconclusive; NotEvaluated;
    }
    enum def SolverOutcome {
        Satisfiable; Unsatisfiable; UnknownResult; NotRun;
    }
    enum def ReviewDecision {
        AcknowledgeAll; RequestRevision; NoDisposition;
    }
    enum def AuthorizationOutcome {
        Allowed; Denied; NeedsExternalApproval;
    }
    enum def WorkStatus {
        Accepted; Queued; Running; WaitingForUser;
        Completed; Failed; Cancelled;
    }
    enum def IntegrityLabel {
        TrustedControl; VerifiedSource; UntrustedExternal;
        ModelGenerated;
    }
    enum def ConfidentialityLabel {
        Public; Internal; Restricted; Secret;
    }
    enum def BudgetOutcome {
        WithinBudget; Exhausted; Interrupted; NotEvaluated;
    }
    enum def AuthorizationPhase {
        PreReview; AtExecution;
    }
    enum def HistoricalEscapeClass {
        PresentAndReachable; PresentButOutOfScope;
        AbsentFromBaseline; Indeterminate;
    }
    enum def WaiverRequirement {
        NoneRequired; SeparateRiskOwner; ExternalRegulatedApproval;
    }

    item def ActorIdentity {
        attribute principalId : String;
        attribute tenantId : String;
        attribute identityProvider : String;
    }
    item def UserRequest {
        attribute requestId : String;
        attribute conversationId : String;
        attribute submittedBy : String;
        attribute inputText : String;
        attribute receivedAt : String;
    }
    item def ImmediateReply {
        attribute requestId : String;
        attribute workId : String;
        attribute conversationalText : String;
        attribute durableAcceptanceRecorded : Boolean;
    }
    item def WorkTicket {
        attribute workId : String;
        attribute requestId : String;
        attribute actorId : String;
        attribute status : WorkStatus;
        attribute currentStateVersion : Integer;
        attribute idempotencyKey : String;
    }
    item def WorkAccepted {
        attribute workId : String;
        attribute committed : Boolean;
    }
    item def ReasoningProfile {
        attribute profileId : String;
        attribute useCase : String;
        attribute ownerId : String;
        attribute version : String;
        attribute instructionsHash : String;
        attribute contractId : String;
        attribute contractVersion : String;
        attribute approved : Boolean;
        attribute pinnedRootSetDigest : String;
        attribute pinnedScopeDigest : String;
        attribute requiresSiblingComparison : Boolean;
        attribute allowsAlternativeVerificationMethod : Boolean;
        // Prompt instructions are not executable authority.
    }
    item def ProfileQuery {
        attribute requestedUseCase : String;
        attribute actorId : String;
    }
    item def ProfileResolution {
        item profile : ReasoningProfile;
        attribute permissionChecked : Boolean;
    }
    item def SourceRecord {
        attribute sourceId : String;
        attribute sourceSystem : String;
        attribute baselineId : String;
        attribute contentHash : String;
        attribute retrievedAt : String;
        attribute classificationLabel : String;
        attribute authorizedForViewer : Boolean;
        attribute integrity : IntegrityLabel;
        attribute confidentiality : ConfidentialityLabel;
        attribute derivedFromIds : String;
        // Classifier verdicts may add findings, but never upgrade labels.
    }
    item def GraphNode {
        attribute nodeId : String;
        attribute nodeKind : String;
        attribute lifecycleState : String;
        attribute sourceRef : String;
        attribute contentHash : String;
    }
    item def GraphEdge {
        attribute edgeId : String;
        attribute sourceNodeId : String;
        attribute targetNodeId : String;
        attribute relationKind : String;
        attribute sourceRef : String;
    }
    item def GraphSnapshot {
        attribute snapshotId : String;
        attribute baselineId : String;
        attribute canonicalHash : String;
        attribute sourceSystem : String;
        attribute frozen : Boolean;
        attribute authorizedInventoryKnown : Boolean;
        attribute permissionFilteredInventoryDigest : String;
        attribute sourceCompletenessUnknown : Boolean;
        item nodes : GraphNode[0..*];
        item edges : GraphEdge[0..*];
        item sources : SourceRecord[0..*];
    }
    item def TraversalContract {
        attribute contractId : String;
        attribute version : String;
        attribute entrySetDigest : String;
        attribute entrySetPinnedBy : String;
        attribute entrySetApproved : Boolean;
        attribute allowedRelationSetDigest : String;
        attribute terminalRuleDigest : String;
        attribute scopeDescription : String;
        attribute scopeDigestPinnedByControlPlane : String;
        attribute scopeDeviationRequiresFinding : Boolean;
        attribute permittedVisibilityDigest : String;
        attribute declaredExclusions : String;
        attribute maxWorkBudget : Integer;
        // User/model suggestions never silently alter pinned roots or scope.
    }
    item def GraphQuery {
        attribute baselineId : String;
        attribute sourceScope : String;
        attribute queryId : String;
    }
    item def CoverageRequest {
        item graphSnapshot : GraphSnapshot;
        item contract : TraversalContract;
        attribute reportedTraversalDigest : String;
    }
    item def NodeInspectionResult {
        attribute nodeId : String;
        attribute sourceContentHash : String;
        attribute inspectedUnderContract : String;
        attribute structuredDisposition : String;
        attribute evidenceIds : String;
        attribute unansweredObligations : String;
        attribute independentlyValidated : Boolean;
        // Echoing an ID is not an inspection disposition.
    }
    item def TraversalReceipt {
        attribute snapshotId : String;
        attribute snapshotHash : String;
        attribute contractId : String;
        attribute contractVersion : String;
        attribute expectedNodeCount : Integer;
        attribute enumeratedNodeCount : Integer;
        attribute expectedEdgeCount : Integer;
        attribute enumeratedEdgeCount : Integer;
        attribute expectedLeafCount : Integer;
        attribute enumeratedLeafCount : Integer;
        attribute allRequiredNodesInspected : Boolean;
        attribute allRequiredEdgesAccounted : Boolean;
        attribute allRequiredLeavesInspected : Boolean;
        attribute excessVisitsDisclosed : Boolean;
        attribute excessNodeCount : Integer;
        attribute structuredNodeDispositionsVerified : Boolean;
        item nodeInspections : NodeInspectionResult[0..*];
        attribute entryScopeValid : Boolean;
        attribute rootAndScopePinned : Boolean;
        attribute scopeDeviationClassified : Boolean;
        attribute terminationComplete : Boolean;
        attribute externallyRecomputed : Boolean;
        attribute limitationsDisclosed : Boolean;
        attribute visibilityBounded : Boolean;
        attribute budgetStatus : BudgetOutcome;
        attribute verifierVersion : String;
        // Required set is a subset of inspected set; excess is reported.
        // Count equality and mentioning IDs cannot establish examination.
    }
    item def CorroborationRequest {
        attribute snapshotId : String;
        attribute contractId : String;
        attribute primaryReceiptHash : String;
        attribute alternativeQueryId : String;
    }
    item def CorroborationReceipt {
        attribute primarySnapshotId : String;
        attribute alternativeDataLineage : String;
        attribute alternativeMethod : String;
        attribute independenceRationale : String;
        attribute comparedNodeSets : Boolean;
        attribute comparedEdgeSets : Boolean;
        attribute consistent : Boolean;
        attribute unresolvedDifferenceCount : Integer;
        attribute checksCompleted : Integer;
        attribute genuineIndependenceAvailable : Boolean;
        attribute alternativeCheckLimitation : String;
        // Two projections of the same corrupt extraction are correlated.
    }
    item def SiblingComparisonRequest {
        attribute snapshotId : String;
        attribute rootNodeId : String;
        attribute equivalenceCriteria : String;
        attribute profileVersion : String;
    }
    item def SiblingDeviation {
        attribute deviationId : String;
        attribute referenceSiblingIds : String;
        attribute expectedPattern : String;
        attribute observedPattern : String;
        attribute possibleJustification : String;
        attribute severity : RiskSeverity;
    }
    item def SiblingComparisonResult {
        attribute comparisonId : String;
        attribute selectedSiblingIds : String;
        attribute equivalenceCriteria : String;
        item deviations : SiblingDeviation[0..*];
        attribute validNoveltyAllowed : Boolean;
        attribute noForcedNormalization : Boolean;
    }
    item def ClassificationRequest {
        attribute boundary : ClassifierBoundary;
        attribute subjectId : String;
        attribute contentHash : String;
        attribute profileVersion : String;
    }
    item def Finding {
        attribute findingId : String;
        attribute actionId : String;
        attribute boundary : ClassifierBoundary;
        attribute kind : FindingKind;
        attribute severity : RiskSeverity;
        attribute status : FindingStatus;
        attribute evidenceRef : String;
        attribute explanation : String;
        attribute impact : String;
        attribute confidenceLimits : String;
        attribute detectorId : String;
    }
    item def ClassificationBatch {
        attribute subjectId : String;
        attribute boundary : ClassifierBoundary;
        attribute checksAttempted : Integer;
        attribute checksIncomplete : Integer;
        attribute completeForDeclaredPass : Boolean;
        item findings : Finding[0..*];
    }
    item def ModelRequest {
        attribute jobId : String;
        attribute profileVersion : String;
        attribute contextDigest : String;
        attribute requestedReasoningRole : String;
    }
    item def ModelResponse {
        attribute jobId : String;
        attribute proposedContent : String;
        attribute uncertainty : String;
        attribute sourceReferenceDigest : String;
        attribute bindingAuthority : Boolean;
        // bindingAuthority is always false for model output.
    }
    item def ProposedAction {
        attribute actionId : String;
        attribute actorId : String;
        attribute operation : String;
        attribute resourceId : String;
        attribute argumentDigest : String;
        attribute proposalDigest : String;
        attribute expectedSideEffects : String;
        attribute planId : String;
        attribute readOnly : Boolean;
        attribute combinedEffectClassification : String;
    }
    item def ReviewPacket {
        item proposedAction : ProposedAction;
        item findings : Finding[0..*];
        attribute actionDigest : String;
        attribute findingSetDigest : String;
        attribute allCurrentlyEvaluablePresented : Boolean;
        attribute classifiedFindingCount : Integer;
        attribute disclosedFindingCount : Integer;
        attribute incompleteCheckCount : Integer;
        attribute limitations : String;
        attribute packetVersion : String;
        attribute authorizationPrechecked : Boolean;
        attribute renderedByTrustedControlPlane : Boolean;
        attribute viewerScopeAuthorized : Boolean;
        attribute requiresExplicitAcknowledgement : Boolean;
        // A qualified read-only answer may require disclosure only.
    }
    item def RiskAcknowledgement {
        attribute acknowledgementId : String;
        attribute actorId : String;
        attribute actionId : String;
        attribute actionDigest : String;
        attribute findingSetDigest : String;
        attribute decision : ReviewDecision;
        attribute acceptedAt : String;
        attribute acceptedActionCount : Integer;
        attribute permissionChangeCount : Integer;
        attribute alreadyConsumed : Boolean;
        // Acceptance binds to one action and one visible finding set.
    }
    item def PolicyWaiver {
        attribute waiverId : String;
        attribute exactActionDigest : String;
        attribute requiredRole : String;
        attribute approvedByDifferentPrincipal : Boolean;
        attribute policyVersion : String;
        attribute expiresAt : String;
        attribute approvalAuthorityVerified : Boolean;
        // Acknowledgement is not a waiver or a new entitlement.
    }
    item def PlanRiskPacket {
        attribute planId : String;
        attribute orderedActionDigest : String;
        attribute aggregateSideEffects : String;
        item combinedFindings : Finding[0..*];
        attribute compositePolicyChecked : Boolean;
        attribute combinedEffectsDisclosed : Boolean;
    }
    item def AuthorizationRequest {
        attribute principalId : String;
        attribute resourceId : String;
        attribute operation : String;
        attribute argumentDigest : String;
        attribute actionId : String;
    }
    item def AuthorizationDecision {
        attribute actionId : String;
        attribute outcome : AuthorizationOutcome;
        attribute policyVersion : String;
        attribute checkedAt : String;
        attribute scope : String;
        attribute permissionMutation : Boolean;
        attribute phase : AuthorizationPhase;
        attribute requiredWaiver : WaiverRequirement;
        attribute requiredWaiverPresent : Boolean;
        attribute deniedBeforeSensitiveDisclosure : Boolean;
    }
    item def ToolInvocation {
        item proposedAction : ProposedAction;
        attribute authorizationDecisionId : String;
        attribute acknowledgementId : String;
        attribute idempotencyKey : String;
        attribute sourceSnapshotId : String;
    }
    item def ToolOutcome {
        attribute actionId : String;
        attribute executed : Boolean;
        attribute resultDigest : String;
        attribute changedStateVersion : String;
        attribute permissionRechecked : Boolean;
        attribute failureReason : String;
        attribute postExecutionFindingCount : Integer;
        attribute incidentProcessStartedWhenRequired : Boolean;
        // Post-execution discoveries cannot retroactively gain consent.
    }
    item def EvidenceClaim {
        attribute claimId : String;
        attribute claimText : String;
        attribute status : EvidenceStatus;
        attribute sourceIds : String;
        attribute obligationId : String;
        attribute verifierVersion : String;
        attribute uncertaintyExplanation : String;
        attribute staleOrDisputedReason : String;
        attribute claimExtractedBy : String;
        attribute claimInventoryChecked : Boolean;
    }
    item def ConstraintEvaluation {
        attribute evaluationId : String;
        attribute ruleSetVersion : String;
        attribute solverOutcome : SolverOutcome;
        attribute assumptionsDigest : String;
        attribute checkedSnapshotId : String;
        attribute unresolvedReason : String;
    }
    item def EvidencePacket {
        attribute workId : String;
        attribute actionId : String;
        attribute evidenceBundleHash : String;
        item claims : EvidenceClaim[0..*];
        item traversal : TraversalReceipt[0..1];
        item corroboration : CorroborationReceipt[0..1];
        item siblingComparison : SiblingComparisonResult[0..1];
        item constraints : ConstraintEvaluation[0..*];
        item findings : Finding[0..*];
        attribute failedOrUnrunChecks : String;
        item planRisks : PlanRiskPacket[0..1];
        attribute artifactSignerId : String;
        attribute signedPayloadDigest : String;
        attribute integrityVerificationComplete : Boolean;
        // No cryptographic attestation claim without verified signatures.
    }
    item def PacketAssemblyRequest {
        item evidence : EvidencePacket;
        item review : ReviewPacket[0..1];
        attribute recipientActorId : String;
    }
    item def FinalReport {
        attribute workId : String;
        attribute reportDigest : String;
        attribute claimCount : Integer;
        attribute unresolvedClaimCount : Integer;
        attribute evidenceRefsDigest : String;
        attribute visibleToActorId : String;
    }
    item def AuditEntry {
        attribute eventId : String;
        attribute workId : String;
        attribute actionId : String;
        attribute actorId : String;
        attribute eventType : String;
        attribute contentHash : String;
        attribute priorEntryHash : String;
        attribute recordedAt : String;
        attribute signerId : String;
        attribute signatureDigest : String;
        attribute signatureVerified : Boolean;
    }
    item def MemoryOperation {
        attribute recordId : String;
        attribute sourceEvidenceId : String;
        attribute proposedContentHash : String;
        attribute requestType : String;
    }
    item def MemoryDecision {
        attribute recordId : String;
        attribute provenancePreserved : Boolean;
        attribute promoted : Boolean;
        attribute rejectionReason : String;
    }
}

package EAH_Protocols {
    private import EAH_Common::*;

    // Directions are from the perspective of the first-named port.
    port def UserPort {
        in item request : UserRequest;
        in item acknowledgement : RiskAcknowledgement;
        out item immediate : ImmediateReply;
        out item review : ReviewPacket;
        out item finalReport : FinalReport;
    }
    port def WorkPort {
        out item ticket : WorkTicket;
        in item accepted : WorkAccepted;
    }
    port def ClassificationPort {
        out item request : ClassificationRequest;
        in item result : ClassificationBatch;
    }
    port def GraphPort {
        out item query : GraphQuery;
        in item graphSnapshot : GraphSnapshot;
    }
    port def CoveragePort {
        out item request : CoverageRequest;
        in item receipt : TraversalReceipt;
    }
    port def CorroborationPort {
        out item request : CorroborationRequest;
        in item receipt : CorroborationReceipt;
    }
    port def SiblingPort {
        out item request : SiblingComparisonRequest;
        in item result : SiblingComparisonResult;
    }
    port def ProfilePort {
        out item request : ProfileQuery;
        in item result : ProfileResolution;
    }
    port def ModelPort {
        out item request : ModelRequest;
        in item result : ModelResponse;
    }
    port def ReviewPort {
        out item packet : ReviewPacket;
        in item acknowledgement : RiskAcknowledgement;
    }
    port def PolicyPort {
        out item request : AuthorizationRequest;
        in item decision : AuthorizationDecision;
    }
    port def ExecutionPort {
        out item invocation : ToolInvocation;
        in item outcome : ToolOutcome;
    }
    port def AssemblyPort {
        out item request : PacketAssemblyRequest;
        in item report : FinalReport;
    }
    port def ReportPort {
        out item finalReport : FinalReport;
    }
    port def AuditPort {
        out item record : AuditEntry;
    }
    port def MemoryPort {
        out item operation : MemoryOperation;
        in item decision : MemoryDecision;
    }
}

package EAH_Architecture {
    private import EAH_Common::*;
    private import EAH_Protocols::*;

    // These are logical responsibilities, not mandated deployable processes.
    part def HumanReviewer {
        port interaction : ~UserPort;
    }
    part def ExternalEngineeringSource {
        port authorizedExport : ~GraphPort;
    }
    part def ConversationGateway {
        port user : UserPort;
        port workOut : WorkPort;
        port reviewIn : ~ReviewPort;
        port finalIn : ~ReportPort;
    }
    part def DurableOrchestrator {
        port workIn : ~WorkPort;
        port classificationOut : ClassificationPort;
        port graphOut : GraphPort;
        port coverageOut : CoveragePort;
        port corroborationOut : CorroborationPort;
        port siblingOut : SiblingPort;
        port profilesOut : ProfilePort;
        port modelOut : ModelPort;
        port reviewOut : ReviewPort;
        port executionOut : ExecutionPort;
        port assemblyOut : AssemblyPort;
        port finalOut : ReportPort;
        port auditOut : AuditPort;
        port memoryOut : MemoryPort;
    }
    part def DeterministicClassifier;
    part def ProbabilisticClassifier;
    part def ClassifierPipeline {
        port classifyIn : ~ClassificationPort;
        part deterministicChecks : DeterministicClassifier;
        part semanticChecks : ProbabilisticClassifier;
        // Both may raise findings. Neither short-circuits the other.
    }
    part def GraphSourceAdapter {
        port graphIn : ~GraphPort;
        port sourceOut : GraphPort;
    }
    part def TraversalVerificationGate {
        port coverageIn : ~CoveragePort;
        // Control-plane pinned roots, structured per-node dispositions.
        // Validity concerns modeled relationships only.
    }
    part def RootAndScopeAuthority {
        // Holds approved root, relation, visibility and budget contract.
        // It cannot be modified by model-generated prose.
    }
    part def ObligationEnumerator {
        // Supplies each required authorized node to the reasoning worker.
        // Verifies disposition schema, source hash, edge accountability.
    }
    part def ModelGapDetector {
        // Compares modeled relations to external change records,
        // interface inventories, test links, and domain expectations.
        // An unknown missing link remains an explicit assurance limit.
    }
    part def DeterministicLabelPropagator {
        // Computes most restrictive integrity and confidentiality labels.
        // A classifier cannot promote untrusted inputs.
    }
    part def IndependentReconciler {
        port corroborationIn : ~CorroborationPort;
        // Independence requires separate method or meaningful data lineage.
    }
    part def SiblingPatternAnalyzer {
        port siblingIn : ~SiblingPort;
        // Deviations are findings, not forced normalization.
    }
    part def ProfileRegistry {
        port profileIn : ~ProfilePort;
        // Profile owner and schema changes remain access controlled.
    }
    part def ContextSufficiencyModel;
    part def DeepReasoningModel;
    part def ModelBroker {
        port modelIn : ~ModelPort;
        part contextAssessor : ContextSufficiencyModel;
        part reasoningModel : DeepReasoningModel;
        // Both outputs are proposals, never permission grants or proof.
    }
    part def RiskReviewManager {
        port reviewIn : ~ReviewPort;
        port reviewOut : ReviewPort;
        // Scope-redacted deterministic UI for exact action and finding set.
        // Plan risk and separate role waiver are checked independently.
    }
    part def WaiverAuthority {
        // Existing policy may require a different authorized risk owner.
        // Risk consent cannot grant the missing approval role.
    }
    part def PlanRiskAnalyzer {
        // Discovers aggregate effects of individually permissible calls.
    }
    part def PostExecutionIncidentManager {
        // New tool-output or publication findings route to incidents.
    }
    part def AuthorizationAuthority {
        port policyIn : ~PolicyPort;
        // Uses external identity, role, resource and policy state.
    }
    part def ToolGateway {
        port invocationIn : ~ExecutionPort;
        port policyOut : PolicyPort;
        // Independently checks permissions and exact arguments at use time.
    }
    part def EvidenceAssembler {
        port assemblyIn : ~AssemblyPort;
        // Grounds claims, checks obligation inventory, discloses limits.
    }
    part def ArtifactIntegrityService {
        // Signs and validates immutable canonical payload provenance.
        // A hash without an authenticated signer is not attestation.
    }
    part def GovernedMemory {
        port memoryIn : ~MemoryPort;
        // No unverified inferred content becomes authoritative memory.
    }
    part def AppendOnlyAuditLedger {
        port auditIn : ~AuditPort;
    }

    part def EvidenceAttestedHarness {
        part conversationGateway : ConversationGateway;
        part durableOrchestrator : DurableOrchestrator;
        part classifierPipeline : ClassifierPipeline;
        part graphSource : GraphSourceAdapter;
        part scopeAuthority : RootAndScopeAuthority;
        part obligationEnumerator : ObligationEnumerator;
        part traversalGate : TraversalVerificationGate;
        part gapDetector : ModelGapDetector;
        part labelPropagator : DeterministicLabelPropagator;
        part independentReconciler : IndependentReconciler;
        part siblingAnalyzer : SiblingPatternAnalyzer;
        part profileRegistry : ProfileRegistry;
        part modelBroker : ModelBroker;
        part reviewManager : RiskReviewManager;
        part waiverAuthority : WaiverAuthority;
        part planRiskAnalyzer : PlanRiskAnalyzer;
        part incidentManager : PostExecutionIncidentManager;
        part policyAuthority : AuthorizationAuthority;
        part toolGateway : ToolGateway;
        part evidenceAssembler : EvidenceAssembler;
        part artifactIntegrity : ArtifactIntegrityService;
        part auditLedger : AppendOnlyAuditLedger;
        part governedMemory : GovernedMemory;

        interface conversationGateway.workOut
            to durableOrchestrator.workIn;
        interface durableOrchestrator.classificationOut
            to classifierPipeline.classifyIn;
        interface durableOrchestrator.graphOut
            to graphSource.graphIn;
        interface durableOrchestrator.coverageOut
            to traversalGate.coverageIn;
        interface durableOrchestrator.corroborationOut
            to independentReconciler.corroborationIn;
        interface durableOrchestrator.siblingOut
            to siblingAnalyzer.siblingIn;
        interface durableOrchestrator.profilesOut
            to profileRegistry.profileIn;
        interface durableOrchestrator.modelOut
            to modelBroker.modelIn;
        interface durableOrchestrator.reviewOut
            to reviewManager.reviewIn;
        interface reviewManager.reviewOut
            to conversationGateway.reviewIn;
        interface durableOrchestrator.executionOut
            to toolGateway.invocationIn;
        interface toolGateway.policyOut
            to policyAuthority.policyIn;
        interface durableOrchestrator.assemblyOut
            to evidenceAssembler.assemblyIn;
        interface durableOrchestrator.finalOut
            to conversationGateway.finalIn;
        interface durableOrchestrator.auditOut
            to auditLedger.auditIn;
        interface durableOrchestrator.memoryOut
            to governedMemory.memoryIn;
    }

    // The reviewer and source of truth are outside harness authority.
    part def EngineeringReviewContext {
        part reviewer : HumanReviewer;
        part harness : EvidenceAttestedHarness;
        part engineeringRepository : ExternalEngineeringSource;

        interface reviewer.interaction
            to harness.conversationGateway.user;
        interface harness.graphSource.sourceOut
            to engineeringRepository.authorizedExport;
    }
}

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

package EAH_MBSE_Reference {
    private import ScalarValues::*;

    // Illustrative subsystem and engineering-change domain types.
    // These are not a validated physical battery design.
    item def PumpCommand {
        attribute commandId : String;
        attribute requestedDuty : Real;
    }
    item def TemperatureReading {
        attribute sensorId : String;
        attribute measuredValue : Real;
        attribute measurementTime : String;
    }
    item def EngineeringChange {
        attribute changeId : String;
        attribute baselineId : String;
        attribute startingElementId : String;
        attribute changeDescription : String;
        attribute requestedBy : String;
    }
    item def EngineeringRequirement {
        attribute requirementId : String;
        attribute statement : String;
        attribute baselineId : String;
        attribute authoritativeSourceRef : String;
    }
    item def EngineeringTrace {
        attribute traceId : String;
        attribute sourceElementId : String;
        attribute targetElementId : String;
        attribute relationshipKind : String;
        attribute authoritativeSourceRef : String;
    }
    item def VerificationArtifact {
        attribute artifactId : String;
        attribute verifiesRequirementId : String;
        attribute artifactType : String;
        attribute evidenceLocation : String;
        attribute status : String;
    }

    port def PumpControlPort {
        out item command : PumpCommand;
    }
    port def TemperatureTelemetryPort {
        out item reading : TemperatureReading;
    }

    part def BatteryCellModule;
    part def BatteryManagementController {
        port pumpCommand : PumpControlPort;
        port measuredTemperature : ~TemperatureTelemetryPort;
    }
    part def CoolantPump {
        port controlIn : ~PumpControlPort;
    }
    part def TemperatureSensor {
        port telemetryOut : TemperatureTelemetryPort;
    }
    part def PowerContactor;
    part def BatteryThermalSubsystem {
        part cellModule : BatteryCellModule;
        part controller : BatteryManagementController;
        part coolantPump : CoolantPump;
        part temperatureSensor : TemperatureSensor;
        part safetyContactor : PowerContactor;

        interface controller.pumpCommand
            to coolantPump.controlIn;
        interface temperatureSensor.telemetryOut
            to controller.measuredTemperature;
    }

    part def BaselineTraceabilityRepository {
        item requirements : EngineeringRequirement[0..*];
        item traces : EngineeringTrace[0..*];
        item verificationArtifacts : VerificationArtifact[0..*];
        // Current baseline and read permissions are external authority.
    }

    // This is a verification objective, not a claim of current compliance.
    requirement def ThermalSafetyRequirement {
        subject battery : BatteryThermalSubsystem;
        attribute observedTemperature : Real;
        attribute permittedTemperature : Real;
        require constraint {
            observedTemperature <= permittedTemperature
        }
    }
    requirement thermalSafety : ThermalSafetyRequirement;

    verification def ThermalSafetyVerification {
        subject battery : BatteryThermalSubsystem;
        objective {
            verify thermalSafety;
        }
        action collectTemperatureEvidence;
        then action inspectPumpAndControllerInterfaces;
        then action evaluateThresholdConstraint;
        then action issueVerdictWithEvidence;
    }

    analysis def EngineeringChangeImpactAnalysis {
        subject battery : BatteryThermalSubsystem;
        in item change : EngineeringChange;

        action identifyChangedRequirementOrComponent;
        then action freezeAuthoritativeBaseline;
        then action traverseRequiredRelationsToLeaves;
        then action reconcileWithIndependentQueries;
        then action comparePeerBatterySubsystemPatterns;
        then action inspectVerificationAndSafetyTraces;
        then action reportKnownGapsAndUnknowns;
    }

    use case def AssessBatteryThermalChange {
        subject harness : EAH_Architecture::EvidenceAttestedHarness;
        actor engineer : EAH_Architecture::HumanReviewer;
        objective {
            doc /* The engineer sees traced consequences of a change
                   to controller thermal thresholds, pump behavior,
                   interfaces, safety assumptions, and verification
                   artifacts before approving engineering work. */
        }
        action submitProposedThresholdChange;
        then action receiveCurrentGraphCoverageReport;
        then action reviewAllFindingsForOneAction;
        then action acknowledgeOrReviseThatAction;
        then action receiveGroundedImpactAssessment;
    }

    part def BatteryReviewEnvironment {
        part engineer : EAH_Architecture::HumanReviewer;
        part harness : EAH_Architecture::EvidenceAttestedHarness;
        part mbseRepository : EAH_Architecture::ExternalEngineeringSource;
        part design : BatteryThermalSubsystem;
        part traceability : BaselineTraceabilityRepository;

        interface engineer.interaction
            to harness.conversationGateway.user;
        interface harness.graphSource.sourceOut
            to mbseRepository.authorizedExport;
    }

    // Change-impact traversal contract, expressed as engineering rules:
    // Entry: changed requirement, component, interface, or assumption.
    // Include: allocation, dependency, interface, verification, hazard,
    //          satisfaction, derivation, and required parent/child links.
    // Leaves: applicable terminal verification, evidence, or explicit gap.
    // Scope: one frozen and authorized baseline plus declared external links.
    // Output: scoped required subset, documented extra visits,
    //         structured inspections, unknown or absent trace links,
    //         independent checks, and unresolved limitations.
}

// Security model deliberately distinguishes untrusted content from
// the deterministic authority that interprets and acts on it.
package EAH_ThreatModel {
    private import ScalarValues::*;
    private import EAH_Common::*;

    enum def AdversaryClass {
        MaliciousSource; CompromisedTool; CuriousInsider;
        MisleadingModel; HonestMistake; CoordinatedSequence;
    }
    enum def TrustBoundaryKind {
        UserToGateway; ExternalToGraphAdapter; SourceToModel;
        ModelToControlPlane; ControlPlaneToTool; ReportToReviewer;
        ReviewerToPolicy; ToolOutputToControlPlane;
    }
    enum def SecurityOutcome {
        Blocked; DetectedAndDisclosed; Contained;
        EscalatedToIncident; NotDetected; NotEvaluated;
    }
    item def TrustBoundary {
        attribute boundaryId : String;
        attribute kind : TrustBoundaryKind;
        attribute sourceAuthority : String;
        attribute destinationAuthority : String;
        attribute allowedDataClasses : String;
        attribute declassificationPolicyId : String;
        attribute dataCanAuthorizeActions : Boolean;
        attribute permissionsRevalidated : Boolean;
    }
    item def InjectionAttempt {
        attribute attackId : String;
        attribute adversary : AdversaryClass;
        attribute carrier : String;
        attribute claimedAuthority : String;
        attribute targetedAction : String;
        attribute targetedBoundary : TrustBoundaryKind;
        attribute embeddedInReviewExplanation : Boolean;
        attribute disposition : SecurityOutcome;
    }
    item def LabelTransition {
        attribute recordId : String;
        attribute inputIntegrity : IntegrityLabel;
        attribute outputIntegrity : IntegrityLabel;
        attribute inputConfidentiality : ConfidentialityLabel;
        attribute outputConfidentiality : ConfidentialityLabel;
        attribute deterministicPolicyId : String;
        attribute classifierMayUpgradeIntegrity : Boolean;
        attribute exceptionAuthorizationId : String;
    }
    item def CompositeAttack {
        attribute planId : String;
        attribute sequenceDigest : String;
        attribute individualActionRisk : String;
        attribute aggregateRisk : String;
        attribute sequenceDetectable : Boolean;
        attribute aggregatePolicyDecision : AuthorizationOutcome;
    }
    item def DisclosureSurface {
        attribute surfaceId : String;
        attribute viewerPrincipalId : String;
        attribute permittedEvidenceDigest : String;
        attribute textSource : String;
        attribute trustedRenderer : Boolean;
        attribute protectedNodeCountPublished : Boolean;
    }
    item def WaiverChallenge {
        attribute challengeId : String;
        attribute actionDigest : String;
        attribute initiatingPrincipal : String;
        attribute approvingPrincipal : String;
        attribute requiredRole : String;
        attribute differentRoleValidated : Boolean;
        attribute independentPermissionValidated : Boolean;
        attribute consentRetainsOriginalSeverity : Boolean;
    }

    part def ThreatAndTrustEnforcement {
        part labels : EAH_Architecture::DeterministicLabelPropagator;
        part policy : EAH_Architecture::AuthorizationAuthority;
        part waiver : EAH_Architecture::WaiverAuthority;
        part review : EAH_Architecture::RiskReviewManager;
        part plan : EAH_Architecture::PlanRiskAnalyzer;
        part incidents : EAH_Architecture::PostExecutionIncidentManager;
    }

    action def AdmitExternalData {
        in item source : SourceRecord;
        out item admitted : SourceRecord;
        action authenticateSourceIdentifier;
        then action applyConfidentialityAndIntegrityPolicy;
        then action preserveOriginatingTaintAcrossDerivations;
        then action labelUnknownSourceAsUntrusted;
        then action exposeOnlyPermittedDataToModel;
        // A classifier finding cannot strip the untrusted label.
    }
    action def RenderActionBoundConsent {
        in item proposed : ProposedAction;
        in item packet : ReviewPacket;
        out item acknowledgement : RiskAcknowledgement;
        action precheckViewerScope;
        then action canonicalizeActionAndFindingDigest;
        then action renderToolOperationAndArgumentsFromTrustedFields;
        then action escapeUntrustedExplanationsAndLinks;
        then action showAllDisclosableFindingsTogether;
        then action collectOneDispositionForOneAction;
        then action atomicallyConsumeConsentOnExactInvocation;
    }
    action def EvaluateCombinedEffect {
        in item plan : PlanRiskPacket;
        out item reviewed : PlanRiskPacket;
        action enumeratePlannedReadsAndWrites;
        then action detectReadThenExternalPublish;
        then action detectMassEditAndCumulativeSideEffects;
        then action enforcePlanLevelPolicy;
        then action mapPlanRisksToIndividualActions;
        // The plan check supplements, never replaces, each action check.
    }
    action def HandleUnanticipatedFinding {
        in item toolOutcome : ToolOutcome;
        action preserveEvidenceAndProvenance;
        then action labelActualSideEffects;
        then action notifyAuthorizedIncidentHandler;
        then action containOrCompensateIfPermitted;
        then action recordCorrectiveActions;
        // Executed operations cannot be retroactively approved.
    }

    verification def SourceTaintCannotBePromoted {
        subject security : ThreatAndTrustEnforcement;
        objective {
            verify EAH_Requirements::r028;
            verify EAH_Requirements::r019;
        }
        action injectTrustedLookingSourcePrompt;
        then action forceProbabilisticClassifierToLabelAsSafe;
        then action deriveReportFromMixedIntegrityInputs;
        then action verifyMostRestrictiveLabelPersists;
        then action denyPromotionWithoutAuthorizedDeclassification;
    }
    verification def ConsentAndReviewInjectionTest {
        subject security : ThreatAndTrustEnforcement;
        objective {
            verify EAH_Requirements::r005;
            verify EAH_Requirements::r008;
            verify EAH_Requirements::r029;
        }
        action embedPermissionInstructionInFindingExplanation;
        then action attemptModifyActionShownToReviewer;
        then action assertTrustedActionRenderingUnchanged;
        then action acceptAllFindingsForOneAction;
        then action rejectReplayedOrRewrittenInvocation;
    }
    verification def SeparateWaiverAndDenialTest {
        subject security : ThreatAndTrustEnforcement;
        objective {
            verify EAH_Requirements::r006;
            verify EAH_Requirements::r007;
            verify EAH_Requirements::r030;
            verify EAH_Requirements::waiverIntegrity;
        }
        action acknowledgeCriticalFindingAsInitiator;
        then action attemptSamePrincipalApprovalOfRequiredWaiver;
        then action expectDistinctRoleCheckFailure;
        then action supplyValidDifferentRoleWaiver;
        then action checkCurrentExecutionPermissionSeparately;
        then action expectDenialIfResourceAccessMissing;
    }
    verification def PreReviewInformationLeakTest {
        subject security : ThreatAndTrustEnforcement;
        objective {
            verify EAH_Requirements::r021;
            verify EAH_Requirements::r033;
            verify EAH_Requirements::consentIntegrity;
        }
        action requestProtectedGraphAsUnauthorizedActor;
        then action preauthorizeBeforeRunningPrivateChecks;
        then action expectDeniedPathWithoutSensitiveFindings;
        then action verifyHiddenInventoryCountsNotLeaked;
    }
    verification def CombinedEffectsTest {
        subject security : ThreatAndTrustEnforcement;
        objective {
            verify EAH_Requirements::r032;
            verify EAH_Requirements::r034;
        }
        action proposeInnocentReadFollowedByExternalPost;
        then action detectAggregateExfiltrationRisk;
        then action proposeFiftyIndividuallySmallEdits;
        then action detectCumulativeSafetyEffect;
        then action injectNewRiskIntoExecutedToolResult;
        then action requireIncidentInsteadOfRetroactiveConsent;
    }
}

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

package EAH_DataAndOperations {
    private import ScalarValues::*;
    private import EAH_Common::*;

    enum def DeliveryState {
        Pending; Published; Confirmed; RetryableFailure; TerminalFailure;
    }
    enum def ConsistencyPolicy {
        LocalTransactionOutbox; IdempotentConsumer;
        ConvergentReplicatedState; SingleWriter;
    }
    enum def SourceIntegrityState {
        FreshAuthorized; ChangedSinceReview;
        MissingInventory; PermissionFiltered;
        Stale; Conflict; Unavailable;
    }
    item def OutboxMessage {
        attribute messageId : String;
        attribute workId : String;
        attribute actionId : String;
        attribute eventType : String;
        attribute payloadDigest : String;
        attribute localTransactionId : String;
        attribute deliveryState : DeliveryState;
        attribute attempts : Integer;
        attribute idempotencyKey : String;
        attribute committedWithWorkState : Boolean;
        // Outbox protects local commit and event publication;
        // it does not provide multi-master convergent state.
    }
    item def ReplicatedAnnotation {
        attribute annotationId : String;
        attribute replicaId : String;
        attribute logicalClock : String;
        attribute mergePolicy : ConsistencyPolicy;
        attribute contentDigest : String;
        attribute isAuthorityBearing : Boolean;
        // CRDT-style convergence is suitable only for bounded shared data.
        // It is not a replacement for authorization or transactional outbox.
    }
    item def SourceAvailability {
        attribute snapshotId : String;
        attribute sourceState : SourceIntegrityState;
        attribute authorizedInventoryDigest : String;
        attribute lastVerifiedVersion : String;
        attribute freshnessPolicyId : String;
        attribute canGiveCompleteCoverageAnswer : Boolean;
        attribute countsRedacted : Boolean;
    }
    item def BudgetLedger {
        attribute workId : String;
        attribute policyId : String;
        attribute maxNodes : Integer;
        attribute maxEdges : Integer;
        attribute maxClassifierCalls : Integer;
        attribute maxTokens : Integer;
        attribute maxElapsedMillis : Integer;
        attribute nodesInspected : Integer;
        attribute edgesInspected : Integer;
        attribute classifierCallsUsed : Integer;
        attribute tokensConsumed : Integer;
        attribute elapsedMillis : Integer;
        attribute outcome : BudgetOutcome;
        attribute unfulfilledObligationDigest : String;
    }
    item def BoundaryInspection {
        attribute workId : String;
        attribute actionId : String;
        attribute boundary : ClassifierBoundary;
        attribute classificationCompleted : Boolean;
        attribute deferredUntilLater : Boolean;
        attribute dataVisibleToReviewer : Boolean;
        attribute deniedByPreauthorization : Boolean;
        attribute failureReason : String;
    }
    item def SourceProvenance {
        attribute claimId : String;
        attribute sourceSnapshotId : String;
        attribute sourceEntityId : String;
        attribute sourceVersion : String;
        attribute transformIdentity : String;
        attribute transformVersion : String;
        attribute contentDigest : String;
        attribute originIntegrity : IntegrityLabel;
        attribute effectiveConfidentiality : ConfidentialityLabel;
    }
    item def SignedReviewArtifact {
        attribute artifactId : String;
        attribute canonicalActionDigest : String;
        attribute canonicalFindingDigest : String;
        attribute sourceSnapshotDigest : String;
        attribute traversalReceiptDigest : String;
        attribute actorAndPolicyDigest : String;
        attribute signerIdentity : String;
        attribute signatureAlgorithm : String;
        attribute signatureValue : String;
        attribute signatureVerified : Boolean;
        attribute chainedToPreviousArtifact : Boolean;
        attribute signedAt : String;
        // Artifact is tamper-evident only after signature verification.
        // Signature validates recorded bytes, not truth of the model.
    }
    item def ReconciliationState {
        attribute workId : String;
        attribute controlPlaneVersion : Integer;
        attribute sourceSystemVersion : String;
        attribute modelRunVersion : String;
        attribute retryWithoutDuplicateSideEffect : Boolean;
        attribute staleReviewInvalidated : Boolean;
        attribute compensationNeeded : Boolean;
        attribute unresolvedRace : Boolean;
    }
    item def ClaimObligation {
        attribute obligationId : String;
        attribute nodeOrEdgeId : String;
        attribute claimType : String;
        attribute requiredEvidenceKind : String;
        attribute expectedOutputSection : String;
        attribute answered : Boolean;
        attribute explicitUnknownRecorded : Boolean;
        // Generated narrative is compared with this trusted inventory.
    }

    part def TransactionalWorkStore;
    part def OutboxPublisher;
    part def IdempotentWorkConsumer;
    part def VersionedModelEvidenceStore;
    part def BudgetAndCancellationGuard;
    part def PermissionFilteredGraphAdapter;
    part def SignedArtifactArchive;
    part def OperationalSubsystem {
        part committedState : TransactionalWorkStore;
        part outbox : OutboxPublisher;
        part consumer : IdempotentWorkConsumer;
        part sources : VersionedModelEvidenceStore;
        part limits : BudgetAndCancellationGuard;
        part permissionView : PermissionFilteredGraphAdapter;
        part archive : SignedArtifactArchive;
    }

    action def PersistAndDeliverWork {
        in item request : UserRequest;
        out item accepted : WorkAccepted;
        action beginLocalTransaction;
        then action persistWorkTicketAndOutboxEventAtomically;
        then action commitBeforeClaimingDurableAcceptance;
        then action publishOutboxEventAtLeastOnce;
        then action deduplicateConsumerByIdempotencyKey;
        then action recoverAfterCrashWithoutRepeatingToolSideEffect;
    }
    action def EnforceAnalysisBudget {
        in item ledger : BudgetLedger;
        out item finalLedger : BudgetLedger;
        action reserveBudgetForScopeEnumeration;
        then action accountForAllClassifierBoundaries;
        then action stopAtBudgetOrAccessLimit;
        then action preserveUncompletedObligationIdentifiersPrivately;
        then action emitInconclusiveOrIncompleteVerdict;
        then action suppressUnauthorizedInventoryCounts;
    }
    action def PublishIntegrityBoundEvidence {
        in item packet : EvidencePacket;
        out item report : FinalReport;
        action deriveCanonicalPayloadFromTrustedElements;
        then action validateSourceSnapshotAndPolicyVersions;
        then action gatherEvidenceAndOpenObligations;
        then action signCanonicalBytesWithApprovedKey;
        then action verifySignatureAndStoreInChainedLedger;
        then action discloseScopeAndAssuranceLimitsToAuthorizedViewer;
    }
    action def EvaluateAndPublishClaims {
        in item packet : EvidencePacket;
        out item report : FinalReport;
        action deriveDeterministicObligationInventory;
        then action extractCandidateClaimsFromGeneratedNarrative;
        then action reconcileEachClaimWithSourceAndObligation;
        then action detectUnansweredObligationsAndMissingClaims;
        then action labelStaleDisputedAndInconclusiveOutputs;
        then action renderBoundedAuthorizedReport;
    }

    verification def TransactionAndIdempotencyTest {
        subject operations : OperationalSubsystem;
        objective {
            verify EAH_Requirements::r002;
            verify EAH_Requirements::r008;
            verify EAH_Requirements::r020;
        }
        action interruptAfterWorkCommitBeforeEventPublish;
        then action replayOutboxWithoutDuplicatingOperation;
        then action retryToolCompletionWithSameIdempotencyKey;
        then action ensureOneDurableActionAndCompleteAuditLineage;
    }
    verification def StaleSnapshotRaceTest {
        subject operations : OperationalSubsystem;
        objective {
            verify EAH_Requirements::r009;
            verify EAH_Requirements::r018;
            verify EAH_Requirements::r033;
        }
        action preauthorizeAndPrepareExactReviewDigest;
        then action mutateSourcePermissionsOrGraphBaseline;
        then action attemptExecutionUsingOriginalReceipt;
        then action expectReevaluationOrDenial;
    }
    verification def ProvenanceAndSignatureTest {
        subject operations : OperationalSubsystem;
        objective {
            verify EAH_Requirements::r020;
            verify EAH_Requirements::r022;
            verify EAH_Requirements::r028;
        }
        action createSignedArtifactAndSourceTransformChain;
        then action alterOneFindingAfterSigning;
        then action rejectTamperedPacket;
        then action verifyClaimedTrustCannotIncreaseByClassification;
    }
    verification def ClaimOmissionTest {
        subject operations : OperationalSubsystem;
        objective {
            verify EAH_Requirements::r010;
            verify EAH_Requirements::r036;
        }
        action supplyNarrativeWithoutKnownCriticalObligation;
        then action compareToTrustedObligationInventory;
        then action reportOmittedObligationAsUnanswered;
        then action avoidFalseCompleteResult;
    }
}

package EAH_AssuranceCase {
    private import ScalarValues::*;
    private import EAH_Common::*;

    enum def AssuranceClaimLevel {
        MechanicallyValidatedSyntax; VerifiedGraphContract;
        SourceSupportedAssertion; QualifiedInference;
        UnsubstantiatedHypothesis;
    }
    enum def ArgumentStatus {
        SupportedWithinContract; EvidenceMissing;
        ConflictingEvidence; RequiresExternalQualification;
        InvalidatedByChangedBaseline;
    }
    enum def EvidenceKind {
        ParserDiagnostic; RequirementVerificationResult;
        AuthenticatedProvenance; TraversalSetRecomputation;
        IndependentReconciliation; SourceInventoryGapStudy;
        HumanEngineeringReview; RegulatoryQualificationRecord;
        EmpiricalPerformanceMeasure;
    }
    item def ScopedAssuranceClaim {
        attribute assuranceClaimId : String;
        attribute claimText : String;
        attribute level : AssuranceClaimLevel;
        attribute scopeContractDigest : String;
        attribute sourceBaselineDigest : String;
        attribute visibleActorScopeDigest : String;
        attribute assumptionsDigest : String;
        attribute knownUnmodeledLinkLimit : String;
        attribute noUniversalCompletenessClaim : Boolean;
        attribute status : ArgumentStatus;
    }
    item def AssuranceEvidence {
        attribute evidenceId : String;
        attribute kind : EvidenceKind;
        attribute storageLocation : String;
        attribute canonicalDigest : String;
        attribute originator : String;
        attribute verifierId : String;
        attribute signerId : String;
        attribute verifiedIntegrity : Boolean;
        attribute timestamp : String;
        attribute sourcePermissionBound : Boolean;
        attribute relevantClaimId : String;
    }
    item def AssuranceArgument {
        attribute argumentId : String;
        attribute topClaimId : String;
        attribute supportClaimIds : String;
        attribute supportingEvidenceIds : String;
        attribute unresolvedChallengeIds : String;
        attribute inferenceRule : String;
        attribute independentReviewerId : String;
        attribute limitations : String;
        attribute conclusion : ArgumentStatus;
    }
    item def AssumptionAndDefeater {
        attribute assumptionId : String;
        attribute description : String;
        attribute wouldInvalidateClaimIfFalse : Boolean;
        attribute validationEvidenceId : String;
        attribute monitoredOrRechecked : Boolean;
        attribute defeatingCounterexample : String;
    }
    item def AssuranceCasePackage {
        attribute packageId : String;
        attribute industryApplication : String;
        attribute governingStandardProfile : String;
        attribute certificationStatus : String;
        item topClaims : ScopedAssuranceClaim[0..*];
        item arguments : AssuranceArgument[0..*];
        item evidence : AssuranceEvidence[0..*];
        item assumptions : AssumptionAndDefeater[0..*];
        attribute outstandingDefeaters : String;
        attribute artifactSignatureValidated : Boolean;
        attribute engineerApprovalStatus : String;
        // SysML representations are not GSN certifications on their own.
    }

    part def EvidenceAdmissionGate {
        // Accept syntax, graph and runtime evidence at distinct levels.
    }
    part def ClaimToSourceCorrelator {
        // Explicitly tracks non-independent downstream projections.
    }
    part def AssuranceArgumentAssembler {
        // Uses GSN-style goal, strategy, solution, context and assumptions.
    }
    part def ExternalQualificationInterface {
        // DO-330, DO-178C, ISO 26262, ARP4754-series as applicable.
        // Applicability and qualification are determined by the buyer.
    }
    part def AssuranceSystem {
        part admission : EvidenceAdmissionGate;
        part lineage : ClaimToSourceCorrelator;
        part arguments : AssuranceArgumentAssembler;
        part qualification : ExternalQualificationInterface;
    }

    requirement def CoverageDoesNotProveModelFidelity {
        subject graph : GraphSnapshot;
        doc /* An exhaustive traversal of snapshot nodes and modeled
               edges says nothing conclusive about source omissions,
               incorrectly modeled relationships or real-world hazards.
               External reconciliation and human engineering evidence
               bound any stronger safety claim. */
    }
    requirement def SignedReceiptIsNotSemanticTruth {
        subject evidence : EvidencePacket;
        doc /* A verified digital signature proves integrity and signer
               association with a canonical artifact. It does not
               prove the claims inside are correct. */
    }
    requirement def IndependentValidationIsQualified {
        subject challenge : CorroborationReceipt;
        doc /* A second query or graph projection with the same lineage
               is not independent source corroboration. If an independent
               data source is absent, the limitation stays visible. */
    }
    requirement graphFidelityLimit : CoverageDoesNotProveModelFidelity;
    requirement artifactTruthLimit : SignedReceiptIsNotSemanticTruth;
    requirement independenceLimit : IndependentValidationIsQualified;

    action def BuildScopedAssuranceArgument {
        in item evidence : EvidencePacket;
        out item casePackage : AssuranceCasePackage;
        action assertContractAndInputBaselines;
        then action distinguishParserSuccessFromBehavioralProperties;
        then action distinguishModeledCoverageFromExternalCompleteness;
        then action deriveSourceLineageAndCorrelatedFailures;
        then action inventoryMissingLinksAndUnvalidatedAssumptions;
        then action validateAuthenticatedArtifactProvenance;
        then action mapClaimsToArgumentAndVerificationEvidence;
        then action requestExternalCertificationEvidenceWhenApplicable;
        then action publishQualifiedCaseWithDefeaters;
    }
    analysis def ArgumentAgainstTheHarnessItself {
        subject assurance : AssuranceSystem;
        action examineClaimsOfDeterminismAndActualTrustBoundaries;
        then action findAllModelOrSourceDependentGateInputs;
        then action constructWrongRootAndMissingEdgeCounterexamples;
        then action challengeFindingClassificationAndRiskWaiver;
        then action measureReviewerRelianceOnCoverageBadges;
        then action testAlternativeToolingForEquivalentBenefits;
        then action recordResidualUnprovenAssumptions;
    }
    verification def NoFalseUniversalCompletenessTest {
        subject casePackage : AssuranceCasePackage;
        objective {
            verify EAH_Requirements::r010;
            verify EAH_Requirements::r013;
            verify graphFidelityLimit;
        }
        action provideFullyCoveredButDeliberatelyIncompleteSourceGraph;
        then action permitVerifiedGraphContractClaim;
        then action rejectClaimOfCompleteRealWorldImpact;
        then action recordKnownUnknownMissingLinks;
    }
    verification def SignatureScopeTest {
        subject casePackage : AssuranceCasePackage;
        objective {
            verify EAH_Requirements::r022;
            verify artifactTruthLimit;
        }
        action signCanonicalArtifactWithKnownIncorrectClaim;
        then action verifyByteIntegrityAndSignerIdentity;
        then action preserveIncorrectClaimAsUnsubstantiated;
        then action rejectInferenceFromSignatureToSemanticTruth;
    }
    verification def CorrelatedSourceCheckTest {
        subject casePackage : AssuranceCasePackage;
        objective {
            verify EAH_Requirements::r012;
            verify independenceLimit;
        }
        action deriveTwoQueriesFromSameIncompleteExport;
        then action observeMatchingModeledNodeAndEdgeSets;
        then action labelEvidenceAsCorrelated;
        then action refuseIndependentSourceCorroborationClaim;
    }
}

// Normative source-to-requirement coverage of both original documents.
// Every source chapter is represented by a stable, typed trace usage.
// Strings identify architectural intent; the requirement/verification
// declarations in other packages remain the language-level typed links.
package EAH_DocumentTraceability {
    private import ScalarValues::*;
    item def DocumentSectionTrace {
        attribute sourceDocument : String;
        attribute sourceSection : String;
        attribute sectionTitle : String;
        attribute requirementIds : String;
        attribute designNamespace : String;
        attribute verificationNamespace : String;
        attribute evidenceState : String;
    }
    item WP01 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP01";
        attribute :>> sectionTitle = "1. Problem Definition and Intended Scope";
        attribute :>> requirementIds = "R010, R013, R027, R036";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP02 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP02";
        attribute :>> sectionTitle = "2. Governing Philosophy and Trust Boundaries";
        attribute :>> requirementIds = "R001, R007, R021, R028, R033";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP03 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP03";
        attribute :>> sectionTitle = "3. Risk Acceptance and Authorization";
        attribute :>> requirementIds = "R005, R006, R007, R008, R030, R031, R032";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP04 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP04";
        attribute :>> sectionTitle = "4. Logical Architecture";
        attribute :>> requirementIds = "R001, R002, R003, R011, R029";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP05 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP05";
        attribute :>> sectionTitle = "5. Durable Execution and Action Lifecycle";
        attribute :>> requirementIds = "R002, R004, R008, R009, R032, R033, R034";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP06 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP06";
        attribute :>> sectionTitle = "6. Graph Semantics and Traversal Attestation";
        attribute :>> requirementIds = "R011, R013, R022, R025, R026, R027, R035";
        attribute :>> designNamespace = "EAH_Behavior";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP07 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP07";
        attribute :>> sectionTitle = "7. Independent Reconciliation and Sibling-Graph Consistency";
        attribute :>> requirementIds = "R012, R014, R015, R027";
        attribute :>> designNamespace = "EAH_Behavior";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP08 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP08";
        attribute :>> sectionTitle = "8. Evidence Status and Proof-Carrying Responses";
        attribute :>> requirementIds = "R010, R018, R022, R036, R040";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP09 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP09";
        attribute :>> sectionTitle = "9. Formal Constraints and Solver Semantics";
        attribute :>> requirementIds = "R017, R023";
        attribute :>> designNamespace = "EAH_Common";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP10 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP10";
        attribute :>> sectionTitle = "10. Tool Authorization and Action Integrity";
        attribute :>> requirementIds = "R007, R008, R009, R029, R033";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP11 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP11";
        attribute :>> sectionTitle = "11. Knowledge Integrity, Memory, and Synchronization";
        attribute :>> requirementIds = "R018, R019, R020, R028";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP12 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP12";
        attribute :>> sectionTitle = "12. Threat Model and Failure Modes";
        attribute :>> requirementIds = "R003, R016, R021, R028, R029, R030, R032, R034";
        attribute :>> designNamespace = "EAH_ThreatModel";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP13 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP13";
        attribute :>> sectionTitle = "13. MBSE Reference Case";
        attribute :>> requirementIds = "R024, R025, R027, R039";
        attribute :>> designNamespace = "EAH_MBSE_Reference";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP14 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP14";
        attribute :>> sectionTitle = "14. Evaluation and Service Objectives";
        attribute :>> requirementIds = "R027, R037, R038, R040";
        attribute :>> designNamespace = "EAH_AdversarialEvaluation";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP15 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP15";
        attribute :>> sectionTitle = "15. Related Work and Architectural Differentiation";
        attribute :>> requirementIds = "R037, R039";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP16 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP16";
        attribute :>> sectionTitle = "16. Proposed Validation Roadmap";
        attribute :>> requirementIds = "R027, R037, R038";
        attribute :>> designNamespace = "EAH_AdversarialEvaluation";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item WP17 : DocumentSectionTrace {
        attribute :>> sourceDocument = "WhitePaper";
        attribute :>> sourceSection = "WP17";
        attribute :>> sectionTitle = "17. Decision Ledger and Outstanding Questions";
        attribute :>> requirementIds = "R001, R005, R006, R022, R040";
        attribute :>> designNamespace = "EAH_Architecture";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT01 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT01";
        attribute :>> sectionTitle = "1. The Core Challenge";
        attribute :>> requirementIds = "R037, R040";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT02 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT02";
        attribute :>> sectionTitle = "2. \"Why Not Just Use Codex?\"";
        attribute :>> requirementIds = "R037, R039";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT03 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT03";
        attribute :>> sectionTitle = "3. \"Why Not OpenAI Agents, Microsoft, AWS, or Google Managed Agents?\"";
        attribute :>> requirementIds = "R037, R039";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT04 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT04";
        attribute :>> sectionTitle = "4. \"Why Not the MBSE and ALM Tools We Already Own?\"";
        attribute :>> requirementIds = "R024, R037";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT05 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT05";
        attribute :>> sectionTitle = "5. \"Why Use an Agent at All?\"";
        attribute :>> requirementIds = "R027, R037";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT06 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT06";
        attribute :>> sectionTitle = "6. The Proof Problem: What Does Traversal Attestation Actually Prove?";
        attribute :>> requirementIds = "R011, R013, R025, R026, R027";
        attribute :>> designNamespace = "EAH_AssuranceCase";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT07 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT07";
        attribute :>> sectionTitle = "7. Two Queries Are Not Necessarily Independent";
        attribute :>> requirementIds = "R012";
        attribute :>> designNamespace = "EAH_AssuranceCase";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT08 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT08";
        attribute :>> sectionTitle = "8. Sibling-Graph Comparison Can Reinforce Institutional Mistakes";
        attribute :>> requirementIds = "R014, R027";
        attribute :>> designNamespace = "EAH_AssuranceCase";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT09 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT09";
        attribute :>> sectionTitle = "9. User-Maintained Specialized Prompts Are Both a Feature and a Liability";
        attribute :>> requirementIds = "R015, R028";
        attribute :>> designNamespace = "EAH_AssuranceCase";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT10 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT10";
        attribute :>> sectionTitle = "10. \"Show All Findings Together\" Is an Honest UX Goal, Not Omniscience";
        attribute :>> requirementIds = "R003, R004, R005, R023, R035";
        attribute :>> designNamespace = "EAH_Behavior";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT11 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT11";
        attribute :>> sectionTitle = "11. One Acknowledgement Per Individual Action: Safety or Ceremony?";
        attribute :>> requirementIds = "R006, R008, R030, R031, R032";
        attribute :>> designNamespace = "EAH_Behavior";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT12 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT12";
        attribute :>> sectionTitle = "12. Formal Verification Risks Becoming \"Proof Theater\"";
        attribute :>> requirementIds = "R017, R022, R040";
        attribute :>> designNamespace = "EAH_Behavior";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT13 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT13";
        attribute :>> sectionTitle = "13. The Security Attack Surface May Grow Faster Than the Assurance Surface";
        attribute :>> requirementIds = "R007, R021, R028, R029, R033, R034";
        attribute :>> designNamespace = "EAH_ThreatModel";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT14 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT14";
        attribute :>> sectionTitle = "14. Economics: The Hidden Cost Is Integration, Not Tokens";
        attribute :>> requirementIds = "R038";
        attribute :>> designNamespace = "EAH_AdversarialEvaluation";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT15 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT15";
        attribute :>> sectionTitle = "15. What Is Actually Distinctive?";
        attribute :>> requirementIds = "R037, R039";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT16 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT16";
        attribute :>> sectionTitle = "16. Decision Matrix: Build, Buy, or Compose?";
        attribute :>> requirementIds = "R037";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT17 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT17";
        attribute :>> sectionTitle = "17. Falsification Protocol: Try to Kill the Idea";
        attribute :>> requirementIds = "R027, R038";
        attribute :>> designNamespace = "EAH_AdversarialEvaluation";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT18 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT18";
        attribute :>> sectionTitle = "18. The Most Damaging Questions to Ask a Founder or Chief Architect";
        attribute :>> requirementIds = "R040";
        attribute :>> designNamespace = "EAH_Behavior";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT19 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT19";
        attribute :>> sectionTitle = "19. Recommended Product Sequencing";
        attribute :>> requirementIds = "R027, R037";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    item RT20 : DocumentSectionTrace {
        attribute :>> sourceDocument = "AdversarialReview";
        attribute :>> sourceSection = "RT20";
        attribute :>> sectionTitle = "20. Conditional Verdict";
        attribute :>> requirementIds = "R037, R040";
        attribute :>> designNamespace = "EAH_TradeStudies";
        attribute :>> verificationNamespace = "EAH_Verification / EAH_ThreatModel / EAH_AdversarialEvaluation / EAH_TradeStudies / EAH_DataAndOperations / EAH_AssuranceCase";
        attribute :>> evidenceState = "Modeled obligations; verification results pending";
    }

    analysis def AuditDocumentToModelCoverage {
        action enumerateAllSeventeenWhitePaperChapters;
        then action enumerateAllTwentyAdversarialReviewChapters;
        then action validateRequirementsNamedInEachTrace;
        then action validateVerificationObjectivesExist;
        then action distinguishDeclaredObjectiveFromExecutedTestPass;
        then action reportAllUnmappedOrUnverifiedObligations;
    }
}

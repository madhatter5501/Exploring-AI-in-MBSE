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

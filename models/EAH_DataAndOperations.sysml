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

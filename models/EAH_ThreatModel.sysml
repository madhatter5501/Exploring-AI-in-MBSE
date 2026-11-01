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

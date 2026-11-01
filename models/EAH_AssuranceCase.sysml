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

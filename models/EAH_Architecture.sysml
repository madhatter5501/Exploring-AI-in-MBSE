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

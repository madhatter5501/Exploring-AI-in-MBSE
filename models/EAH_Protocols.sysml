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

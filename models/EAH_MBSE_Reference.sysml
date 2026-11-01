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

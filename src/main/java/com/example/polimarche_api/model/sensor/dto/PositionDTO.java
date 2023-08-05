package com.example.polimarche_api.model.sensor.dto;

public record PositionDTO(
        Integer sessione,
        Integer setup,
        Double throttle,
        Double steeringAngle,
        Double suspensionFR,
        Double suspensionFL,
        Double suspensionRR,
        Double suspensionRL
) {
}

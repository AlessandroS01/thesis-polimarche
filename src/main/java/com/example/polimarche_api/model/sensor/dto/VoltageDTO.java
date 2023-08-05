package com.example.polimarche_api.model.sensor.dto;

public record VoltageDTO(
        Integer sessione,
        Integer setup,
        Double lvBattery,
        Double source24V,
        Double source5V
) {
}

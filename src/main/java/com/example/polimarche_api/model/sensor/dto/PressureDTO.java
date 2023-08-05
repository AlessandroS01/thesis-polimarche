package com.example.polimarche_api.model.sensor.dto;

public record PressureDTO(
        Integer sessione,
        Integer setup,
        Double brakeF,
        Double brakeR,
        Double coolant
) {
}

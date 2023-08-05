package com.example.polimarche_api.model.sensor.dto;

import jakarta.persistence.Column;

public record SpeedDTO(
        Integer sessione,
        Integer setup,
        Double wheelFR,
        Double wheelFL
) {
}

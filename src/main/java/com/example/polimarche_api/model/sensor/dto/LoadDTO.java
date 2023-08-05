package com.example.polimarche_api.model.sensor.dto;

import jakarta.persistence.Column;

public record LoadDTO(
        Integer sessione,
        Integer setup,
        Double steerTorque,
        Double pushFR,
        Double pushFL,
        Double pushRR,
        Double pushRL
) {
}

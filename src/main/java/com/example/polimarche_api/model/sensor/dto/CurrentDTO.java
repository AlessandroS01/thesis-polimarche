package com.example.polimarche_api.model.sensor.dto;

import jakarta.persistence.Column;
import jakarta.persistence.criteria.CriteriaBuilder;

public record CurrentDTO(
        Integer sessione,
        Integer setup,
        Double bpCurrent,
        Double lvBattery,
        Double waterPump,
        Double coolingFanSys
) {
}

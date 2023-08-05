package com.example.polimarche_api.model.sensor.dto;

public record TemperatureDTO(
        Integer sessione,
        Integer setup,
        Double igbt,
        Double motorOne,
        Double motorTwo,
        Double inverter,
        Double module,
        Double pdm,
        Double coolantIn,
        Double coolantOut,
        Double mcu,
        Double vcu,
        Double air,
        Double humidity,
        Double brakeFR,
        Double brakeFL,
        Double brakeRR,
        Double brakeRL,
        Double tyreFR,
        Double tyreFL,
        Double tyreRR,
        Double tyreRL
) {
}

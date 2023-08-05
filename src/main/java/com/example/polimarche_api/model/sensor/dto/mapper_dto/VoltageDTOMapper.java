package com.example.polimarche_api.model.sensor.dto.mapper_dto;

import com.example.polimarche_api.model.sensor.Temperature;
import com.example.polimarche_api.model.sensor.Voltage;
import com.example.polimarche_api.model.sensor.dto.TemperatureDTO;
import com.example.polimarche_api.model.sensor.dto.VoltageDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class VoltageDTOMapper implements Function<Voltage, VoltageDTO> {

    @Override
    public VoltageDTO apply(Voltage voltage) {
        return new VoltageDTO(
                voltage.getSessione().getId(),
                voltage.getSetup().getId(),
                voltage.getLvBattery(),
                voltage.getSource24V(),
                voltage.getSource5V()
        );
    }
}

package com.example.polimarche_api.model.sensor.dto.mapper_dto;

import com.example.polimarche_api.model.sensor.Speed;
import com.example.polimarche_api.model.sensor.Temperature;
import com.example.polimarche_api.model.sensor.dto.SpeedDTO;
import com.example.polimarche_api.model.sensor.dto.TemperatureDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class TemperatureDTOMapper implements Function<Temperature, TemperatureDTO> {

    @Override
    public TemperatureDTO apply(Temperature temperature) {
        return new TemperatureDTO(
                temperature.getSessione().getId(),
                temperature.getSetup().getId(),
                temperature.getIgbt(),
                temperature.getMotorOne(),
                temperature.getMotorTwo(),
                temperature.getInverter(),
                temperature.getModule(),
                temperature.getPdm(),
                temperature.getCoolantIn(),
                temperature.getCoolantOut(),
                temperature.getMcu(),
                temperature.getVcu(),
                temperature.getAir(),
                temperature.getHumidity(),
                temperature.getBrakeFR(),
                temperature.getBrakeFL(),
                temperature.getBrakeRR(),
                temperature.getBrakeRL(),
                temperature.getTyreFR(),
                temperature.getTyreFL(),
                temperature.getTyreRR(),
                temperature.getTyreRL()
        );
    }
}

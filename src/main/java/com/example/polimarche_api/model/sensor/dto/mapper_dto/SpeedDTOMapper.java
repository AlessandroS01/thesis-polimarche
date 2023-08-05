package com.example.polimarche_api.model.sensor.dto.mapper_dto;

import com.example.polimarche_api.model.sensor.Pressure;
import com.example.polimarche_api.model.sensor.Speed;
import com.example.polimarche_api.model.sensor.dto.PressureDTO;
import com.example.polimarche_api.model.sensor.dto.SpeedDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class SpeedDTOMapper implements Function<Speed, SpeedDTO> {

    @Override
    public SpeedDTO apply(Speed speed) {
        return new SpeedDTO(
                speed.getSessione().getId(),
                speed.getSetup().getId(),
                speed.getWheelFR(),
                speed.getWheelFL()
        );
    }
}

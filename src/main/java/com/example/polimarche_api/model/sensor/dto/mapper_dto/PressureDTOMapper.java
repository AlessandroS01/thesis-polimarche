package com.example.polimarche_api.model.sensor.dto.mapper_dto;

import com.example.polimarche_api.model.sensor.Position;
import com.example.polimarche_api.model.sensor.Pressure;
import com.example.polimarche_api.model.sensor.dto.PositionDTO;
import com.example.polimarche_api.model.sensor.dto.PressureDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class PressureDTOMapper implements Function<Pressure, PressureDTO> {

    @Override
    public PressureDTO apply(Pressure pressure) {
        return new PressureDTO(
                pressure.getSessione().getId(),
                pressure.getSetup().getId(),
                pressure.getBrakeF(),
                pressure.getBrakeR(),
                pressure.getCoolant()
        );
    }
}

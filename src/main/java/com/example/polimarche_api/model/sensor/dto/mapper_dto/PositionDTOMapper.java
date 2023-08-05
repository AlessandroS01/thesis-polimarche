package com.example.polimarche_api.model.sensor.dto.mapper_dto;

import com.example.polimarche_api.model.sensor.Load;
import com.example.polimarche_api.model.sensor.Position;
import com.example.polimarche_api.model.sensor.dto.LoadDTO;
import com.example.polimarche_api.model.sensor.dto.PositionDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class PositionDTOMapper implements Function<Position, PositionDTO> {

    @Override
    public PositionDTO apply(Position position) {
        return new PositionDTO(
                position.getSessione().getId(),
                position.getSetup().getId(),
                position.getThrottle(),
                position.getSteeringAngle(),
                position.getSuspensionFR(),
                position.getSuspensionFL(),
                position.getSuspensionRR(),
                position.getSuspensionRL()
        );
    }
}

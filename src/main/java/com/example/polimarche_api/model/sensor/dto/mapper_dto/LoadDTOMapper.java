package com.example.polimarche_api.model.sensor.dto.mapper_dto;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Load;
import com.example.polimarche_api.model.sensor.dto.CurrentDTO;
import com.example.polimarche_api.model.sensor.dto.LoadDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class LoadDTOMapper implements Function<Load, LoadDTO> {

    @Override
    public LoadDTO apply(Load load) {
        return new LoadDTO(
                load.getSessione().getId(),
                load.getSetup().getId(),
                load.getSteerTorque(),
                load.getPushFR(),
                load.getPushFL(),
                load.getPushRR(),
                load.getPushRL()
        );
    }
}

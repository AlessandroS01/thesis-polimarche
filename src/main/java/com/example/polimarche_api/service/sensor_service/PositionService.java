package com.example.polimarche_api.service.sensor_service;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Position;
import com.example.polimarche_api.model.sensor.dto.PositionDTO;
import com.example.polimarche_api.model.sensor.dto.mapper_dto.PositionDTOMapper;
import com.example.polimarche_api.repository.sensor_repository.PositionRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PositionService {

    private final PositionRepository positionRepository;

    private final PositionDTOMapper positionDTOMapper = new PositionDTOMapper();

    public PositionService(PositionRepository positionRepository) {
        this.positionRepository = positionRepository;
    }


    public List<PositionDTO> getPositionBySessionAndSetup(Integer sessionId, Integer setupId) {
        return positionRepository.findBySessioneIdAndSetupId(sessionId, setupId).
                stream().
                map(positionDTOMapper).
                collect(Collectors.toList());
    }
}

package com.example.polimarche_api.service.sensor_service;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Speed;
import com.example.polimarche_api.model.sensor.dto.SpeedDTO;
import com.example.polimarche_api.model.sensor.dto.mapper_dto.SpeedDTOMapper;
import com.example.polimarche_api.repository.sensor_repository.SpeedRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SpeedService {

    private final SpeedRepository speedRepository;

    private final SpeedDTOMapper speedDTOMapper = new SpeedDTOMapper();

    public SpeedService(SpeedRepository speedRepository) {
        this.speedRepository = speedRepository;
    }


    public List<SpeedDTO> getSpeedBySessionAndSetup(Integer sessionId, Integer setupId) {
        return speedRepository.findBySessioneIdAndSetupId(sessionId, setupId).
                stream().
                map(speedDTOMapper).
                collect(Collectors.toList());
    }
}

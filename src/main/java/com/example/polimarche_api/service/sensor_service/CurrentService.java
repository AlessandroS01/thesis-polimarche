package com.example.polimarche_api.service.sensor_service;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.dto.CurrentDTO;
import com.example.polimarche_api.model.sensor.dto.mapper_dto.CurrentDTOMapper;
import com.example.polimarche_api.repository.sensor_repository.CurrentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CurrentService {

    private final CurrentRepository currentRepository;
    private final CurrentDTOMapper currentDTOMapper = new CurrentDTOMapper();

    public CurrentService(CurrentRepository currentRepository) {
        this.currentRepository = currentRepository;
    }

    public List<CurrentDTO> getCurrentBySessionAndSetup(Integer sessionId, Integer setupId) {
        return currentRepository.findBySessioneIdAndSetupId(sessionId, setupId).
                stream().
                map(currentDTOMapper).
                collect(Collectors.toList());
    }
}

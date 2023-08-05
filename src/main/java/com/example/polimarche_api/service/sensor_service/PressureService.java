package com.example.polimarche_api.service.sensor_service;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Pressure;
import com.example.polimarche_api.model.sensor.dto.PressureDTO;
import com.example.polimarche_api.model.sensor.dto.mapper_dto.PressureDTOMapper;
import com.example.polimarche_api.repository.sensor_repository.PressureRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PressureService {

    private final PressureRepository pressureRepository;

    private final PressureDTOMapper pressureDTOMapper = new PressureDTOMapper();

    public PressureService(PressureRepository pressureRepository) {
        this.pressureRepository = pressureRepository;
    }


    public List<PressureDTO> getPressureBySessionAndSetup(Integer sessionId, Integer setupId) {
        return pressureRepository.findBySessioneIdAndSetupId(sessionId, setupId).
                stream().
                map(pressureDTOMapper).
                collect(Collectors.toList());
    }
}

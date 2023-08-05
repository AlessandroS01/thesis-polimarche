package com.example.polimarche_api.service.sensor_service;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Temperature;
import com.example.polimarche_api.model.sensor.dto.TemperatureDTO;
import com.example.polimarche_api.model.sensor.dto.mapper_dto.TemperatureDTOMapper;
import com.example.polimarche_api.repository.sensor_repository.TemperatureRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TemperatureService {

    private final TemperatureRepository temperatureRepository;

    private final TemperatureDTOMapper temperatureDTOMapper = new TemperatureDTOMapper();

    public TemperatureService(TemperatureRepository temperatureRepository) {
        this.temperatureRepository = temperatureRepository;
    }

    public List<TemperatureDTO> getTemperatureBySessionAndSetup(Integer sessionId, Integer setupId) {
        return temperatureRepository.findBySessioneIdAndSetupId(sessionId, setupId).
                stream().
                map(temperatureDTOMapper).
                collect(Collectors.toList());
    }
}

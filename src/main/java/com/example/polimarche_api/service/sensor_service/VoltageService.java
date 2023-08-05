package com.example.polimarche_api.service.sensor_service;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Voltage;
import com.example.polimarche_api.model.sensor.dto.VoltageDTO;
import com.example.polimarche_api.model.sensor.dto.mapper_dto.VoltageDTOMapper;
import com.example.polimarche_api.repository.sensor_repository.VoltageRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class VoltageService {

    private final VoltageRepository voltageRepository;

    private final VoltageDTOMapper voltageDTOMapper = new VoltageDTOMapper();

    public VoltageService(VoltageRepository voltageRepository) {
        this.voltageRepository = voltageRepository;
    }


    public List<VoltageDTO> getVoltageBySessionAndSetup(Integer sessionId, Integer setupId) {
        return voltageRepository.findBySessioneIdAndSetupId(sessionId, setupId).
                stream().
                map(voltageDTOMapper).
                collect(Collectors.toList());
    }
}

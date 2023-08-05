package com.example.polimarche_api.service.sensor_service;

import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Load;
import com.example.polimarche_api.model.sensor.dto.LoadDTO;
import com.example.polimarche_api.model.sensor.dto.mapper_dto.LoadDTOMapper;
import com.example.polimarche_api.repository.sensor_repository.LoadRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class LoadService {

    private final LoadRepository loadRepository;

    private final LoadDTOMapper loadDTOMapper = new LoadDTOMapper();

    public LoadService(LoadRepository loadRepository) {
        this.loadRepository = loadRepository;
    }


    public List<LoadDTO> getLoadBySessionAndSetup(Integer sessionId, Integer setupId) {
        return loadRepository.findBySessioneIdAndSetupId(sessionId, setupId).
                stream().
                map(loadDTOMapper).
                collect(Collectors.toList());
    }
}

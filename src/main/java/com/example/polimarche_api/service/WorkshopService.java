package com.example.polimarche_api.service;

import com.example.polimarche_api.model.Track;
import com.example.polimarche_api.model.Workshop;
import com.example.polimarche_api.repository.TrackRepository;
import com.example.polimarche_api.repository.WorkshopRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class WorkshopService {
    private final WorkshopRepository workshopRepository;

    @Autowired
    public WorkshopService(WorkshopRepository workshopRepository) {
        this.workshopRepository = workshopRepository;
    }

    public List<Workshop> getAllAreas() {
        return workshopRepository.findAll();
    }

}

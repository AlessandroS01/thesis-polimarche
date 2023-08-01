package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Track;
import com.example.polimarche_api.model.Workshop;
import com.example.polimarche_api.repository.TrackRepository;
import com.example.polimarche_api.service.TrackService;
import com.example.polimarche_api.service.WorkshopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/workshop")
public class WorkshopController {
    private final WorkshopService workshopService;

    public WorkshopController(WorkshopService workshopService) {
        this.workshopService = workshopService;
    }

    @GetMapping
    public List<Workshop> getAllAreas(){
        return workshopService.getAllAreas();
    }

}


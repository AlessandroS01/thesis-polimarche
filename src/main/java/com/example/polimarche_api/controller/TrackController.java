package com.example.polimarche_api.controller;

import com.example.polimarche_api.repository.TrackRepository;
import com.example.polimarche_api.service.TrackService;
import com.example.polimarche_api.model.Track;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/track")
public class TrackController {
    private final TrackService trackService;

    @Autowired
    public TrackController(TrackService trackService) {
        this.trackService = trackService;
    }

    /**
     *
     * @return list of all tracks
     */
    @GetMapping
    public List<Track> getAllTracks() {
        return trackService.getAllTracks();
    }

    /**
     *
     * @param request used to create a new record inside Track
     */
    @PostMapping
    public void addTrack(@RequestBody TrackRepository.NewTrackRequest request){
        trackService.addTrack(request);
    }

    /**
     *
     * @param request used to modify the length of a track
     */
    @PutMapping
    public void modifyLengthTrack(@RequestBody TrackRepository.NewTrackRequest request){
        trackService.modifyLength(request.name(), request.length());
    }
}


package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.records.NewTrack;
import com.example.polimarche_api.model.records.NewTrackLength;
import com.example.polimarche_api.repository.TrackRepository;
import com.example.polimarche_api.service.TrackService;
import com.example.polimarche_api.model.Track;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/track")
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
    public ResponseEntity<String> addTrack(@RequestBody NewTrack request){
        Track track = trackService.addTrack(request);
        return new ResponseEntity<>(track.getNome(), HttpStatus.CREATED);
    }

    /**
     *
     * @param length
     * @param name
     * @return
     */
    @PutMapping("/{name}")
    public ResponseEntity<String> modifyLengthTrack(
            @RequestBody NewTrackLength request,
            @PathVariable String name
    ){
        trackService.modifyLength(request, name);
        return new ResponseEntity<>("Modified " + name, HttpStatus.ACCEPTED);
    }
}


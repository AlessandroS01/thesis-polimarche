package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Track;
import com.example.polimarche_api.repository.TrackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class TrackService {
    private final TrackRepository trackRepository;

    @Autowired
    public TrackService(TrackRepository trackRepository) {
        this.trackRepository = trackRepository;
    }

    // read the record created with the parameters sent with the request
    public Track recordReader(TrackRepository.NewTrackRequest request){
        String nome = request.name();
        Double lunghezza = request.length();

        return new Track(nome, lunghezza);
    }

    public List<Track> getAllTracks() {
        return trackRepository.findAll();
    }


    public Track addTrack(TrackRepository.NewTrackRequest request) {
        Track track = recordReader(request);
        trackRepository.save(track);
        return track;
    }


    public void modifyLength(Double length, String name){
        Track track = trackRepository.findById(name).orElseThrow( () ->
                new ResourceNotFoundException("Track " + name + " not found")
        );
        track.setLunghezza(length);
        trackRepository.save(track);
    }
}

package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Track;
import com.example.polimarche_api.model.records.NewTrack;
import com.example.polimarche_api.model.records.NewTrackLength;
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
    public Track recordReader(NewTrack request){
        String nome = request.name();
        Double lunghezza = request.length();

        return new Track(nome, lunghezza);
    }

    public List<Track> getAllTracks() {
        return trackRepository.findAll();
    }


    public Track addTrack(NewTrack request) {
        if (trackRepository.existsById(request.name())){
            throw new RuntimeException("Track already exists");
        }
        else{
            Track track = recordReader(request);
            trackRepository.save(track);
            return track;
        }
    }


    public void modifyLength(NewTrackLength request, String name){
        Track track = trackRepository.findById(name).orElseThrow( () ->
                new ResourceNotFoundException("Track " + name + " not found")
        );
        track.setLunghezza(request.lunghezza());
        trackRepository.save(track);
    }
}

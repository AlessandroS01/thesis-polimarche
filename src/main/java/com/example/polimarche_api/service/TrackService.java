package com.example.polimarche_api.service;

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


    public void addTrack(TrackRepository.NewTrackRequest request) {
        Track track = recordReader(request);
        if (trackRepository.existsById(track.getNome())){
            throw new IllegalArgumentException("Track already exists");
        }

        trackRepository.save(track);
    }

    /**
     *
     * @param nome is the nome of the track that should be modified
     * @param lunghezza is the new length of the track
     */
    public void modifyLength(String nome, Double lunghezza){
        Optional<Track> optionalTrack = trackRepository.findById(nome);

        if (optionalTrack.isPresent()) {
            Track track = optionalTrack.get();

            track.setLunghezza(lunghezza);

            trackRepository.save(track);
        } else {
            throw new NoSuchElementException("Track with nome " + nome + " not found.");
        }
    }
}

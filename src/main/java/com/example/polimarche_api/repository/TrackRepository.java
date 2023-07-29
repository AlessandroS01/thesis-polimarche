package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Track;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TrackRepository extends JpaRepository<Track, String> {

    /*
        Istanza di un record => classe immutabile utilizzata per contenere semplici dati
            avente già metodi getter e setter creati automaticamente
    */
    record NewTrackRequest(
            @JsonProperty("nome") String name,
            @JsonProperty("lunghezza") Double length
    ){

    }

}

package com.example.polimarche_api.repository;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Track;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.jpa.repository.JpaRepository;

import java.sql.Date;
import java.sql.Time;
import java.util.List;
import java.util.Optional;

public interface PracticeSessionRepository extends JpaRepository<PracticeSession, Integer> {

    List<PracticeSession> findByEvento(String event);

    record NewPracticeSession(
            @JsonProperty("id") Integer id,
            @JsonProperty("evento") String evento,
            @JsonProperty("data") Date data,
            @JsonProperty("ora_inizio") Time ora_inizio,
            @JsonProperty("ora_fine") Time ora_fine,
            @JsonProperty("tracciato") Track tracciato,
            @JsonProperty("meteo") String meteo,
            @JsonProperty("pressione_atmosferica") Double pressione_atmosferica,
            @JsonProperty("temperatura_aria") Double temperatura_aria,
            @JsonProperty("temperatura_tracciato") Double temperatura_tracciato,
            @JsonProperty("condizione_tracciato") String condizione_tracciato
    ){

    }
}

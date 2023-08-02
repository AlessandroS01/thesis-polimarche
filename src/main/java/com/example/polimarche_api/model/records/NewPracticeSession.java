package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Track;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.sql.Date;
import java.sql.Time;

public record NewPracticeSession(
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
) {
}

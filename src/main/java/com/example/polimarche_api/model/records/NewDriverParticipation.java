package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.PracticeSession;
import com.fasterxml.jackson.annotation.JsonProperty;

public record NewDriverParticipation(
        @JsonProperty("pilota") Driver pilota,
        @JsonProperty("sessione") PracticeSession sessione,
        @JsonProperty("ordine") Integer ordine,
        @JsonProperty("cambio_pilota") String cambio_pilota
) {
}

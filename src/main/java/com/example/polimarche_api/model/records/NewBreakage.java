package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewBreakage(
        @JsonProperty("descrizione") String descrizione
) {
}

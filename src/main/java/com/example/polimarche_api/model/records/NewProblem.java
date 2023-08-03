package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewProblem(
        @JsonProperty("descrizione") String descrizione
) {
}

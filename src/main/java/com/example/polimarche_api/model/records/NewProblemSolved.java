package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Problem;
import com.example.polimarche_api.model.Setup;
import com.fasterxml.jackson.annotation.JsonProperty;

public record NewProblemSolved(
        @JsonProperty("setup") Setup setup,
        @JsonProperty("problema") Problem problema,
        @JsonProperty("descrizione") String descrizione
) {
}

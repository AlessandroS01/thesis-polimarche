package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Problem;
import com.fasterxml.jackson.annotation.JsonProperty;

public record NewProblemLeadBreakage(
        @JsonProperty("problema") Problem problema,
        @JsonProperty("rottura") Breakage rottura,
        @JsonProperty("descrizione") String descrizione,
        @JsonProperty("colpa") Boolean colpa
) {
}

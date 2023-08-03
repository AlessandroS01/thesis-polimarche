package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.PracticeSession;
import com.fasterxml.jackson.annotation.JsonProperty;

public record NewBreakageHappen(
        @JsonProperty("sessione") PracticeSession sessione,
        @JsonProperty("rottura") Breakage rottura,
        @JsonProperty("descrizione") String descrizione,
        @JsonProperty("colpa") Boolean colpa
) {
}

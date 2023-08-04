package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import com.fasterxml.jackson.annotation.JsonProperty;

public record NewUsedSetup(
        @JsonProperty("setup") Setup setup,
        @JsonProperty("sessione") PracticeSession sessione,
        @JsonProperty("commento") String commento

        ) {
}

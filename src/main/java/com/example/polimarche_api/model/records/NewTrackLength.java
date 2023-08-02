package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewTrackLength(
        @JsonProperty("lunghezza") Double lunghezza
) {
}

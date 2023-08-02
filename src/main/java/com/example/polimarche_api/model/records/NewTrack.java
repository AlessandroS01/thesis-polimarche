package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewTrack(
        @JsonProperty("nome") String name,
        @JsonProperty("lunghezza") Double length
) {
}

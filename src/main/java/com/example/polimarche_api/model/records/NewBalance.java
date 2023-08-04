package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewBalance(
        @JsonProperty("posizione") String posizione,
        @JsonProperty("frenata") Double frenata,
        @JsonProperty("peso") Double peso
) {
}

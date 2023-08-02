package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewBioInfo(
        @JsonProperty("peso") Double peso,
        @JsonProperty("altezza") Integer altezza
) {
}

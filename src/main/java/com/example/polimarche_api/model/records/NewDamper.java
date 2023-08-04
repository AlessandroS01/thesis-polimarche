package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewDamper(
        @JsonProperty("posizione") String posizione,
        @JsonProperty("lsc") Double lsc,
        @JsonProperty("hsc") Double hsc,
        @JsonProperty("hsr") Double hsr,
        @JsonProperty("lsr") Double lsr
) {
}

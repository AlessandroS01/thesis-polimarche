package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Member;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.sql.Time;
import java.util.Date;

public record NewWheel(
        @JsonProperty("codifica") String codifica,
        @JsonProperty("posizione") String posizione,
        @JsonProperty("frontale") String frontale,
        @JsonProperty("superiore") String superiore,
        @JsonProperty("pressione") Double pressione
) {
}

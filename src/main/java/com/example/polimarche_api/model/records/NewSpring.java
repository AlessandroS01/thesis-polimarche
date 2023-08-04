package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NewSpring(
        @JsonProperty("posizione") String posizione,
        @JsonProperty("codifica") String codifica,
        @JsonProperty("posizione_arb") String posizioneArb,
        @JsonProperty("rigidezza_arb") String rigidezzaArb,
        @JsonProperty("altezza") Double altezza
) {
}

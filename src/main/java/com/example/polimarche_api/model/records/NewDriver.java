package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Member;
import com.fasterxml.jackson.annotation.JsonProperty;

public record NewDriver(
        @JsonProperty("membro") Member membro,
        @JsonProperty("peso") Double peso,
        @JsonProperty("altezza") Integer altezza

) {
}

package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Member;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.sql.Time;
import java.util.Date;

public record NewNota(
        @JsonProperty("data") Date data,
        @JsonProperty("ora_inizio") Time ora_inizio,
        @JsonProperty("ora_fine") Time ora_fine,
        @JsonProperty("membro") Member membro,
        @JsonProperty("descrizione") String descrizione
) {
}

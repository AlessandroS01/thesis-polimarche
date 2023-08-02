package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.Workshop;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public record NewMember(
        @JsonProperty("matricola") Integer matricola,
        @JsonProperty("password") String password,
        @JsonProperty("nome") String nome,
        @JsonProperty("cognome") String cognome,
        @JsonProperty("data_di_nascita") Date data_di_nascita,
        @JsonProperty("email") String email,
        @JsonProperty("numero_telefono") String numero_telefono,
        @JsonProperty("ruolo") String ruolo,
        @JsonProperty("reparto") Workshop reparto
) {
}

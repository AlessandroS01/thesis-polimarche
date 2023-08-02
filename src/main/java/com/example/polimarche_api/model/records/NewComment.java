package com.example.polimarche_api.model.records;

import com.example.polimarche_api.model.PracticeSession;
import com.fasterxml.jackson.annotation.JsonProperty;

/*
       Istanza di un record => classe immutabile utilizzata per contenere semplici dati
            avente già metodi getter e setter creati automaticamente
    */
public record NewComment(
        @JsonProperty("descrizione") String descrizione,
        @JsonProperty("flag") String flag,
        @JsonProperty("sessione") PracticeSession sessione
){

}
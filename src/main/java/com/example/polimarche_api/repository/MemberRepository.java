package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Workshop;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer> {

    Member findByRepartoAndRuolo(Workshop reparto, String ruolo);

    record NewMember(
            @JsonProperty("matricola") Integer matricola,
            @JsonProperty("password") String password,
            @JsonProperty("nome") String nome,
            @JsonProperty("cognome") String cognome,
            @JsonProperty("data_di_nascita") Date data_di_nascita,
            @JsonProperty("email") String email,
            @JsonProperty("numero_telefono") String numero_telefono,
            @JsonProperty("ruolo") String ruolo,
            @JsonProperty("reparto") Workshop reparto
    ){
    }
}

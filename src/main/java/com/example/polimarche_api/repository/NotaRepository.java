package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.Track;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Time;
import java.util.Date;
import java.util.List;

@Repository
public interface NotaRepository extends JpaRepository<Nota, Integer> {

    List<Nota> findAllByMembroMatricola(Integer matricola);

    /*
            Istanza di un record => classe immutabile utilizzata per contenere semplici dati
                avente già metodi getter e setter creati automaticamente
        */
    record NewNota(
            @JsonProperty("id") Integer id,
            @JsonProperty("data") Date data,
            @JsonProperty("ora_inizio") Time ora_inizio,
            @JsonProperty("ora_fine") Time ora_fine,
            @JsonProperty("membro") Member membro,
            @JsonProperty("descrizione") String descrizione
    ){

    }

}

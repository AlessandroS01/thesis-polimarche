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

    Boolean existsByMembroMatricola(Integer matricola);


}

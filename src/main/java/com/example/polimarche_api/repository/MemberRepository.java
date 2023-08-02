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
    Member findByMatricolaAndPassword(Integer matricola, String password);

}

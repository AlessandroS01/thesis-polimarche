package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.ProblemLeadBreakage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProblemLeadBreakageRepository extends JpaRepository<ProblemLeadBreakage, Integer> {

    Boolean existsByProblemaId(Integer id);
    Boolean existsByRotturaId(Integer id);

    List<ProblemLeadBreakage> findByProblemaId(Integer id);
    List<ProblemLeadBreakage> findByRotturaId(Integer id);
}

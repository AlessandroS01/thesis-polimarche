package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.ProblemEncountered;
import com.example.polimarche_api.model.ProblemSolved;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface ProblemSolvedRepository extends JpaRepository<ProblemSolved, Integer> {

    Boolean existsProblemSolvedBySetupIdAndProblemaId(Integer setupId, Integer problemId);

    List<ProblemSolved> findProblemSolvedBySetupId(Integer id);
    List<ProblemSolved> findProblemSolvedByProblemaId(Integer id);
}

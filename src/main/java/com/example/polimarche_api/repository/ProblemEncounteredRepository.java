package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.ProblemEncountered;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface ProblemEncounteredRepository extends JpaRepository<ProblemEncountered, Integer> {

    List<ProblemEncountered> findProblemEncounteredBySetupId(Integer id);
    List<ProblemEncountered> findProblemEncounteredByProblemaId(Integer id);
}

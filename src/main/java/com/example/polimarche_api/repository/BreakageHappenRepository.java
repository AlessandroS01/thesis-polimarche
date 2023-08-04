package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.BreakageHappen;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BreakageHappenRepository extends JpaRepository<BreakageHappen, Integer> {

    Boolean existsBySessioneId(Integer id);
    Boolean existsByRotturaId(Integer id);

    List<BreakageHappen> findBySessioneId(Integer id);
    List<BreakageHappen> findByRotturaId(Integer id);
    List<BreakageHappen> findBreakageHappensByColpaPilotaTrue();
}

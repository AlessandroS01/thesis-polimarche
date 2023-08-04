package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.Damper;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface DamperRepository extends JpaRepository<Damper, Integer> {

    List<Damper> findDamperByPosizione(String position);
}

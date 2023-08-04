package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.UsedSetup;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface UsedSetupRepository extends JpaRepository<UsedSetup, Integer> {

    List<UsedSetup> findUsedSetupBySessioneId(Integer id);
    List<UsedSetup> findUsedSetupBySetupId(Integer id);
}

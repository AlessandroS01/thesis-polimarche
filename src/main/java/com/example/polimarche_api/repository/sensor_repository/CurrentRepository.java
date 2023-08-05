package com.example.polimarche_api.repository.sensor_repository;


import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Temperature;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface CurrentRepository extends JpaRepository<Current, Long> {

    List<Current> findBySessioneIdAndSetupId(Integer sessionId, Integer setupId);

}

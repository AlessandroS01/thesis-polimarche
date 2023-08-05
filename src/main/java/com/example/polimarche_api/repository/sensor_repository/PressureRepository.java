package com.example.polimarche_api.repository.sensor_repository;


import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Pressure;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface PressureRepository extends JpaRepository<Pressure, Long> {

    List<Pressure> findBySessioneIdAndSetupId(Integer sessionId, Integer setupId);

}

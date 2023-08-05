package com.example.polimarche_api.repository.sensor_repository;


import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.Position;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface PositionRepository extends JpaRepository<Position, Long> {

    List<Position> findBySessioneIdAndSetupId(Integer sessionId, Integer setupId);
}

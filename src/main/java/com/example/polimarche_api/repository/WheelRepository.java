package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.Wheel;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface WheelRepository extends JpaRepository<Wheel, Integer> {

    List<Wheel> findWheelByPosizione(String position);
}

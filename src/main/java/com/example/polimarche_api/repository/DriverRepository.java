package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Driver;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface DriverRepository extends JpaRepository<Driver, Integer> {

    Driver findByMembroMatricola(Integer matricola);

    Boolean existsByMembroMatricola(Integer matricola);

    void deleteByMembroMatricola(Integer matricola);
}

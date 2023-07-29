package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Track;
import com.example.polimarche_api.model.Workshop;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WorkshopRepository extends JpaRepository<Workshop, String> {
}

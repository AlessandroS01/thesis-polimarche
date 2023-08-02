package com.example.polimarche_api.repository;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Track;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.jpa.repository.JpaRepository;

import java.sql.Date;
import java.sql.Time;
import java.util.List;
import java.util.Optional;

public interface PracticeSessionRepository extends JpaRepository<PracticeSession, Integer> {

    List<PracticeSession> findByEvento(String event);

}

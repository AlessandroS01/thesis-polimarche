package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Participation;
import com.example.polimarche_api.model.PracticeSession;
import jakarta.persistence.Tuple;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.servlet.http.Part;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public interface ParticipationRepository extends JpaRepository<Participation, Integer> {

    Integer countParticipationBySessioneId(Integer sessioneId);

    List<Participation> findBySessioneId(Integer sessione);
    Boolean existsBySessioneId(Integer sessione);

    List<Participation> findByPilotaMembroMatricola(Integer id);
    Boolean existsByPilotaMembroMatricola(Integer id);

    List<Participation> findBySessioneIdAndPilotaMembroMatricola(Integer sessionId, Integer driverId);
    Boolean existsBySessioneIdAndPilotaMembroMatricola(Integer sessionId, Integer driverId);

    List<Participation> findBySessioneIdAndOrdineGreaterThan(Integer sessione, Integer ordine);
    List<Participation> findBySessioneIdAndOrdineGreaterThanEqual(Integer sessione, Integer ordine);

    Integer countParticipationBySessioneIdAndIdNot(Integer sessioneId, Integer participationId);

}

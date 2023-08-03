package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProblemRepository extends JpaRepository<Problem, Integer> {

}

package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BreakageRepository extends JpaRepository<Breakage, Integer> {

}

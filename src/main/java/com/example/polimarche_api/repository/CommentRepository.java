package com.example.polimarche_api.repository;


import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.PracticeSession;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Time;
import java.util.Date;
import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Integer> {

    Boolean existsCommentBySessioneId(Integer id);

    List<Comment> findAllBySessioneId(Integer id);


}

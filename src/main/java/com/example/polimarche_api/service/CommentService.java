package com.example.polimarche_api.service;

import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.repository.CommentRepository;
import com.example.polimarche_api.repository.NotaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class CommentService {
    private final CommentRepository commentRepository;

    @Autowired
    public CommentService(
            CommentRepository commentRepository
    ) {
        this.commentRepository = commentRepository;
    }

    public Comment recordReader(CommentRepository.NewComment request){
        Comment comment = new Comment();
        comment.setFlag(request.flag());
        comment.setDescrizione(request.descrizione());
        comment.setSessione(request.sessione());
        return comment;
    }

    public List<Comment> getAllComments() {
        return commentRepository.findAll();
    }

    public List<Comment> getCommentsBySession(Integer id) {
        return commentRepository.findAllBySessioneId(id);
    }

    public void addNewComment(CommentRepository.NewComment request) {
        Comment comment = recordReader(request);
        commentRepository.save(comment);
    }

    public void modifyComment(CommentRepository.NewComment request, Integer id) {

        Optional<Comment> optional = commentRepository.findById(id);
        if(optional.isPresent()){
            Comment comment = optional.get();

            comment.setDescrizione(request.descrizione());
            comment.setFlag(request.flag());
            comment.setSessione(request.sessione());
            commentRepository.save(comment);

        }
        else throw new NoSuchElementException("Comment " + id + " doesn't exist.");
    }
}

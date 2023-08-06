package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.records.NewComment;
import com.example.polimarche_api.repository.CommentRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    private final CommentRepository commentRepository;

    public CommentService(CommentRepository commentRepository) { this.commentRepository = commentRepository; }

    public Comment recordReader(NewComment request){
        Comment comment = new Comment();
        comment.setFlag(request.flag());
        comment.setDescrizione(request.descrizione());
        comment.setSessione(request.sessione());
        return comment;
    }

    public List<Comment> getAllComments() {
        return commentRepository.findAll();
    }

    /**
     *
     * @param id represents the id of the session reasearched
     * @return list of comments having id param as session id
     */
    public List<Comment> getCommentsBySession(Integer id) {
        if (commentRepository.existsCommentBySessioneId(id)) {
            return commentRepository.findAllBySessioneId(id);
        }
        else throw new ResourceNotFoundException("Comments not found for session ID: " + id);

    }

    public Integer addNewComment(NewComment request) {
        Comment comment = recordReader(request);
        commentRepository.save(comment);
        return comment.getId();
    }

    public void modifyComment(NewComment request, Integer id) {

        Comment comment = commentRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("Comment " + id + " doesn't exist.")
        );

        comment.setDescrizione(request.descrizione());
        comment.setFlag(request.flag());
        comment.setSessione(request.sessione());
        commentRepository.save(comment);
    }
}

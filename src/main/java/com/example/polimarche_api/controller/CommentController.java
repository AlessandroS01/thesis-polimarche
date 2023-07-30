package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.repository.CommentRepository;
import com.example.polimarche_api.repository.NotaRepository;
import com.example.polimarche_api.service.CommentService;
import com.example.polimarche_api.service.NotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/commento")
public class CommentController {
    private final CommentService commentService;

    @Autowired
    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    /**
     *
     * @return list of all the comments
     */
    @GetMapping
    public List<Comment> getAllComments(){
        return commentService.getAllComments();
    }

    /**
     *
     * @param id of the session to research comments
     * @return List of comments for that session
     */
    @GetMapping("/sessione/{id}")
    public List<Comment> getCommentsBySession(@PathVariable Integer id){
        return commentService.getCommentsBySession(id);
    }

    @PostMapping
    public void addComment(@RequestBody CommentRepository.NewComment request){
        commentService.addNewComment(request);
    }

    @PutMapping("/{id}")
    public void modifyComment(@RequestBody CommentRepository.NewComment request, @PathVariable Integer id){
        commentService.modifyComment(request, id);
    }


}


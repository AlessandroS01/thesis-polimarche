package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.repository.CommentRepository;
import com.example.polimarche_api.repository.NotaRepository;
import com.example.polimarche_api.service.CommentService;
import com.example.polimarche_api.service.NotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/comment")
public class CommentController {
    private final CommentService commentService;

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
    @GetMapping("/session/{id}")
    public List<Comment> getCommentsBySession(@PathVariable Integer id){
        return commentService.getCommentsBySession(id);
    }

    /**
     *
     * @param request contains the new comment in json
     * @return the code of the new comment if it was successfully created
     */
    @PostMapping
    public ResponseEntity<Integer> addComment(@RequestBody CommentRepository.NewComment request){
        Integer commentId = commentService.addNewComment(request);
        return new ResponseEntity<>(commentId, HttpStatus.CREATED);
    }

    /**
     *
     * @param request
     * @param id
     */
    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyComment(
            @RequestBody CommentRepository.NewComment request,
            @PathVariable Integer id
    ){
        commentService.modifyComment(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


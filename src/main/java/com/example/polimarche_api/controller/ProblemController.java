package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.Problem;
import com.example.polimarche_api.model.records.NewBreakage;
import com.example.polimarche_api.model.records.NewProblem;
import com.example.polimarche_api.service.ProblemService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/problem")
public class ProblemController {
    private final ProblemService problemService;

    public ProblemController(ProblemService problemService) {
        this.problemService = problemService;
    }


    /**
     *
     * @return list of all the breakages
     */
    @GetMapping
    public List<Problem> getAllProblems(){
        return problemService.getAllProblems();
    }


    /**
     *
     * @param request contains the new problem in json
     * @return the code of the new breakage if it was successfully created
     */
    @PostMapping
    public ResponseEntity<Integer> addBreakage(@RequestBody NewProblem request){
        Integer problemId = problemService.addProblem(request);
        return new ResponseEntity<>(problemId, HttpStatus.CREATED);
    }

    /**
     *
     * @param request
     * @param id
     */
    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyProblem(
            @RequestBody NewProblem request,
            @PathVariable Integer id
    ){
        problemService.modifyProblem(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


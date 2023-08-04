package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.ProblemSolved;
import com.example.polimarche_api.model.records.NewDescription;
import com.example.polimarche_api.model.records.NewProblemSolved;
import com.example.polimarche_api.service.ProblemSolvedService;
import com.example.polimarche_api.service.ProblemSolvedService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/problem-solved")
public class ProblemSolvedController {

    private final ProblemSolvedService problemSolvedService;


    public ProblemSolvedController(ProblemSolvedService problemSolvedService) {
        this.problemSolvedService = problemSolvedService;
    }

    @GetMapping
    public List<ProblemSolved> getAllProblemsSolved(){
        return problemSolvedService.getAllProblemsSolved();
    }

    @GetMapping("/setup/{id}")
    public List<ProblemSolved> getAllProblemsSolvedBySetup(@PathVariable Integer id){
        return problemSolvedService.getAllProblemsSolvedBySetup(id);
    }

    @GetMapping("/problem/{id}")
    public List<ProblemSolved> getAllSetupsEncounteringProblem(@PathVariable Integer id){
        return problemSolvedService.getAllSetupsEncounteringProblem(id);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifySolvedProblem(
            @RequestBody NewProblemSolved request,
            @PathVariable Integer id) {
        problemSolvedService.modifySolvedProblem(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Integer> deleteSolvedProblem(
            @RequestBody NewDescription request,
            @PathVariable Integer id) {
        problemSolvedService.deleteSolvedProblem(id, request);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }




}


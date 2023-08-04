package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.ProblemEncountered;
import com.example.polimarche_api.model.records.NewDescription;
import com.example.polimarche_api.model.records.NewProblemEncountered;
import com.example.polimarche_api.service.ProblemEncounteredService;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/problem-encountered")
public class ProblemEncounteredController {

    private final ProblemEncounteredService problemEncounteredService;


    public ProblemEncounteredController(ProblemEncounteredService problemEncounteredService) {
        this.problemEncounteredService = problemEncounteredService;
    }

    @GetMapping
    public List<ProblemEncountered> getAllProblemsEncountered(){
        return problemEncounteredService.getAllProblemsEncountered();
    }

    @GetMapping("/setup/{id}")
    public List<ProblemEncountered> getAllProblemsEncounteredBySetup(@PathVariable Integer id){
        return problemEncounteredService.getAllProblemsEncounteredBySetup(id);
    }

    @GetMapping("/problem/{id}")
    public List<ProblemEncountered> getAllSetupsEncounteringProblem(@PathVariable Integer id){
        return problemEncounteredService.getAllSetupsEncounteringProblem(id);
    }

    @PostMapping
    public ResponseEntity<Integer> addNewEncounterProblem(@RequestBody NewProblemEncountered request){
        Integer id = problemEncounteredService.addNewEncounterProblem(request);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyEncounteredProblem(
            @RequestBody NewProblemEncountered request,
            @PathVariable Integer id) {
        problemEncounteredService.modifyEncounteredProblem(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Integer> deleteEncounteredProblem(
            @RequestBody NewDescription request,
            @PathVariable Integer id) {
        problemEncounteredService.deleteEncounteredProblem(id, request);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }




}


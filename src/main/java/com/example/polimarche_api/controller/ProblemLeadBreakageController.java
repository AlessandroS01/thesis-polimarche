package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.ProblemLeadBreakage;
import com.example.polimarche_api.model.records.NewProblemLeadBreakage;
import com.example.polimarche_api.service.ProblemLeadBreakageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/problem-breakage")
public class ProblemLeadBreakageController {

    private final ProblemLeadBreakageService problemLeadBreakageService;

    public ProblemLeadBreakageController(ProblemLeadBreakageService problemLeadBreakageService) {
        this.problemLeadBreakageService = problemLeadBreakageService;
    }

    @GetMapping
    public List<ProblemLeadBreakage> getAllProblemLeadBreakages(){
        return problemLeadBreakageService.getAllProblemLeadBreakages();
    }

    @GetMapping("/problem/{id}")
    public List<ProblemLeadBreakage> getAllProblemLeadBreakagesByProblemId(@PathVariable Integer id){
        return problemLeadBreakageService.getAllProblemLeadBreakagesByProblemId(id);
    }

    @GetMapping("/breakage/{id}")
    public List<ProblemLeadBreakage> getAllProblemLeadBreakagesByBreakageId(@PathVariable Integer id){
        return problemLeadBreakageService.getAllProblemLeadBreakagesByBreakageId(id);
    }

    @PostMapping
    public ResponseEntity<Integer> addNewProblemLeadBreakage(@RequestBody NewProblemLeadBreakage request){
        Integer id = problemLeadBreakageService.addNewProblemLeadBreakage(request);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyProblemLeadBreakage(
            @RequestBody NewProblemLeadBreakage request,
            @PathVariable Integer id
    ){
        problemLeadBreakageService.modifyProblemLeadBreakage(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }


}


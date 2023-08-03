package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.Problem;
import com.example.polimarche_api.model.records.NewBreakage;
import com.example.polimarche_api.model.records.NewProblem;
import com.example.polimarche_api.repository.ProblemRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProblemService {
    private final ProblemRepository problemRepository;

    public ProblemService(ProblemRepository problemRepository) {
        this.problemRepository = problemRepository;
    }


    public List<Problem> getAllProblems() {
        return problemRepository.findAll();
    }

    public Integer addProblem(NewProblem request) {
        Problem problem = new Problem();
        problem.setDescrizione(request.descrizione());
        problemRepository.save(problem);
        return problem.getId();
    }

    public void modifyProblem(NewProblem request, Integer id) {
        Problem problem = problemRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No problem with id " + id)
                );
        problem.setDescrizione(request.descrizione());
        problemRepository.save(problem);
    }
}

package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.ProblemEncountered;
import com.example.polimarche_api.model.ProblemSolved;
import com.example.polimarche_api.model.records.NewDescription;
import com.example.polimarche_api.model.records.NewProblemSolved;
import com.example.polimarche_api.repository.ProblemEncounteredRepository;
import com.example.polimarche_api.repository.ProblemSolvedRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProblemSolvedService {

    private final ProblemSolvedRepository problemSolvedRepository;
    private final ProblemEncounteredRepository problemEncounteredRepository;

    public ProblemSolvedService(ProblemSolvedRepository problemSolvedRepository, ProblemEncounteredRepository problemEncounteredRepository) {
        this.problemSolvedRepository = problemSolvedRepository;
        this.problemEncounteredRepository = problemEncounteredRepository;
    }

    public List<ProblemSolved> getAllProblemsSolved() {
        return problemSolvedRepository.findAll();
    }

    public List<ProblemSolved> getAllProblemsSolvedBySetup(Integer id) {
        return problemSolvedRepository.findProblemSolvedBySetupId(id);
    }

    public List<ProblemSolved> getAllSetupsEncounteringProblem(Integer id) {
        return problemSolvedRepository.findProblemSolvedByProblemaId(id);
    }

    public void modifySolvedProblem(NewProblemSolved request, Integer id) {
        ProblemSolved problemSolved = problemSolvedRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No problem Solved saved with id " + id)
        );
        problemSolved.setProblema(request.problema());
        problemSolved.setSetup(request.setup());
        problemSolved.setDescrizione(request.descrizione());
        problemSolvedRepository.save(problemSolved);
    }

    public void deleteSolvedProblem(Integer id, NewDescription request) {
        ProblemSolved problemSolved = problemSolvedRepository.findById(id).orElseThrow(() ->
                new ResourceNotFoundException("No problem saved saved with id " + id)
        );

        ProblemEncountered problemEncountered = new ProblemEncountered();
        problemEncountered.setProblema(problemSolved.getProblema());
        problemEncountered.setSetup(problemSolved.getSetup());
        problemEncountered.setDescrizione(request.descrizione());

        problemSolvedRepository.deleteById(id);
        problemEncounteredRepository.save(problemEncountered);
    }
}

package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.ProblemEncountered;
import com.example.polimarche_api.model.ProblemSolved;
import com.example.polimarche_api.model.records.NewDescription;
import com.example.polimarche_api.model.records.NewProblemEncountered;
import com.example.polimarche_api.model.records.NewProblemSolved;
import com.example.polimarche_api.repository.ProblemEncounteredRepository;
import com.example.polimarche_api.repository.ProblemSolvedRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProblemEncounteredService {
    private final ProblemEncounteredRepository problemEncounteredRepository;
    private final ProblemSolvedRepository problemSolvedRepository;

    public ProblemEncounteredService(ProblemEncounteredRepository problemEncounteredRepository,
                                     ProblemSolvedRepository problemSolvedRepository) {
        this.problemEncounteredRepository = problemEncounteredRepository;
        this.problemSolvedRepository = problemSolvedRepository;
    }

    public List<ProblemEncountered> getAllProblemsEncountered() {
        return problemEncounteredRepository.findAll();
    }

    public List<ProblemEncountered> getAllProblemsEncounteredBySetup(Integer id) {
        return problemEncounteredRepository.findProblemEncounteredBySetupId(id);
    }

    public List<ProblemEncountered> getAllSetupsEncounteringProblem(Integer id) {
        return problemEncounteredRepository.findProblemEncounteredByProblemaId(id);
    }

    public Integer addNewEncounterProblem(NewProblemEncountered request) {
        if (!problemSolvedRepository.existsProblemSolvedBySetupIdAndProblemaId(
                request.setup().getId(),
                request.problema().getId())){
            ProblemEncountered problemEncountered = new ProblemEncountered();
            problemEncountered.setProblema(request.problema());
            problemEncountered.setSetup(request.setup());
            problemEncountered.setDescrizione(request.descrizione());
            problemEncounteredRepository.save(problemEncountered);
            return problemEncountered.getId();
        }
        else throw new RuntimeException("Cannot match this problem and setup because it was already solved.");
    }

    public void modifyEncounteredProblem(NewProblemEncountered request, Integer id) {
        ProblemEncountered problemEncountered = problemEncounteredRepository.findById(id).orElseThrow(() ->
                new ResourceNotFoundException("No problem encountered saved with id " + id)
        );
        if (!problemSolvedRepository.existsProblemSolvedBySetupIdAndProblemaId(
                request.setup().getId(),
                request.problema().getId())){

            problemEncountered.setProblema(request.problema());
            problemEncountered.setSetup(request.setup());
            problemEncountered.setDescrizione(request.descrizione());
            problemEncounteredRepository.save(problemEncountered);
        }
        else throw new RuntimeException("Cannot match this problem and setup because it was already solved.");
    }

    public void deleteEncounteredProblem(Integer id, NewDescription request) {
        ProblemEncountered problemEncountered = problemEncounteredRepository.findById(id).orElseThrow(() ->
                new ResourceNotFoundException("No problem encountered saved with id " + id)
        );

        ProblemSolved problemSolved = new ProblemSolved();
        problemSolved.setProblema(problemEncountered.getProblema());
        problemSolved.setSetup(problemEncountered.getSetup());
        problemSolved.setDescrizione(request.descrizione());

        problemEncounteredRepository.deleteById(id);
        problemSolvedRepository.save(problemSolved);
    }
}

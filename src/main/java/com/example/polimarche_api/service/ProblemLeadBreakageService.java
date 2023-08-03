package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.ProblemLeadBreakage;
import com.example.polimarche_api.model.records.NewProblemLeadBreakage;
import com.example.polimarche_api.repository.ProblemLeadBreakageRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProblemLeadBreakageService {

    private final ProblemLeadBreakageRepository problemLeadBreakageRepository;

    public ProblemLeadBreakageService(ProblemLeadBreakageRepository problemLeadBreakageRepository) {
        this.problemLeadBreakageRepository = problemLeadBreakageRepository;
    }


    public List<ProblemLeadBreakage> getAllProblemLeadBreakages() {
        return problemLeadBreakageRepository.findAll();
    }

    public List<ProblemLeadBreakage> getAllProblemLeadBreakagesByProblemId(Integer id) {
        if (problemLeadBreakageRepository.existsByProblemaId(id)){
            return problemLeadBreakageRepository.findByProblemaId(id);
        }
        else throw new ResourceNotFoundException("No breakage was caused by problem " + id);
    }

    public List<ProblemLeadBreakage> getAllProblemLeadBreakagesByBreakageId(Integer id) {
        if (problemLeadBreakageRepository.existsByRotturaId(id)){
            return problemLeadBreakageRepository.findByRotturaId(id);
        }
        else throw new ResourceNotFoundException("Breakage with " + id + " was not caused by any problem.");
    }

    public Integer addNewProblemLeadBreakage(NewProblemLeadBreakage request) {
        ProblemLeadBreakage problemLeadBreakage = new ProblemLeadBreakage();
        problemLeadBreakage.setRottura(request.rottura());
        problemLeadBreakage.setProblema(request.problema());
        problemLeadBreakage.setDescrizione(request.descrizione());
        problemLeadBreakageRepository.save(problemLeadBreakage);
        return problemLeadBreakage.getId();
    }

    public void modifyProblemLeadBreakage(NewProblemLeadBreakage request, Integer id) {
        ProblemLeadBreakage problemLeadBreakage = problemLeadBreakageRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No resource found")
        );
        problemLeadBreakage.setRottura(request.rottura());
        problemLeadBreakage.setProblema(request.problema());
        problemLeadBreakage.setDescrizione(request.descrizione());
        problemLeadBreakageRepository.save(problemLeadBreakage);
    }
}

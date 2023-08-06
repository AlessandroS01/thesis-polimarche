package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.records.NewBreakageHappen;
import com.example.polimarche_api.repository.BreakageHappenRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BreakageHappenService {
    private final BreakageHappenRepository breakageHappenRepository;

    public BreakageHappenService(BreakageHappenRepository breakageHappenRepository) {
        this.breakageHappenRepository = breakageHappenRepository;
    }

    public List<BreakageHappen> getAllBreakagesHappened() {
        return breakageHappenRepository.findAll();
    }

    public List<BreakageHappen> getAllBreakagesHappenedBySession(Integer id) {
        if (breakageHappenRepository.existsBySessioneId(id)){
            return breakageHappenRepository.findBySessioneId(id);
        }
        else throw new ResourceNotFoundException("No breakage happened during session " + id);
    }

    public List<BreakageHappen> getAllBreakagesHappenedByBreakage(Integer id) {
        if (breakageHappenRepository.existsByRotturaId(id)){
            return breakageHappenRepository.findByRotturaId(id);
        }
        else throw new ResourceNotFoundException("No breakage happened for breakage " + id);
    }

    public List<BreakageHappen> getAllBreakagesHappenedForDriverFault() {
        return breakageHappenRepository.findBreakageHappensByColpaPilotaTrue();
    }

    public Integer addBreakageHappened(NewBreakageHappen request) {
        BreakageHappen breakageHappen = new BreakageHappen();
        breakageHappen.setSessione(request.sessione());
        breakageHappen.setRottura(request.rottura());
        breakageHappen.setDescrizione(request.descrizione());
        breakageHappen.setColpa(request.colpa());
        breakageHappenRepository.save(breakageHappen);
        return breakageHappen.getId();
    }

    public void modifyBreakageHappened(NewBreakageHappen request, Integer id) {
        BreakageHappen breakageHappen = breakageHappenRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No breakage happened having an id " + id)
        );
        breakageHappen.setColpa(request.colpa());
        breakageHappen.setRottura(request.rottura());
        breakageHappen.setDescrizione(request.descrizione());
        breakageHappen.setSessione(request.sessione());
        breakageHappenRepository.save(breakageHappen);
    }


}

package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.records.NewBreakage;
import com.example.polimarche_api.model.records.NewComment;
import com.example.polimarche_api.repository.BreakageRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BreakageService {
    private final BreakageRepository breakageRepository;

    public BreakageService(BreakageRepository breakageRepository) {
        this.breakageRepository = breakageRepository;
    }

    public List<Breakage> getAllBreakages() {
        return breakageRepository.findAll();
    }

    public Integer addBreakage(NewBreakage request) {
        Breakage breakage = new Breakage();
        breakage.setDescrizione(request.descrizione());
        breakageRepository.save(breakage);
        return breakage.getId();
    }

    public void modifyBreakage(NewBreakage request, Integer id) {
        Breakage breakage = breakageRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No breakage with id " + id)
                );
        breakage.setDescrizione(request.descrizione());
        breakageRepository.save(breakage);
    }
}

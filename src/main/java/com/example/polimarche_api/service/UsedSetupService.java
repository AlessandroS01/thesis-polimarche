package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.UsedSetup;
import com.example.polimarche_api.model.records.NewUsedSetup;
import com.example.polimarche_api.repository.UsedSetupRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsedSetupService {

    private final UsedSetupRepository usedSetupRepository;

    public UsedSetupService(UsedSetupRepository usedSetupRepository) {
        this.usedSetupRepository = usedSetupRepository;
    }

    public List<UsedSetup> getAllUsedSetups() {
        return usedSetupRepository.findAll();
    }

    public List<UsedSetup> getAllUsedSetupsBySession(Integer id) {
        return usedSetupRepository.findUsedSetupBySessioneId(id);
    }

    public List<UsedSetup> getAllSessionsBySetup(Integer id) {
        return usedSetupRepository.findUsedSetupBySetupId(id);
    }

    public Integer addUsedSetup(NewUsedSetup request) {
        UsedSetup usedSetup = new UsedSetup();
        usedSetup.setSessione(request.sessione());
        usedSetup.setSetup(request.setup());
        usedSetup.setCommento(request.commento());
        usedSetupRepository.save(usedSetup);
        return usedSetup.getId();
    }


    public void modifyUsedSetup(NewUsedSetup request, Integer id) {
        UsedSetup usedSetup = usedSetupRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No setup used found with id " + id)
        );
        usedSetup.setSessione(request.sessione());
        usedSetup.setSetup(request.setup());
        usedSetup.setCommento(request.commento());
        usedSetupRepository.save(usedSetup);
    }
}

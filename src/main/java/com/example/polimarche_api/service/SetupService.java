package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.exception.SetupValuesException;
import com.example.polimarche_api.model.Setup;
import com.example.polimarche_api.model.records.NewSetup;
import com.example.polimarche_api.repository.SetupRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SetupService {

    private final SetupRepository setupRepository;

    public SetupService(SetupRepository setupRepository) {
        this.setupRepository = setupRepository;
    }

    private Optional<Setup> setSetupByRequest(NewSetup request) {
        Optional<Setup> setup = Optional.empty(); // Initialize to an empty Optional
        if (checkRequestInput(request)) {
            setup = Optional.of(new Setup());
            setup.get().setAll(request);
            return setup;
        }
        return setup;
    }

    private boolean checkRequestInput(NewSetup request) {
        boolean correctenessWheel = false;
        boolean correctenessDamper = false;
        boolean correctenessSpring = false;
        boolean correctenessBalance = false;

        if (    request.wheelAntDx().getPosizione().equals("Ant dx") &&
                request.wheelAntSx().getPosizione().equals("Ant sx") &&
                request.wheelPostDx().getPosizione().equals("Post dx") &&
                request.wheelPostSx().getPosizione().equals("Post sx")
            ){
            correctenessWheel = true;
        }

        if (    request.damperAnt().getPosizione().equals("Ant") &&
                request.damperPost().getPosizione().equals("Post")
            ){
            correctenessDamper = true;
        }

        if (    request.springAnt().getPosizione().equals("Ant") &&
                request.springPost().getPosizione().equals("Post")
            ){
            correctenessSpring = true;
        }

        if (    request.balanceAnt().getPosizione().equals("Ant") &&
                request.balancePost().getPosizione().equals("Post") &&
                request.balanceAnt().getFrenata() + request.balancePost().getFrenata() == 100 &&
                request.balanceAnt().getPeso() + request.balancePost().getPeso() == 100
            ){
            correctenessBalance = true;
        }

        return correctenessWheel && correctenessSpring && correctenessDamper && correctenessBalance;
    }

    public List<Setup> getAllSetups() {
        return setupRepository.findAll();
    }

    public Setup getSetupById(Integer id) {
        return setupRepository.findById(id).orElseThrow( () ->
            new ResourceNotFoundException("Setup with id " + id + " not found")
        );
    }

    public Integer addNewSetup(NewSetup request) {
        if (setSetupByRequest(request).isPresent()){
            Setup setup = setSetupByRequest(request).get();
            setupRepository.save(setup);
            return setup.getId();
        }
        else throw new SetupValuesException("Values given cannot create a new setup");
    }

    public void modifySetup(NewSetup request, Integer id) {
        Setup setup = setupRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("Setup with id " + id + " not found")
        );
        if (checkRequestInput(request)) {
            setup.setAll(request);
            setupRepository.save(setup);
        }
        else throw new SetupValuesException("Values given cannot create a new setup");
    }

    public void deleteSetup(Integer id) {
        setupRepository.deleteById(id);
    }
}

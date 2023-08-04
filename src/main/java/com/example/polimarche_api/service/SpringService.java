package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.PositionException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.Spring;
import com.example.polimarche_api.model.records.NewBalance;
import com.example.polimarche_api.model.records.NewSpring;
import com.example.polimarche_api.repository.SpringRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SpringService {

    private final SpringRepository springRepository;

    public SpringService(SpringRepository springRepository) {
        this.springRepository = springRepository;
    }

    public List<Spring> getAllSprings() {
        return springRepository.findAll();
    }

    public List<Spring> getAllSpringsByPosition(String position) {
        if (position.contentEquals("Ant") || position.contentEquals("Post")) {
            return springRepository.findSpringByPosizione(position);
        }
        else throw new PositionException("Position must be \"Ant\" or \"Post\"");
    }

    public Integer addSpring(NewSpring request) {
        Spring spring = new Spring();
        spring.setCodifica(request.codifica());
        spring.setAltezza(request.altezza());
        spring.setPosizione(request.posizione());
        spring.setPosizioneArb(request.posizioneArb());
        spring.setRigidezzaArb(request.rigidezzaArb());
        springRepository.save(spring);
        return spring.getId();
    }

    public void modifySpring(NewSpring request, Integer id) {
        Spring spring = springRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No spring parameters saved with id " + id)
        );
        spring.setCodifica(request.codifica());
        spring.setAltezza(request.altezza());
        spring.setPosizione(request.posizione());
        spring.setPosizioneArb(request.posizioneArb());
        spring.setRigidezzaArb(request.rigidezzaArb());
        springRepository.save(spring);
    }

    public void deleteSpring(Integer id) {
        if (springRepository.existsById(id)) {
            springRepository.deleteById(id);
        }
        else throw new ResourceNotFoundException("No spring's parameters saved with id " + id);
    }
}

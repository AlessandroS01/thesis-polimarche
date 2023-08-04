package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.PositionException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Damper;
import com.example.polimarche_api.model.records.NewDamper;
import com.example.polimarche_api.repository.DamperRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DamperService {

    private final DamperRepository damperRepository;

    public DamperService(DamperRepository damperRepository) {
        this.damperRepository = damperRepository;
    }


    public List<Damper> getAllDampers() {
        return damperRepository.findAll();
    }

    public List<Damper> getAllDampersByPosition(String position) {
        if (position.contentEquals("Ant") || position.contentEquals("Post")) {
            return damperRepository.findDamperByPosizione(position);
        }
        else throw new PositionException("Position must be \"Ant\" or \"Post\"");
    }

    public Integer addDamper(NewDamper request) {
        Damper damper = new Damper();
        damper.setPosizione(request.posizione());
        damper.setLsc(request.lsc());
        damper.setHsc(request.hsc());
        damper.setHsr(request.hsr());
        damper.setLsr(request.lsr());
        damperRepository.save(damper);
        return damper.getId();
    }

    public void modifyDamper(NewDamper request, Integer id) {
        Damper damper = damperRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No damper parameters saved with id " + id)
        );
        damper.setPosizione(request.posizione());
        damper.setLsc(request.lsc());
        damper.setHsc(request.hsc());
        damper.setHsr(request.hsr());
        damper.setLsr(request.lsr());
        damperRepository.save(damper);
    }

    public void deleteDamper(Integer id) {
        if (damperRepository.existsById(id)) {
            damperRepository.deleteById(id);
        }
        else throw new ResourceNotFoundException("No damper's parameters saved with id " + id);
    }
}

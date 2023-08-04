package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.PositionException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Wheel;
import com.example.polimarche_api.model.records.NewWheel;
import com.example.polimarche_api.repository.WheelRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WheelService {

    private final WheelRepository wheelRepository;

    public WheelService(WheelRepository wheelRepository) {
        this.wheelRepository = wheelRepository;
    }

    public List<Wheel> getAllWheels() {
        return wheelRepository.findAll();
    }

    public List<Wheel> getAllWheelsByPosition(String position) {
        if (position.contentEquals("Ant dx") || position.contentEquals("Ant sx") ||
                position.contentEquals("Post dx") || position.contentEquals("Post sx") ){
            return wheelRepository.findWheelByPosizione(position);
        }
        else throw new PositionException("Position must be \"Ant sx\" or \"Ant dx\" or \"Post dx\" or \"Post sx\" ");
    }

    public Integer addWheel(NewWheel request) {
        Wheel wheel = new Wheel();
        wheel.setCodifica(request.codifica());
        wheel.setPosizione(request.posizione());
        wheel.setSuperiore(request.superiore());
        wheel.setFrontale(request.frontale());
        wheel.setPressione(request.pressione());
        wheelRepository.save(wheel);
        return wheel.getId();
    }

    public void modifyWheel(NewWheel request, Integer id) {
        Wheel wheel = wheelRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No wheel parameters saved with id " + id)
        );
        wheel.setCodifica(request.codifica());
        wheel.setPosizione(request.posizione());
        wheel.setSuperiore(request.superiore());
        wheel.setFrontale(request.frontale());
        wheel.setPressione(request.pressione());
        wheelRepository.save(wheel);
    }

    public void deleteWheel(Integer id) {
        if (wheelRepository.existsById(id)) {
            wheelRepository.deleteById(id);
        }
        else throw new ResourceNotFoundException("No wheel's parameters saved with id " + id);
    }
}

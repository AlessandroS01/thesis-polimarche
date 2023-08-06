package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.PositionException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.Wheel;
import com.example.polimarche_api.model.records.NewBalance;
import com.example.polimarche_api.model.records.NewWheel;
import com.example.polimarche_api.repository.BalanceRepository;
import com.example.polimarche_api.repository.WheelRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BalanceService {

    private final BalanceRepository balanceRepository;

    public BalanceService(BalanceRepository balanceRepository) {
        this.balanceRepository = balanceRepository;
    }

    public List<Balance> getAllBalances() {
        return balanceRepository.findAll();
    }

    public List<Balance> getAllBalancesByPosition(String position) {
        if (position.contentEquals("Ant") || position.contentEquals("Post")) {
            return balanceRepository.findBalanceByPosizione(position);
        }
        else throw new PositionException("Position must be \"Ant\" or \"Post\"");
    }

    public Integer addBalance(NewBalance request) {
        Balance balance = new Balance();
        balance.setFrenata(request.frenata());
        balance.setPeso(request.peso());
        balance.setPosizione(request.posizione());
        balanceRepository.save(balance);
        return balance.getId();
    }

    public void modifyBalance(NewBalance request, Integer id) {
        Balance balance = balanceRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No balance parameters saved with id " + id)
        );
        balance.setFrenata(request.frenata());
        balance.setPeso(request.peso());
        balance.setPosizione(request.posizione());
        balanceRepository.save(balance);
    }

    public void deleteBalance(Integer id) {
        if (balanceRepository.existsById(id)) {
            balanceRepository.deleteById(id);
        }
        else throw new ResourceNotFoundException("No balance parameters saved with id " + id);
    }
}

package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.Wheel;
import com.example.polimarche_api.model.records.NewBalance;
import com.example.polimarche_api.model.records.NewWheel;
import com.example.polimarche_api.service.BalanceService;
import com.example.polimarche_api.service.WheelService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/balance")
public class BalanceController {

    private final BalanceService balanceService;

    public BalanceController(BalanceService wheelService) {
        this.balanceService = wheelService;
    }

    @GetMapping
    public List<Balance> getAllBalances(){
        return balanceService.getAllBalances();
    }

    @GetMapping("/position/{position}")
    public List<Balance> getAllBalancesByPosition(@PathVariable String position){
        return balanceService.getAllBalancesByPosition(position);
    }

    @PostMapping
    public ResponseEntity<Integer> addWheel(@RequestBody NewBalance request){
        Integer wheelId = balanceService.addBalance(request);
        return new ResponseEntity<>(wheelId, HttpStatus.CREATED);
    }

    @PutMapping("{id}")
    public ResponseEntity<Integer> modifyBalance(@RequestBody NewBalance request, @PathVariable Integer id){
        balanceService.modifyBalance(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Integer> deleteBalance(@PathVariable Integer id){
        balanceService.deleteBalance(id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


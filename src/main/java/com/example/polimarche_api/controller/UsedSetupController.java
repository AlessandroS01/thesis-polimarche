package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.UsedSetup;
import com.example.polimarche_api.model.records.NewUsedSetup;
import com.example.polimarche_api.service.UsedSetupService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/used-setup")
public class UsedSetupController {

    private final UsedSetupService usedSetupService;

    public UsedSetupController(UsedSetupService usedSetupService) {
        this.usedSetupService = usedSetupService;
    }

    @GetMapping
    public List<UsedSetup> getAllUsedSetups(){
        return usedSetupService.getAllUsedSetups();
    }

    @GetMapping("/session/{id}")
    public List<UsedSetup> getAllUsedSetupsBySession(@PathVariable Integer id){
        return usedSetupService.getAllUsedSetupsBySession(id);
    }

    @GetMapping("/setup/{id}")
    public List<UsedSetup> getAllSessionsBySetup(@PathVariable Integer id){
        return usedSetupService.getAllSessionsBySetup(id);
    }

    @PostMapping
    public ResponseEntity<Integer> addUsedSetup(@RequestBody NewUsedSetup request){
        Integer id = usedSetupService.addUsedSetup(request);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyUsedSetup(@RequestBody NewUsedSetup request, @PathVariable Integer id){
        usedSetupService.modifyUsedSetup(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }
}


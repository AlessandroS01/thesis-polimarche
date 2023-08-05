package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Setup;
import com.example.polimarche_api.model.records.NewSetup;
import com.example.polimarche_api.service.SetupService;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/setup")
public class SetupController {

    private final SetupService setupService;


    public SetupController(SetupService setupService) {
        this.setupService = setupService;
    }

    @GetMapping
    public List<Setup> getAllSetups(){
        return setupService.getAllSetups();
    }

    @GetMapping("/{id}")
    public Setup getSetupById(@PathVariable Integer id){
        return setupService.getSetupById(id);
    }

    @PostMapping
    public ResponseEntity<Integer> addNewSetup(@RequestBody NewSetup request){
        Integer setupId = setupService.addNewSetup(request);
        return new ResponseEntity<>(setupId, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifySetup(@RequestBody NewSetup request, @PathVariable Integer id){
        setupService.modifySetup(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }

    /*
    @DeleteMapping("/{id}")
    public ResponseEntity<Integer> deleteSetup(@PathVariable Integer id){
        setupService.deleteSetup(id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }
     */
}


package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Damper;
import com.example.polimarche_api.model.records.NewDamper;
import com.example.polimarche_api.service.DamperService;
import com.example.polimarche_api.service.DamperService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/damper")
public class DamperController {

    private final DamperService damperService;

    public DamperController(DamperService damperService) {
        this.damperService = damperService;
    }

    @GetMapping
    public List<Damper> getAllDampers(){
        return damperService.getAllDampers();
    }

    @GetMapping("/position/{position}")
    public List<Damper> getAllDampersByPosition(@PathVariable String position){
        return damperService.getAllDampersByPosition(position);
    }

    @PostMapping
    public ResponseEntity<Integer> addWheel(@RequestBody NewDamper request){
        Integer wheelId = damperService.addDamper(request);
        return new ResponseEntity<>(wheelId, HttpStatus.CREATED);
    }

    @PutMapping("{id}")
    public ResponseEntity<Integer> modifyDamper(@RequestBody NewDamper request, @PathVariable Integer id){
        damperService.modifyDamper(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Integer> deleteDamper(@PathVariable Integer id){
        damperService.deleteDamper(id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


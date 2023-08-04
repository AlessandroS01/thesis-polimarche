package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Spring;
import com.example.polimarche_api.model.records.NewSpring;
import com.example.polimarche_api.service.SpringService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/spring")
public class SpringController {

    private final SpringService springService;

    public SpringController(SpringService springService) {
        this.springService = springService;
    }

    @GetMapping
    public List<Spring> getAllSprings(){
        return springService.getAllSprings();
    }

    @GetMapping("/position/{position}")
    public List<Spring> getAllSpringsByPosition(@PathVariable String position){
        return springService.getAllSpringsByPosition(position);
    }

    @PostMapping
    public ResponseEntity<Integer> addWheel(@RequestBody NewSpring request){
        Integer wheelId = springService.addSpring(request);
        return new ResponseEntity<>(wheelId, HttpStatus.CREATED);
    }

    @PutMapping("{id}")
    public ResponseEntity<Integer> modifySpring(@RequestBody NewSpring request, @PathVariable Integer id){
        springService.modifySpring(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Integer> deleteSpring(@PathVariable Integer id){
        springService.deleteSpring(id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


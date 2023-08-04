package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Wheel;
import com.example.polimarche_api.model.records.NewWheel;
import com.example.polimarche_api.service.WheelService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/wheel")
public class WheelController {

    private final WheelService wheelService;

    public WheelController(WheelService wheelService) {
        this.wheelService = wheelService;
    }

    @GetMapping
    public List<Wheel> getAllWheels(){
        return wheelService.getAllWheels();
    }

    @GetMapping("/position/{position}")
    public List<Wheel> getAllWheelsByPosition(@PathVariable String position){
        return wheelService.getAllWheelsByPosition(position);
    }

    @PostMapping
    public ResponseEntity<Integer> addWheel(@RequestBody NewWheel request){
        Integer wheelId = wheelService.addWheel(request);
        return new ResponseEntity<>(wheelId, HttpStatus.CREATED);
    }

    @PutMapping("{id}")
    public ResponseEntity<Integer> modifyWheel(@RequestBody NewWheel request, @PathVariable Integer id){
        wheelService.modifyWheel(request, id);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Integer> deleteWheel(@PathVariable Integer id){
        wheelService.deleteWheel(id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.dto.DriverDTO;
import com.example.polimarche_api.model.records.Login;
import com.example.polimarche_api.model.records.NewBioInfo;
import com.example.polimarche_api.model.records.NewDriver;
import com.example.polimarche_api.model.records.NewMember;
import com.example.polimarche_api.service.DriverService;
import com.example.polimarche_api.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/driver")
public class DriverController {
    private final DriverService driverService;

    public DriverController(DriverService driverService) {
        this.driverService = driverService;
    }

    /**
     *
     * @return list of all the drivers
     */
    @GetMapping
    public List<DriverDTO> getAllDrivers(){
        return driverService.getAllDrivers();
    }

    /**
     *
     * @param matricola represents the matricola of the driver searched
     * @return Driver if matricola param matches with matricola of a driver
     */
    @GetMapping("/{matricola}")
    public DriverDTO getDriverByMatricola(@PathVariable Integer matricola){
        return driverService.getDriverByMatricola(matricola);
    }

    /**
     *
     * @param request specify the attributes of the newest driver
     * @return ResponseEntity containing the matricola of the driver created
     */
    @PostMapping
    public ResponseEntity<Integer> addNewDriver(@RequestBody NewDriver request){
        Integer matricola = driverService.addNewDriver(request);
        return new ResponseEntity<>(matricola, HttpStatus.CREATED);
    }


    @PutMapping("/{matricola}")
    public ResponseEntity<Integer> modifyDriver(@RequestBody NewBioInfo request, @PathVariable Integer matricola){
        driverService.modifyDriver(matricola, request);
        return new ResponseEntity<>(matricola, HttpStatus.ACCEPTED);
    }

    @DeleteMapping("/{matricola}")
    public ResponseEntity<Integer> deleteDriver(@PathVariable Integer matricola){
        driverService.deleteDriver(matricola);
        return new ResponseEntity<>(matricola, HttpStatus.ACCEPTED);
    }



}


package com.example.polimarche_api.controller.sensor_controllers;

import com.example.polimarche_api.model.sensor.*;
import com.example.polimarche_api.model.sensor.dto.*;
import com.example.polimarche_api.service.sensor_service.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/v1/sensors")
public class SensorController {

    private final CurrentService currentService;
    private final LoadService loadService;
    private final PositionService positionService;
    private final PressureService pressureService;
    private final SpeedService speedService;
    private final TemperatureService temperatureService;
    private final VoltageService voltageService;

    public SensorController(CurrentService currentService,
                            LoadService loadService,
                            PositionService positionService,
                            PressureService pressureService,
                            SpeedService speedService,
                            TemperatureService temperatureService,
                            VoltageService voltageService) {
        this.currentService = currentService;
        this.loadService = loadService;
        this.positionService = positionService;
        this.pressureService = pressureService;
        this.speedService = speedService;
        this.temperatureService = temperatureService;
        this.voltageService = voltageService;
    }

    @GetMapping("/current")
    public List<CurrentDTO> getCurrentData(
            @RequestParam(defaultValue = "") Integer sessionId,
            @RequestParam(defaultValue = "") Integer setupId){
        return currentService.getCurrentBySessionAndSetup(sessionId, setupId);
    }
    @GetMapping("/load")
    public List<LoadDTO> getLoadData(
            @RequestParam(defaultValue = "") Integer sessionId,
            @RequestParam(defaultValue = "") Integer setupId){
        return loadService.getLoadBySessionAndSetup(sessionId, setupId);
    }
    @GetMapping("/position")
    public List<PositionDTO> getPositionData(
            @RequestParam(defaultValue = "") Integer sessionId,
            @RequestParam(defaultValue = "") Integer setupId){
        return positionService.getPositionBySessionAndSetup(sessionId, setupId);
    }
    @GetMapping("/pressure")
    public List<PressureDTO> getPressureData(
            @RequestParam(defaultValue = "") Integer sessionId,
            @RequestParam(defaultValue = "") Integer setupId){
        return pressureService.getPressureBySessionAndSetup(sessionId, setupId);
    }
    @GetMapping("/speed")
    public List<SpeedDTO> getSpeedData(
            @RequestParam(defaultValue = "") Integer sessionId,
            @RequestParam(defaultValue = "") Integer setupId){
        return speedService.getSpeedBySessionAndSetup(sessionId, setupId);
    }
    @GetMapping("/temperature")
    public List<TemperatureDTO> getTemperatureData(
            @RequestParam(defaultValue = "") Integer sessionId,
            @RequestParam(defaultValue = "") Integer setupId){
        return temperatureService.getTemperatureBySessionAndSetup(sessionId, setupId);
    }
    @GetMapping("/voltage")
    public List<VoltageDTO> getVoltageData(
            @RequestParam(defaultValue = "") Integer sessionId,
            @RequestParam(defaultValue = "") Integer setupId){
        return voltageService.getVoltageBySessionAndSetup(sessionId, setupId);
    }
}

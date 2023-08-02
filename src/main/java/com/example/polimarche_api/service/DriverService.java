package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.LoginUnauthorizedException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.records.Login;
import com.example.polimarche_api.model.records.NewBioInfo;
import com.example.polimarche_api.model.records.NewDriver;
import com.example.polimarche_api.model.records.NewMember;
import com.example.polimarche_api.repository.DriverRepository;
import com.example.polimarche_api.repository.MemberRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class DriverService {
    private final DriverRepository driverRepository;

    public DriverService(
            DriverRepository driverRepository
    ) {
        this.driverRepository = driverRepository;
    }


    public List<Driver> getAllDrivers() {
        return driverRepository.findAll();
    }

    public Driver getDriverByMatricola(Integer matricola) {
        if (driverRepository.existsByMembroMatricola(matricola)){
            return driverRepository.findByMembroMatricola(matricola);
        }
        else throw new ResourceNotFoundException("Driver with matricola " + matricola + " not found");
    }

    public Integer addNewDriver(NewDriver request) {
        Driver driver = new Driver();
        driver.setMembro(request.membro());
        driver.setPeso(request.peso());
        driver.setAltezza(request.altezza());
        driverRepository.save(driver);
        return driver.getMembro().getMatricola();
    }

    public void deleteDriver(Integer matricola) {
        if (driverRepository.existsByMembroMatricola(matricola)){
            driverRepository.deleteByMembroMatricola(matricola);
        }
        else throw new ResourceNotFoundException("Driver with matricola " + matricola + " not found");
    }

    public void modifyDriver(Integer matricola, NewBioInfo request) {
        if (driverRepository.existsByMembroMatricola(matricola)){
            Driver driver = driverRepository.findByMembroMatricola(matricola);

            driver.setPeso(request.peso());
            driver.setAltezza(request.altezza());

            driverRepository.save(driver);
        }
        else throw new ResourceNotFoundException("Driver with matricola " + matricola + " not found");
    }
}

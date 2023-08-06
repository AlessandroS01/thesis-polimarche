package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.dto.DriverDTO;
import com.example.polimarche_api.model.records.NewBioInfo;
import com.example.polimarche_api.model.records.NewDriver;
import com.example.polimarche_api.repository.BreakageHappenRepository;
import com.example.polimarche_api.repository.DriverRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class DriverServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private DriverRepository driverRepository; // this class is generated without any error
    private DriverService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new DriverService(driverRepository);
    }

    @Test
    void canGetAllDrivers() {
        //when
        underTest.getAllDrivers();

        //then
        verify(driverRepository).findAll();
    }

    @Test
    void canGetDriverByMatricola() {
        // given
        Integer matricola = 1;
        given(driverRepository.existsByMembroMatricola(matricola)).willReturn(true);
        given(driverRepository.findByMembroMatricola(matricola))
                .willReturn(
                        new Driver(
                                1,
                                80.0,
                                173,
                                mock(Member.class)
                        )
                );
        //when
        DriverDTO driverDTO = underTest.getDriverByMatricola(matricola);

        //then
        verify(driverRepository).findByMembroMatricola(matricola);
        assertNotNull(driverDTO);
    }
    @Test
    void canNotGetDriverByMatricola() {
        // given
        Integer matricola = 1;
        given(driverRepository.existsByMembroMatricola(matricola)).willReturn(false);

        //when, then
        assertThatThrownBy(() -> underTest.getDriverByMatricola(matricola))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Driver with matricola " + matricola + " not found");
    }

    @Test
    void canAddNewDriver() {
        //given
        NewDriver request = new NewDriver(
                mock(Member.class),
                80.0,
                180
        );

        //when
        underTest.addNewDriver(request);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Driver> driverArgumentCaptor = ArgumentCaptor.forClass(Driver.class);
        verify(driverRepository).save(driverArgumentCaptor.capture());

        // Get the captured Balance object
        Driver driverSaved = driverArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.peso()).isEqualTo(driverSaved.getPeso());
        assertThat(request.altezza()).isEqualTo(driverSaved.getAltezza());
        assertThat(request.membro()).isEqualTo(driverSaved.getMembro());
    }

    @Test
    void canDeleteDriver() {
        //given
        Integer matricola = 1;
        given(driverRepository.existsByMembroMatricola(matricola)).willReturn(true);

        //when
        underTest.deleteDriver(matricola);

        //then
        verify(driverRepository).deleteByMembroMatricola(matricola);
    }
    @Test
    void canNotDeleteDriver() {
        //given
        Integer matricola = 1;

        //when, then
        assertThatThrownBy(() -> underTest.deleteDriver(matricola))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Driver with matricola " + matricola + " not found");

        verify(driverRepository, never()).deleteByMembroMatricola(matricola);
    }

    @Test
    void canModifyDriver() {
        //given
        Integer matricola = 1;
        given(driverRepository.existsByMembroMatricola(matricola)).willReturn(true);
        given(driverRepository.findByMembroMatricola(matricola))
                .willReturn(
                        new Driver(
                                1,
                                80.0,
                                173,
                                mock(Member.class)
                        )
                );

        NewBioInfo request = mock(NewBioInfo.class);

        //when
        underTest.modifyDriver(matricola, request);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Driver> driverArgumentCaptor = ArgumentCaptor.forClass(Driver.class);
        verify(driverRepository).save(driverArgumentCaptor.capture());

        // Get the captured Balance object
        Driver driverSaved = driverArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.peso()).isEqualTo(driverSaved.getPeso());
        assertThat(request.altezza()).isEqualTo(driverSaved.getAltezza());
    }
    @Test
    void canNotModifyDriver() {
        //given
        Integer matricola = 1;
        NewBioInfo request = mock(NewBioInfo.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyDriver(matricola, request))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Driver with matricola " + matricola + " not found");

    }
}
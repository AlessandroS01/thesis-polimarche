package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ParsingTimeException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.*;
import com.example.polimarche_api.model.records.NewDriverParticipation;
import com.example.polimarche_api.repository.DamperRepository;
import com.example.polimarche_api.repository.DriverRepository;
import com.example.polimarche_api.repository.ParticipationRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ParticipationServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private ParticipationRepository participationRepository; // this class is generated without any error
    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private DriverRepository driverRepository; // this class is generated without any error
    private ParticipationService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new ParticipationService(
                participationRepository,
                driverRepository
        );
    }

    @Test
    void canGetAllParticipation() {
        //when
        underTest.getAllParticipation();

        //then
        verify(participationRepository).findAll();
    }

    @Test
    void canAddNewParticipationWithoutCambioPilota() {
        //given
        Integer matricola = 1;
        given(driverRepository.existsByMembroMatricola(matricola)).willReturn(true);

        Driver driver = mock(Driver.class);
        when(driverRepository.findByMembroMatricola(matricola)).thenReturn(driver);
        Member member = mock(Member.class); // Create a mock Member
        when(driver.getMembro()).thenReturn(member); // Define the behavior of getMembro()
        when(member.getMatricola()).thenReturn(matricola); // Define the behavior of getMatricola()


        PracticeSession session = mock(PracticeSession.class);

        NewDriverParticipation request = new NewDriverParticipation(
                driver,
                session,
                null,
                null
        );

        //when
        underTest.addNewParticipation(request);

        //then
        verify(participationRepository).save(any());
    }
    @Test
    void canAddNewParticipationWithCambioPilota() {
        //given
        Integer matricola = 1;
        given(driverRepository.existsByMembroMatricola(matricola)).willReturn(true);

        Driver driver = mock(Driver.class);
        when(driverRepository.findByMembroMatricola(matricola)).thenReturn(driver);
        Member member = mock(Member.class); // Create a mock Member
        when(driver.getMembro()).thenReturn(member); // Define the behavior of getMembro()
        when(member.getMatricola()).thenReturn(matricola); // Define the behavior of getMatricola()


        PracticeSession session = mock(PracticeSession.class);

        NewDriverParticipation request = new NewDriverParticipation(
                driver,
                session,
                null,
                "00:00:34.129"
        );

        //when
        underTest.addNewParticipation(request);

        //then


        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Participation> participationArgumentCaptor = ArgumentCaptor.forClass(
                Participation.class);
        verify(participationRepository).save(participationArgumentCaptor.capture());

        // Get the captured Balance object
        Participation participationSaved = participationArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.pilota()).isEqualTo(participationSaved.getPilota());
        assertThat(request.sessione()).isEqualTo(participationSaved.getSessione());
        assertThat(request.cambio_pilota()).isEqualTo(participationSaved.getCambio_pilota());
    }
    @Test
    void canNotAddNewParticipationWithCambioPilota() {
        //given
        Integer matricola = 1;
        given(driverRepository.existsByMembroMatricola(matricola)).willReturn(true);

        Driver driver = mock(Driver.class);
        when(driverRepository.findByMembroMatricola(matricola)).thenReturn(driver);
        Member member = mock(Member.class); // Create a mock Member
        when(driver.getMembro()).thenReturn(member); // Define the behavior of getMembro()
        when(member.getMatricola()).thenReturn(matricola); // Define the behavior of getMatricola()


        PracticeSession session = mock(PracticeSession.class);

        NewDriverParticipation request = new NewDriverParticipation(
                driver,
                session,
                null,
                "null"
        );

        //when, then
        assertThatThrownBy(() -> underTest.addNewParticipation(request))
                .isInstanceOf(ParsingTimeException.class)
                .hasMessageContaining("The time inserted cannot be parsed.");

        verify(participationRepository, never()).save(any());
    }
    @Test
    void canNotAddNewParticipation() {
        //given
        Integer matricola = 1;

        Driver driver = mock(Driver.class);
        Member member = mock(Member.class); // Create a mock Member
        when(driver.getMembro()).thenReturn(member); // Define the behavior of getMembro()
        when(member.getMatricola()).thenReturn(matricola); // Define the behavior of getMatricola()


        PracticeSession session = mock(PracticeSession.class);

        NewDriverParticipation request = new NewDriverParticipation(
                driver,
                session,
                null,
                "null"
        );

        //when, then
        assertThatThrownBy(() -> underTest.addNewParticipation(request))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Driver not found");

        verify(participationRepository, never()).save(any());
    }

    @Test
    void canGetParticipationBySession() {
        //given
        Integer sessionId = 1;
        List<Participation> mockList = new ArrayList<Participation>();
        PracticeSession session = mock(PracticeSession.class);
        Member member = mock(Member.class);
        Driver driver = new Driver(
                1,
                80.0,
                180,
                member
        );

        Participation participation = new Participation(
                1,
                driver,
                session,
                2,
                null
        );
        mockList.add(participation);

        given(participationRepository.existsBySessioneId(sessionId)).willReturn(true);
        given(participationRepository.findBySessioneId(sessionId)).willReturn(mockList);

        //when
        underTest.getParticipationBySession(sessionId);

        //then
        verify(participationRepository).findBySessioneId(sessionId);
    }
    @Test
    void canNotGetParticipationBySession() {
        //given
        Integer sessionId = 1;
        List<Participation> mockList = new ArrayList<Participation>();
        PracticeSession session = mock(PracticeSession.class);
        Member member = mock(Member.class);
        Driver driver = new Driver(
                1,
                80.0,
                180,
                member
        );

        Participation participation = new Participation(
                1,
                driver,
                session,
                2,
                null
        );
        mockList.add(participation);


        //when, then
        assertThatThrownBy(() -> underTest.getParticipationBySession(sessionId))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No drivers participated on this session.");

        verify(participationRepository, never()).findBySessioneId(any());
    }

    @Test
    void canGetParticipationByDriverMatricola() {
        //given
        Integer matricola = 1;
        List<Participation> mockList = new ArrayList<Participation>();
        PracticeSession session = mock(PracticeSession.class);
        Member member = mock(Member.class);
        Driver driver = new Driver(
                1,
                80.0,
                180,
                member
        );

        Participation participation = new Participation(
                1,
                driver,
                session,
                2,
                null
        );
        mockList.add(participation);

        given(participationRepository.existsByPilotaMembroMatricola(matricola)).willReturn(true);
        given(participationRepository.findByPilotaMembroMatricola(matricola)).willReturn(mockList);

        //when
        underTest.getParticipationByDriverMatricola(matricola);

        //then
        verify(participationRepository).findByPilotaMembroMatricola(matricola);
    }
    @Test
    void canNotGetParticipationByDriverMatricola() {
        //given
        Integer matricola = 1;
        List<Participation> mockList = new ArrayList<Participation>();
        PracticeSession session = mock(PracticeSession.class);
        Member member = mock(Member.class);
        Driver driver = new Driver(
                1,
                80.0,
                180,
                member
        );

        Participation participation = new Participation(
                1,
                driver,
                session,
                2,
                null
        );
        mockList.add(participation);

        //when, then
        assertThatThrownBy(() -> underTest.getParticipationByDriverMatricola(matricola))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No session joined by the driver.");

        verify(participationRepository, never()).findBySessioneId(any());
    }

    @Test
    void canGetParticipationByDriverMatricolaAndSession() {
        //given
        Integer matricola = 1;
        Integer sessionId = 1;
        List<Participation> mockList = new ArrayList<Participation>();
        PracticeSession session = mock(PracticeSession.class);
        Member member = mock(Member.class);
        Driver driver = new Driver(
                1,
                80.0,
                180,
                member
        );

        Participation participation = new Participation(
                1,
                driver,
                session,
                2,
                null
        );
        mockList.add(participation);

        given(participationRepository.existsBySessioneIdAndPilotaMembroMatricola(sessionId, matricola))
                .willReturn(true);
        given(participationRepository.findBySessioneIdAndPilotaMembroMatricola(sessionId, matricola)).
                willReturn(mockList);

        //when
        underTest.getParticipationByDriverMatricolaAndSession(matricola, sessionId);

        //then
        verify(participationRepository).findBySessioneIdAndPilotaMembroMatricola(sessionId, matricola);
    }
    @Test
    void canNotGetParticipationByDriverMatricolaAndSession() {
        //given
        Integer matricola = 1;
        Integer sessionId = 1;
        List<Participation> mockList = new ArrayList<Participation>();
        PracticeSession session = mock(PracticeSession.class);
        Member member = mock(Member.class);
        Driver driver = new Driver(
                1,
                80.0,
                180,
                member
        );

        Participation participation = new Participation(
                1,
                driver,
                session,
                2,
                null
        );
        mockList.add(participation);


        //when, then
        assertThatThrownBy(() -> underTest.getParticipationByDriverMatricolaAndSession(matricola, sessionId))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining(
                        "The driver with id " + matricola + " did not participate the session " + sessionId
                );

        verify(participationRepository, never()).findBySessioneId(any());
    }

}
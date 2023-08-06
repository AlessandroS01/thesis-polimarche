package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.records.NewBalance;
import com.example.polimarche_api.model.records.NewBreakageHappen;
import com.example.polimarche_api.repository.BalanceRepository;
import com.example.polimarche_api.repository.BreakageHappenRepository;
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
class BreakageHappenServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private BreakageHappenRepository breakageHappenRepository; // this class is generated without any error
    private BreakageHappenService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new BreakageHappenService(breakageHappenRepository);
    }
    @Test
    void canGetAllBreakagesHappened() {
        //when
        underTest.getAllBreakagesHappened();

        //then
        verify(breakageHappenRepository).findAll();
    }

    @Test
    void canGetAllBreakagesHappenedBySession() {
        //given
        Integer sessionId = 1;
        given(breakageHappenRepository.existsBySessioneId(sessionId))
                .willReturn(true);

        //when
        underTest.getAllBreakagesHappenedBySession(sessionId);

        //test
        verify(breakageHappenRepository).findBySessioneId(sessionId);
    }
    @Test
    void canNotGetAllBreakagesHappenedBySession() {
        //given
        Integer sessionId = 1;
        given(breakageHappenRepository.existsBySessioneId(sessionId))
                .willReturn(false);

        //when,test
        assertThatThrownBy(() -> underTest.getAllBreakagesHappenedBySession(sessionId))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No breakage happened during session " + sessionId);
    }

    @Test
    void canGetAllBreakagesHappenedByBreakage() {
        //given
        Integer breakageId = 1;
        given(breakageHappenRepository.existsByRotturaId(breakageId))
                .willReturn(true);

        //when
        underTest.getAllBreakagesHappenedByBreakage(breakageId);

        //test
        verify(breakageHappenRepository).findByRotturaId(breakageId);
    }
    @Test
    void canNotGetAllBreakagesHappenedByBreakage() {
        //given
        Integer breakageId = 1;
        given(breakageHappenRepository.existsByRotturaId(breakageId))
                .willReturn(false);

        //when, test
        assertThatThrownBy(() -> underTest.getAllBreakagesHappenedByBreakage(breakageId))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No breakage happened for breakage " + breakageId);
    }

    @Test
    void canGetAllBreakagesHappenedForDriverFault() {
        //when
        underTest.getAllBreakagesHappenedForDriverFault();

        //test
        verify(breakageHappenRepository).findBreakageHappensByColpaPilotaTrue();
    }

    @Test
    void canAddBreakageHappened() {
        //given
        NewBreakageHappen request = mock(NewBreakageHappen.class);

        //when
        underTest.addBreakageHappened(request);

        // then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<BreakageHappen> breakageHappenArgumentCaptor = ArgumentCaptor.forClass(BreakageHappen.class);
        verify(breakageHappenRepository).save(breakageHappenArgumentCaptor.capture());

        // Get the captured Balance object
        BreakageHappen breakageHappenSaved = breakageHappenArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.rottura()).isEqualTo(breakageHappenSaved.getRottura());
        assertThat(request.sessione()).isEqualTo(breakageHappenSaved.getSessione());
        assertThat(request.descrizione()).isEqualTo(breakageHappenSaved.getDescrizione());
        assertThat(request.colpa()).isEqualTo(breakageHappenSaved.getColpa());
    }

    @Test
    void canModifyBreakageHappened() {
        //given
        Integer id = 1;

        given(breakageHappenRepository.findById(id))
                .willReturn(
                        Optional.of(
                                mock(BreakageHappen.class)
                        )
                );

        NewBreakageHappen request = mock(NewBreakageHappen.class);

        //when
        underTest.modifyBreakageHappened(
                request,
                id
        );

        //then
        ArgumentCaptor<BreakageHappen> breakageHappenArgumentCaptor = ArgumentCaptor.forClass(BreakageHappen.class);
        verify(breakageHappenRepository).save(breakageHappenArgumentCaptor.capture());

        // Get the captured Balance object
        BreakageHappen breakageHappenSaved = breakageHappenArgumentCaptor.getValue();


        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.rottura()).isEqualTo(breakageHappenSaved.getRottura());
        assertThat(request.sessione()).isEqualTo(breakageHappenSaved.getSessione());
        assertThat(request.descrizione()).isEqualTo(breakageHappenSaved.getDescrizione());
        assertThat(request.colpa()).isEqualTo(breakageHappenSaved.getColpa());
    }

    @Test
    void canNotModifyBreakageHappened() {
        //given
        Integer id = 1;

        NewBreakageHappen request = mock(NewBreakageHappen.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyBreakageHappened(request, id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No breakage happened having an id " + id);

        verify(breakageHappenRepository, never()).save(any());
    }


}
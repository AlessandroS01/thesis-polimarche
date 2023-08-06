package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.records.NewBreakage;
import com.example.polimarche_api.repository.BreakageHappenRepository;
import com.example.polimarche_api.repository.BreakageRepository;
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
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BreakageServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private BreakageRepository breakageRepository; // this class is generated without any error
    private BreakageService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new BreakageService(breakageRepository);
    }

    @Test
    void canGetAllBreakages() {
        //when
        underTest.getAllBreakages();

        //then
        verify(breakageRepository).findAll();
    }

    @Test
    void canAddBreakage() {
        //given
        NewBreakage request = mock(NewBreakage.class);

        //when
        underTest.addBreakage(request);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Breakage> breakageArgumentCaptor = ArgumentCaptor.forClass(Breakage.class);
        verify(breakageRepository).save(breakageArgumentCaptor.capture());

        // Get the captured Balance object
        Breakage breakageSaved = breakageArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.descrizione()).isEqualTo(breakageSaved.getDescrizione());
    }

    @Test
    void canModifyBreakage() {
        //given
        Integer id = 1;
        given(breakageRepository.findById(id))
                .willReturn(
                        Optional.of(
                                mock(Breakage.class)
                        )
                );
        NewBreakage request = mock(NewBreakage.class);

        //when
        underTest.modifyBreakage(request, id);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Breakage> breakageArgumentCaptor = ArgumentCaptor.forClass(Breakage.class);
        verify(breakageRepository).save(breakageArgumentCaptor.capture());

        // Get the captured Balance object
        Breakage breakageSaved = breakageArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.descrizione()).isEqualTo(breakageSaved.getDescrizione());
    }

    @Test
    void canNotModifyBreakage() {
        //given
        Integer id = 1;
        NewBreakage request = mock(NewBreakage.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyBreakage(request, id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No breakage with id " + id);

        verify(breakageRepository, never()).save(any());
    }
}
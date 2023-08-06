package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.PositionException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.Damper;
import com.example.polimarche_api.model.records.NewDamper;
import com.example.polimarche_api.repository.BreakageHappenRepository;
import com.example.polimarche_api.repository.DamperRepository;
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
class DamperServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private DamperRepository damperRepository; // this class is generated without any error
    private DamperService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new DamperService(damperRepository);
    }

    @Test
    void canGetAllDampers() {
        //when
        underTest.getAllDampers();

        //then
        verify(damperRepository).findAll();
    }

    @Test
    void canGetAllDampersByAntPosition() {
        //given
        String position = "Ant";

        //when
        underTest.getAllDampersByPosition(position);

        //then
        verify(damperRepository).findDamperByPosizione(position);
    }

    @Test
    void canGetAllDampersByPostPosition() {
        //given
        String position = "Post";

        //when
        underTest.getAllDampersByPosition(position);

        //then
        verify(damperRepository).findDamperByPosizione(position);
    }
    @Test
    void canNotGetAllDampersByPosition() {
        //given
        String position = "Try";

        //when, then
        assertThatThrownBy(() -> underTest.getAllDampersByPosition(position))
                .isInstanceOf(PositionException.class)
                .hasMessageContaining(("Position must be \"Ant\" or \"Post\""));
    }

    @Test
    void addDamper() {
        //given
        NewDamper request = mock(NewDamper.class);

        //when
        underTest.addDamper(request);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Damper> damperArgumentCaptor = ArgumentCaptor.forClass(Damper.class);
        verify(damperRepository).save(damperArgumentCaptor.capture());

        // Get the captured Balance object
        Damper damperSaved = damperArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.posizione()).isEqualTo(damperSaved.getPosizione());
        assertThat(request.hsc()).isEqualTo(damperSaved.getHsc());
        assertThat(request.hsr()).isEqualTo(damperSaved.getHsr());
        assertThat(request.lsc()).isEqualTo(damperSaved.getLsc());
        assertThat(request.lsr()).isEqualTo(damperSaved.getLsr());
    }

    @Test
    void canModifyDamper() {
        //given
        Integer id = 1;
        given(damperRepository.findById(id))
                .willReturn(
                        Optional.of(
                                mock(Damper.class)
                        )
                );

        NewDamper request = mock(NewDamper.class);

        //when
        underTest.modifyDamper(request, id);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Damper> damperArgumentCaptor = ArgumentCaptor.forClass(Damper.class);
        verify(damperRepository).save(damperArgumentCaptor.capture());

        // Get the captured Balance object
        Damper damperSaved = damperArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.posizione()).isEqualTo(damperSaved.getPosizione());
        assertThat(request.hsc()).isEqualTo(damperSaved.getHsc());
        assertThat(request.hsr()).isEqualTo(damperSaved.getHsr());
        assertThat(request.lsc()).isEqualTo(damperSaved.getLsc());
        assertThat(request.lsr()).isEqualTo(damperSaved.getLsr());
    }
    @Test
    void canNotModifyDamper() {
        //given
        Integer id = 1;

        NewDamper request = mock(NewDamper.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyDamper(request, id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining(("No damper parameters saved with id " + id));
    }

    @Test
    void canDeleteDamper() {
        //given
        Integer id = 1;
        given(damperRepository.existsById(id)).willReturn(true);

        //when
        underTest.deleteDamper(id);

        //then
        verify(damperRepository).deleteById(id);
    }
    @Test
    void canNotDeleteDamper() {
        //given
        Integer id = 1;
        given(damperRepository.existsById(id)).willReturn(false);

        //when, then
        assertThatThrownBy(() -> underTest.deleteDamper(id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No damper's parameters saved with id " + id);

        verify(damperRepository, never()).deleteById(any());
    }
}
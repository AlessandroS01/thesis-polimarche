package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.PositionException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.records.NewBalance;
import com.example.polimarche_api.repository.BalanceRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import java.util.Optional;
import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BalanceServiceTest {
    @Mock // simulate the behaviour of a real instance of balanceRepository
    private BalanceRepository balanceRepository; // this class is generated without any error
    private BalanceService underTest;

    @BeforeEach
    void setUp() {
       underTest = new BalanceService(balanceRepository);
    }

    @Test
    void canGetAllBalances() {
        //when
        underTest.getAllBalances();

        //then
        verify(balanceRepository).findAll();
    }

    @Test
    void canGetAllBalancesByPositionGivenAnt() {
        //given
        String position = "Ant";

        //when
        underTest.getAllBalancesByPosition(position);

        //then
        verify(balanceRepository).findBalanceByPosizione(position);
    }

    @Test
    void canGetAllBalancesByPositionGivenPost() {
        //given
        String position = "Post";

        //when
        underTest.getAllBalancesByPosition(position);

        //then
        verify(balanceRepository).findBalanceByPosizione(position);
    }

    @Test
    void canNotGetAllBalancesByPositionGivenPost() {
        //given
        String position = "b";

        //when, then
        assertThatThrownBy(() -> underTest.getAllBalancesByPosition(position))
                .isInstanceOf(PositionException.class)
                .hasMessageContaining("Position must be \"Ant\" or \"Post\"");

        verify(balanceRepository, never()).save(any());
    }

    @Test
    void canAddBalance() {
        // given
        NewBalance balancePassed = mock(NewBalance.class);

        // when
        Integer result = underTest.addBalance(balancePassed);

        // then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Balance> balanceCaptor = ArgumentCaptor.forClass(Balance.class);
        verify(balanceRepository).save(balanceCaptor.capture());

        // Get the captured Balance object
        Balance savedBalance = balanceCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(balancePassed.posizione()).isEqualTo(savedBalance.getPosizione());
        assertThat(balancePassed.peso()).isEqualTo(savedBalance.getPeso());
        assertThat(balancePassed.frenata()).isEqualTo(savedBalance.getFrenata());
    }

    @Test
    void canModifyBalance() {
        //given
        Integer id = 1;
        given(balanceRepository.findById(id))
                .willReturn(
                    Optional.of(
                            mock(Balance.class)
                    )
                );

        NewBalance request = mock(NewBalance.class);

        //when
        underTest.modifyBalance(
                request,
                id
        );

        //then
        ArgumentCaptor<Balance> balanceCaptor = ArgumentCaptor.forClass(Balance.class);
        verify(balanceRepository).save(balanceCaptor.capture());

        // Get the captured Balance object
        Balance savedBalance = balanceCaptor.getValue();


        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.posizione()).isEqualTo(savedBalance.getPosizione());
        assertThat(request.peso()).isEqualTo(savedBalance.getPeso());
        assertThat(request.frenata()).isEqualTo(savedBalance.getFrenata());
    }

    @Test
    void canNotModifyBalance() {
        //given
        Integer id = 1;

        NewBalance request = mock(NewBalance.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyBalance(request, id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No balance parameters saved with id " + id);

        verify(balanceRepository, never()).save(any());
    }

    @Test
    void canDeleteBalance() {
        //given
        Integer id = 1;

        given(balanceRepository.existsById(id)).willReturn(true);

        //when
        underTest.deleteBalance(id);

        // then
        verify(balanceRepository).deleteById(id);
    }

    @Test
    void canNotDeleteBalance() {
        //given
        int id = 1;

        given(balanceRepository.existsById(id)).willReturn(false);

        //when, then
        assertThatThrownBy(() -> underTest.deleteBalance(id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No balance parameters saved with id " + (id));

        verify(balanceRepository, never()).deleteById(any());
    }
}
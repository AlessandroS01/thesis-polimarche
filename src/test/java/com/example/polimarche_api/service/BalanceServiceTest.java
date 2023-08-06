package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.PositionException;
import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.records.NewBalance;
import com.example.polimarche_api.repository.BalanceRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;


import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verify;

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
    }

    @Test
    void canAddBalance() {
        // given
        NewBalance balancePassed = new NewBalance(
                "Ant",
                0.0,
                0.0
        );

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
    @Disabled
    void modifyBalance() {
    }

    @Test
    @Disabled
    void deleteBalance() {
    }
}
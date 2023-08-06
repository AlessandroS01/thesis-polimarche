package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.LoginUnauthorizedException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Workshop;
import com.example.polimarche_api.model.dto.MemberDTO;
import com.example.polimarche_api.model.records.Login;
import com.example.polimarche_api.model.records.NewMember;
import com.example.polimarche_api.repository.BreakageHappenRepository;
import com.example.polimarche_api.repository.MemberRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.configuration.IMockitoConfiguration;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.Date;
import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class MemberServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private MemberRepository memberRepository; // this class is generated without any error
    private MemberService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new MemberService(memberRepository);
    }

    @Test
    void checkValuesManagerRole() {
        //given
        NewMember request = new NewMember(
                12345,
                "mySecretPassword",
                "John",
                "Doe",
                mock(Date.class),
                "john.doe@example.com",
                "1234567890",
                "Manager",
                new Workshop("Aereodinamica")
        );

        //when
        Member member = underTest.checkValues(request);

        //then
        assertNotNull(member);
        assertNull(member.getReparto());
    }
    @Test
    void checkValuesCaporepartoWithNullReparto() {
        //given
        NewMember request = new NewMember(
                12345,
                "mySecretPassword",
                "John",
                "Doe",
                mock(Date.class),
                "john.doe@example.com",
                "1234567890",
                "Caporeparto",
                null
        );

        //when, then
        assertThatThrownBy(() -> underTest.checkValues(request))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("A caporeparto should manage one workshop area");
    }
    @Test
    void checkValuesCaporepartoWithReparto() {
        //given
        NewMember request = new NewMember(
                12345,
                "mySecretPassword",
                "John",
                "Doe",
                mock(Date.class),
                "john.doe@example.com",
                "1234567890",
                "Caporeparto",
                new Workshop("Aereodinamica")
        );

        Member previousCaporeparto = new Member(
                1,
                "Existing",
                "Existing",
                "Existing",
                mock(Date.class),
                "existing@example.com",
                "1",
                "Caporeparto",
                new Workshop("Aereodinamica")
        );
        given(memberRepository.findByRepartoAndRuolo(new Workshop("Aereodinamica"), "Caporeparto"))
                .willReturn(
                    previousCaporeparto
                );

        //when
        Member result = underTest.checkValues(request);

        //then
        assertNotNull(result);
        assertThat(result.getRuolo()).isEqualTo("Caporeparto");
        assertThat(previousCaporeparto.getRuolo()).isEqualTo("Membro");
    }
    @Test
    void checkValuesMembroWithNullReparto() {
        //given
        NewMember request = new NewMember(
                12345,
                "mySecretPassword",
                "John",
                "Doe",
                mock(Date.class),
                "john.doe@example.com",
                "1234567890",
                "Membro",
                null
        );

        //when, then
        assertThatThrownBy(() -> underTest.checkValues(request))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("A membro should be part of one workshop area");
    }
    @Test
    void checkValuesMembroWithReparto() {
        //given
        NewMember request = new NewMember(
                12345,
                "mySecretPassword",
                "John",
                "Doe",
                mock(Date.class),
                "john.doe@example.com",
                "1234567890",
                "Membro",
                new Workshop("Aereodinamica")
        );

        //when,
        Member member = underTest.checkValues(request);

        // then
        assertNotNull(member);
    }

    @Test
    void getAllMembers() {
        //when
        underTest.getAllMembers();

        //then
        verify(memberRepository).findAll();
    }

    @Test
    void canAddNewMember() {
        //given
        NewMember request = mock(NewMember.class);

        //when
        underTest.addNewMember(request);
        
        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Member> memberArgumentCaptor = ArgumentCaptor.forClass(Member.class);
        verify(memberRepository).save(memberArgumentCaptor.capture());

        // Get the captured Balance object
        Member memberSaved = memberArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertNotNull(memberSaved);
        assertThat(request.nome()).isEqualTo(memberSaved.getNome());
        assertThat(request.cognome()).isEqualTo(memberSaved.getCognome());
        assertThat(request.matricola()).isEqualTo(memberSaved.getMatricola());
    }

    @Test
    void canModifyMember() {
        //given
        Integer matricola = 1;
        given(memberRepository.findById(matricola))
                .willReturn(
                        Optional.of(new Member(
                                matricola,
                                "mySecretPassword",
                                "John",
                                "Doe",
                                mock(Date.class),
                                "john.doe@example.com",
                                "1234567890",
                                "Membro",
                                new Workshop("Aereodinamica")
                        ))
                );

        NewMember request = new NewMember(
                matricola,
                "mod",
                "mod",
                "mod",
                mock(Date.class),
                "mod.doe@example.com",
                "123456789",
                "Membro",
                new Workshop("Aereodinamica")
        );

        //when
        underTest.modifyMember(request, matricola);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Member> memberArgumentCaptor = ArgumentCaptor.forClass(Member.class);
        verify(memberRepository).save(memberArgumentCaptor.capture());

        // Get the captured Balance object
        Member memberSaved = memberArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertNotNull(memberSaved);
        assertThat(request.nome()).isEqualTo(memberSaved.getNome());
        assertThat(request.cognome()).isEqualTo(memberSaved.getCognome());
        assertThat(request.matricola()).isEqualTo(memberSaved.getMatricola());
    }
    @Test
    void canNotModifyMember() {
        //given
        Integer matricola = 1;

        NewMember request = mock(NewMember.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyMember(request, matricola))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Member with matricola " + matricola + " not found.");
    }

    @Test
    void canLoginMember() {
        //given
        Login request = new Login(1, "password");
        given(memberRepository.existsByMatricolaAndPassword(request.matricola(), request.password()))
                .willReturn(true);
        given(memberRepository.findByMatricolaAndPassword(request.matricola(), request.password()))
                .willReturn(
                        new Member(
                                request.matricola(),
                                request.password(),
                                "John",
                                "Doe",
                                mock(Date.class),
                                "john.doe@example.com",
                                "1234567890",
                                "Membro",
                                new Workshop("Aereodinamica")
                        )
                );

        //when
        MemberDTO member = underTest.loginMember(request);

        //then
        assertNotNull(member);
        assertThat(member.matricola()).isEqualTo(request.matricola());
    }
    @Test
    void canNotLoginMember() {
        //given
        Login request = new Login(1, "password");

        //when, then
        assertThatThrownBy(() -> underTest.loginMember(request))
                .isInstanceOf(LoginUnauthorizedException.class)
                .hasMessageContaining("No user found.");

    }
}
package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Damper;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.Workshop;
import com.example.polimarche_api.model.dto.NotaDTO;
import com.example.polimarche_api.model.dto.mapper.NotaDTOMapper;
import com.example.polimarche_api.model.records.NewNota;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.repository.NotaRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.awt.*;
import java.sql.Time;
import java.util.List;
import java.sql.Date;
import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.assertThatThrownBy;
import static org.hibernate.internal.util.collections.CollectionHelper.listOf;
import static org.hibernate.internal.util.collections.CollectionHelper.size;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;


@ExtendWith(MockitoExtension.class)
class NotaServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private NotaRepository notaRepository; // this class is generated without any error
    private NotaService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new NotaService(notaRepository);
    }

    @Test
    void recordReader() {
        //given
        NewNota request = mock(NewNota.class);

        //when
        Nota note = underTest.recordReader(request);

        //then
        assertNotNull(note);
        assertThat(request.data()).isEqualTo(note.getData());
        assertThat(request.ora_inizio()).isEqualTo(note.getOra_inizio());
        assertThat(request.ora_fine()).isEqualTo(note.getOra_fine());
        assertThat(request.ora_fine()).isEqualTo(note.getOra_fine());
        assertThat(request.descrizione()).isEqualTo(note.getMembro());
    }

    @Test
    void getAllNotes() {
        //when
        underTest.getAllNotes();

        //then
        verify(notaRepository).findAll();
    }

    @Test
    void canGetNotesByMatricola() throws InstantiationException, IllegalAccessException {
        //given
        Integer matricola = 1;
        given(notaRepository.existsByMembroMatricola(matricola))
                .willReturn(true);
        Nota nota = new Nota(
                10,
                mock(Date.class),
                mock(Time.class),
                mock(Time.class),
                new Member(
                        matricola,
                        "mod",
                        "mod",
                        "mod",
                        mock(Date.class),
                        "mod.doe@example.com",
                        "123456789",
                        "Membro",
                        new Workshop("Aereodinamica")
                ),
                "prova"
        );
        given(notaRepository.findAllByMembroMatricola(matricola))
                .willReturn(
                        listOf(
                                nota
                        )
                );

        //when

        List<NotaDTO> list = underTest.getNotesByMatricola(matricola);

        //then
        verify(notaRepository).findAllByMembroMatricola(matricola);
        assertNotNull(list);
        assertEquals(1, list.size());
    }
    @Test
    void canNotGetNotesByMatricola() {
        //given
        Integer matricola = 1;

        //when, then
        assertThatThrownBy(() -> underTest.getNotesByMatricola(matricola))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No notes found for member: " + matricola);

    }

    @Test
    void canAddNewNote() {
        //given
        NewNota request = mock(NewNota.class);

        //when
        underTest.addNewNote(request);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Nota> notaArgumentCaptor = ArgumentCaptor.forClass(Nota.class);
        verify(notaRepository).save(notaArgumentCaptor.capture());

        // Get the captured Balance object
        Nota nota = notaArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertNotNull(nota);
        assertThat(request.data()).isEqualTo(nota.getData());
        assertThat(request.ora_inizio()).isEqualTo(nota.getOra_inizio());
        assertThat(request.ora_fine()).isEqualTo(nota.getOra_fine());
        assertThat(request.ora_fine()).isEqualTo(nota.getOra_fine());
        assertThat(request.descrizione()).isEqualTo(nota.getMembro());
    }

    @Test
    void canModifyNote() {
        //given
        Integer id = 1;
        given(notaRepository.findById(id))
                .willReturn(
                        Optional.ofNullable(mock(Nota.class))
                );

        NewNota request = mock(NewNota.class);

        //when
        underTest.modifyNote(request, id);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Nota> notaArgumentCaptor = ArgumentCaptor.forClass(Nota.class);
        verify(notaRepository).save(notaArgumentCaptor.capture());

        // Get the captured Balance object
        Nota nota = notaArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertNotNull(nota);
        assertThat(request.data()).isEqualTo(nota.getData());
        assertThat(request.ora_inizio()).isEqualTo(nota.getOra_inizio());
        assertThat(request.ora_fine()).isEqualTo(nota.getOra_fine());
        assertThat(request.ora_fine()).isEqualTo(nota.getOra_fine());
        assertThat(request.descrizione()).isEqualTo(nota.getMembro());
    }
    @Test
    void canNotModifyNote() {
        //given
        Integer id = 1;

        NewNota request = mock(NewNota.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyNote(request, id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Note with id " + id + " not found");
    }

    @Test
    void canDeleteNote() {
        //given
        Integer id = 1;
        given(notaRepository.existsById(id))
                .willReturn(true);

        //when
        underTest.deleteNote(id);

        //then
        verify(notaRepository).deleteById(id);
    }
    @Test
    void canNotDeleteNote() {
        //given
        Integer id = 1;

        //when, then
        assertThatThrownBy(() -> underTest.deleteNote(id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("No note with id " + id);
    }
}
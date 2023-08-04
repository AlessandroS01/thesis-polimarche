package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.dto.NotaDTO;
import com.example.polimarche_api.model.dto.mapper.NotaDTOMapper;
import com.example.polimarche_api.model.records.NewNota;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.repository.NotaRepository;
import com.example.polimarche_api.repository.PracticeSessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class NotaService {
    private final NotaRepository notaRepository;
    private final NotaDTOMapper notaDTOMapper = new NotaDTOMapper();

    @Autowired
    public NotaService(
            NotaRepository notaRepository
    ) {
        this.notaRepository = notaRepository;
    }

    public Nota recordReader(NewNota request){
        Nota note = new Nota();
        note.setData(request.data());
        note.setOra_inizio(request.ora_inizio());
        note.setOra_fine(request.ora_fine());
        note.setMembro(request.membro());
        note.setDescrizione(request.descrizione());
        return note;
    }

    public List<NotaDTO> getAllNotes() {
        return notaRepository.findAll().
                stream().
                map(notaDTOMapper).
                collect(Collectors.toList());
    }

    public List<NotaDTO> getNotesByMatricola(Integer matricola) {
        List<Nota> notes = notaRepository.findAllByMembroMatricola(matricola);
        if(notes.isEmpty()){
            throw new ResourceNotFoundException("No notes found for member: " + matricola);
        }
        return notes.
                stream().
                map(notaDTOMapper).
                collect(Collectors.toList());
    }

    public Integer addNewNote(NewNota request) {
        Nota nota = recordReader(request);
        notaRepository.save(nota);
        return nota.getId();
    }

    public void modifyNote(NewNota request, Integer id) {
        Nota note = notaRepository.findById(id).orElseThrow( () ->
            new ResourceNotFoundException("Note with id " + id + " not found")
        );

        note.setData(request.data());
        note.setOra_inizio(request.ora_inizio());
        note.setOra_fine(request.ora_fine());
        note.setMembro(request.membro());
        note.setDescrizione(request.descrizione());

        notaRepository.save(note);
    }

    public void deleteNote(Integer id) {
        if (notaRepository.existsById(id)) {
            notaRepository.deleteById(id);
        }
        else throw new ResourceNotFoundException("No note with id " + id);
    }
}

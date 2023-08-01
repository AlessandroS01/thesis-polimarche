package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.PracticeSession;
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

@Service
public class NotaService {
    private final NotaRepository notaRepository;

    @Autowired
    public NotaService(
            NotaRepository notaRepository
    ) {
        this.notaRepository = notaRepository;
    }

    public Nota recordReader(NotaRepository.NewNota request){
        Nota note = new Nota();
        note.setData(request.data());
        note.setOra_inizio(request.ora_inizio());
        note.setOra_fine(request.ora_fine());
        note.setMembro(request.membro());
        note.setDescrizione(request.descrizione());
        return note;
    }

    public List<Nota> getAllNotes() {
        return notaRepository.findAll();
    }

    public List<Nota> getNotesByMatricola(Integer matricola) {
        List<Nota> notes = notaRepository.findAllByMembroMatricola(matricola);
        if(notes.isEmpty()){
            throw new ResourceNotFoundException("No notes found for member: " + matricola);
        }
        return notes;
    }

    public Integer addNewNote(NotaRepository.NewNota request) {
        Nota nota = recordReader(request);
        notaRepository.save(nota);
        return nota.getId();
    }

    public void modifyNote(NotaRepository.NewNota request, Integer id) {
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
}

package com.example.polimarche_api.service;

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
        return new Nota(
                request.id(),
                request.data(),
                request.ora_inizio(),
                request.ora_fine(),
                request.membro(),
                request.descrizione()
        );
    }

    public List<Nota> getAllNotes() {
        return notaRepository.findAll();
    }

    public List<Nota> getNotesByMatricola(Integer matricola) {
        return notaRepository.findAllByMembroMatricola(matricola);
    }

    public void addNewNote(NotaRepository.NewNota request) {
        Nota nota = recordReader(request);
        if (notaRepository.existsById(nota.getId())){
            throw new IllegalArgumentException("Nota already exists");
        }

        notaRepository.save(nota);
    }

    public void modifyNote(NotaRepository.NewNota request) {
        Optional<Nota> optional = notaRepository.findById(request.id());
        if(optional.isPresent()){
            Nota nota = optional.get();

            nota.setData(request.data());
            nota.setOra_inizio(request.ora_inizio());
            nota.setOra_fine(request.ora_fine());
            nota.setMembro(request.membro());
            nota.setDescrizione(request.descrizione());

            notaRepository.save(nota);

        }
        else throw new NoSuchElementException("Nota " + request.id() + " doesn't exist.");
    }
}

package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.repository.NotaRepository;
import com.example.polimarche_api.service.MemberService;
import com.example.polimarche_api.service.NotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/nota")
public class NotaController {
    private final NotaService notaService;

    @Autowired
    public NotaController(NotaService notaService) {
        this.notaService = notaService;
    }

    /**
     *
     * @return list of all the members
     */
    @GetMapping
    public List<Nota> getAllNotes(){
        return notaService.getAllNotes();
    }

    /**
     *
     * @param matricola of the member to research his notes
     * @return List of notes for that member
     */
    @GetMapping("/membro/{matricola}")
    public List<Nota> getNotesByMatricola(@PathVariable Integer matricola){
        return notaService.getNotesByMatricola(matricola);
    }

    @PostMapping
    public void addNote(@RequestBody NotaRepository.NewNota request){
        notaService.addNewNote(request);
    }


}


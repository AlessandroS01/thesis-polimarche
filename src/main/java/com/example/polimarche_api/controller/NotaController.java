package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.dto.NotaDTO;
import com.example.polimarche_api.model.records.NewNota;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.repository.NotaRepository;
import com.example.polimarche_api.service.MemberService;
import com.example.polimarche_api.service.NotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/note")
public class NotaController {
    private final NotaService notaService;

    public NotaController(NotaService notaService) {
        this.notaService = notaService;
    }

    /**
     *
     * @return list of all the notes
     */
    @GetMapping
    public List<NotaDTO> getAllNotes(){
        return notaService.getAllNotes();
    }

    /**
     *
     * @param matricola of the member to research his notes
     * @return List of notes for that member
     */
    @GetMapping("/member/{matricola}")
    public List<NotaDTO> getNotesByMatricola(@PathVariable Integer matricola){
        return notaService.getNotesByMatricola(matricola);
    }

    /**
     *
     * @param request contains the new note in json
     * @return the code of the note if created successfully
     */
    @PostMapping
    public ResponseEntity<Integer> addNote(@RequestBody NewNota request){
        Integer note = notaService.addNewNote(request);
        return new ResponseEntity<>(note, HttpStatus.CREATED);
    }

    /**
     *
     * @param request contains the note modified
     * @param id represents the id of the note
     * @return the id of the note if modified correctly
     */
    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyNote(@RequestBody NewNota request, @PathVariable Integer id){
        notaService.modifyNote(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Integer> deleteNote(@PathVariable Integer id){
        notaService.deleteNote(id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


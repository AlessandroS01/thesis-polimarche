package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.repository.PracticeSessionRepository;
import com.example.polimarche_api.repository.TrackRepository;
import com.example.polimarche_api.service.PracticeSessionService;
import com.example.polimarche_api.service.TrackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/session")
public class PracticeSessionController {
    private final PracticeSessionService practiceSessionService;

    public PracticeSessionController(PracticeSessionService practiceSessionService) {
        this.practiceSessionService = practiceSessionService;
    }

    /**
     *
     * @return a list of all the different Sessions
     */
    @GetMapping
    public List<PracticeSession> getAllSessions(){
        return practiceSessionService.getAll();
    }

    /**
     *
     * @param id represent the id of the session searched
     * @return Session having id equals to the id given
     */
    @GetMapping("/{id}")
    public PracticeSession getSessionById(@PathVariable Integer id){
        return practiceSessionService.getSessionById(id);
    }

    /**
     *
     * @param event represent the event type
     * @return a list of session of the specific event
     */
    @GetMapping("/by-event/{event}")
    public List<PracticeSession> getSessionsByEvent(@PathVariable String event){
        return practiceSessionService.getSessionByEvent(event);
    }

    /**
     *
     * @param request used to create a new record inside PracticeSession
     */
    @PostMapping
    public ResponseEntity<Integer> addSession(@RequestBody PracticeSessionRepository.NewPracticeSession request){
        Integer id = practiceSessionService.addSession(request);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    /**
     *
     * @param request used to modify a record inside PracticeSession
     * @param id used to find the session to modify
     * @return the id of the modified session if successfully modified
     */
    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifySession(
            @RequestBody PracticeSessionRepository.NewPracticeSession request,
            @PathVariable Integer id
    ){
        practiceSessionService.modifySession(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


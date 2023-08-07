package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.dto.ParticipationDTO;
import com.example.polimarche_api.model.records.NewDriverParticipation;
import com.example.polimarche_api.service.ParticipationService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/participation")
public class ParticipationController {
    private final ParticipationService participationService;

    public ParticipationController(ParticipationService participationService) {
        this.participationService = participationService;
    }


    /**
     *
     * @return list of all the participation's drivers who joined a session
     */
    @GetMapping
    public List<ParticipationDTO> getAllParticipation(){
        return participationService.getAllParticipation();
    }

    /**
     *
     * @param session is the id of the session researched
     * @return a list of participation for that session
     */
    @GetMapping("/session/{session}")
    public List<ParticipationDTO> getParticipationBySession(@PathVariable Integer session){
        return participationService.getParticipationBySession(session);
    }

    /**
     *
     * @param matricola is the id of the driver researched
     * @return a list of participation in which the driver tried the car
     */
    @GetMapping("/driver/{matricola}")
    public List<ParticipationDTO> getParticipationByDriverMatricola(@PathVariable Integer matricola){
        return participationService.getParticipationByDriverMatricola(matricola);
    }


    @GetMapping("/driver-session")
    public List<ParticipationDTO> getParticipationByDriverMatricolaAndSession(
            @RequestParam(required = true) Integer matricola,
            @RequestParam(required = true) Integer sessionId
    ){
        return participationService.getParticipationByDriverMatricolaAndSession(matricola, sessionId);
    }

    /**
     *
     * @param request used to create a new Participation
     * @return the id of the participation created
     */
    @PostMapping
    public ResponseEntity<Integer> addNewParticipation(@RequestBody NewDriverParticipation request){
        Integer id = participationService.addNewParticipation(request);
        return new ResponseEntity<>(id, HttpStatus.CREATED);
    }

    /**
     *
     * @param request used to modify an existing participation
     * @param id of the participation
     * @return the id if the participation was successfully modified
     */
    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyParticipation(
            @RequestBody NewDriverParticipation request,
            @PathVariable Integer id
    ){
        participationService.modifyParticipation(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }



}


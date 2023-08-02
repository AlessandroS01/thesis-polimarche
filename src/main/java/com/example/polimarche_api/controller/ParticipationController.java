package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Participation;
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
    public List<Participation> getAllParticipation(){
        return participationService.getAllParticipation();
    }

    /**
     *
     * @param session is the id of the session researched
     * @return a list of participation for that session
     */
    @GetMapping("/session/{session}")
    public List<Participation> getParticipationBySession(@PathVariable Integer session){
        return participationService.getParticipationBySession(session);
    }

    /**
     *
     * @param driver is the id of the driver researched
     * @return a list of participation in which the driver tried the car
     */
    @GetMapping("/driver/{driver}")
    public List<Participation> getParticipationByDriver(@PathVariable Integer driver){
        return participationService.getParticipationByDriver(driver);
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


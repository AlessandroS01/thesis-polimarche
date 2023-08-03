package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Breakage;
import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.records.NewBreakage;
import com.example.polimarche_api.model.records.NewComment;
import com.example.polimarche_api.service.BreakageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/breakage")
public class BreakageController {
    private final BreakageService breakageService;

    public BreakageController(BreakageService breakageService) {
        this.breakageService = breakageService;
    }


    /**
     *
     * @return list of all the breakages
     */
    @GetMapping
    public List<Breakage> getAllBreakages(){
        return breakageService.getAllBreakages();
    }


    /**
     *
     * @param request contains the new breakage in json
     * @return the code of the new breakage if it was successfully created
     */
    @PostMapping
    public ResponseEntity<Integer> addBreakage(@RequestBody NewBreakage request){
        Integer breakageId = breakageService.addBreakage(request);
        return new ResponseEntity<>(breakageId, HttpStatus.CREATED);
    }

    /**
     *
     * @param request
     * @param id
     */
    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyBreakage(
            @RequestBody NewBreakage request,
            @PathVariable Integer id
    ){
        breakageService.modifyBreakage(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


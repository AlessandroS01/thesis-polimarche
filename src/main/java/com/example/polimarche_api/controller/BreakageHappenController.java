package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.records.NewBreakage;
import com.example.polimarche_api.model.records.NewBreakageHappen;
import com.example.polimarche_api.service.BreakageHappenService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/breakage-happened")
public class BreakageHappenController {
    private final BreakageHappenService breakageHappenService;

    public BreakageHappenController(BreakageHappenService breakageHappenService) {
        this.breakageHappenService = breakageHappenService;
    }


    /**
     *
     * @return list of all the breakages happened
     */
    @GetMapping
    public List<BreakageHappen> getAllBreakagesHappened(){
        return breakageHappenService.getAllBreakagesHappened();
    }

    @GetMapping("/driver-fault")
    public List<BreakageHappen> getAllBreakagesHappenedForDriverFault(){
        return breakageHappenService.getAllBreakagesHappenedForDriverFault();
    }


    @GetMapping("/session/{id}")
    public List<BreakageHappen> getAllBreakagesHappenedBySession(@PathVariable Integer id){
        return breakageHappenService.getAllBreakagesHappenedBySession(id);
    }

    @GetMapping("/breakage/{id}")
    public List<BreakageHappen> getAllBreakagesHappenedByBreakage(@PathVariable Integer id){
        return breakageHappenService.getAllBreakagesHappenedByBreakage(id);
    }


    /**
     *
     * @param request contains the new breakage happened in json
     * @return the code of the new breakage if it was successfully created
     */
    @PostMapping
    public ResponseEntity<Integer> addBreakageHappened(@RequestBody NewBreakageHappen request){
        Integer breakageHappenedId = breakageHappenService.addBreakageHappened(request);
        return new ResponseEntity<>(breakageHappenedId, HttpStatus.CREATED);
    }

    /**
     *
     * @param request
     * @param id
     */
    @PutMapping("/{id}")
    public ResponseEntity<Integer> modifyBreakageHappened(
            @RequestBody NewBreakageHappen request,
            @PathVariable Integer id
    ){
        breakageHappenService.modifyBreakageHappened(request, id);
        return new ResponseEntity<>(id, HttpStatus.ACCEPTED);
    }


}


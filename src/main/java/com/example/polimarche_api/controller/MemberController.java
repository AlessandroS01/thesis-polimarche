package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.dto.MemberDTO;
import com.example.polimarche_api.model.records.Login;
import com.example.polimarche_api.model.records.NewMember;
import com.example.polimarche_api.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/member")
public class MemberController {
    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    /**
     *
     * @return list of all the members
     */
    @GetMapping
    public List<MemberDTO> getAllMembers(){
        return memberService.getAllMembers();
    }

    @PostMapping("/login")
    public MemberDTO loginMember(@RequestBody Login request){
        return memberService.loginMember(request);
    }

    /**
     *
     * @param request specify the attributes of the newest member
     * @return ResponseEntity containing the matricola of the member created
     */
    @PostMapping
    public ResponseEntity<Integer> addNewMember(@RequestBody NewMember request){
        Integer matricola = memberService.addNewMember(request);
        return new ResponseEntity<>(matricola, HttpStatus.CREATED);
    }

    /**
     *
     * @param request
     * @return a response containing a String indicating if the modification was successfully or not
     */
    @PutMapping("/{matricola}")
    public ResponseEntity<Integer> modifyMember(
            @RequestBody NewMember request,
            @PathVariable Integer matricola
    ){
        memberService.modifyMember(request, matricola);
        return new ResponseEntity<>(matricola, HttpStatus.ACCEPTED);
    }



}


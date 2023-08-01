package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
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
    public List<Member> getAllMembers(){
        return memberService.getAllMembers();
    }

    /**
     *
     * @param request specify the attributes of the newest member
     * @return ResponseEntity containing the matricola of the member created
     */
    @PostMapping
    public ResponseEntity<Integer> addNewMember(@RequestBody MemberRepository.NewMember request){
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
            @RequestBody MemberRepository.NewMember request,
            @PathVariable Integer matricola
    ){
        memberService.modifyMember(request, matricola);
        return new ResponseEntity<>(matricola, HttpStatus.ACCEPTED);
    }

/*
    @PostMapping("/change-password/{matricola}")
    public ResponseEntity<String> changePassword( @PathVariable String matricola ){
    }
 */

}


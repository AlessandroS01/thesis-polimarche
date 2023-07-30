package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/member")
public class MemberController {
    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    /**
     *
     * @return list of all the members
     */
    @GetMapping
    public List<Member> getAllAreas(){
        return memberService.getAllMembers();
    }

    /**
     *
     * @param request
     * @return a response containing a String indicating if the add was successfully or not
     */
    @PostMapping
    public ResponseEntity<String> addNewMember(@RequestBody MemberRepository.NewMember request){
        return memberService.addNewMember(request);
    }

    /**
     *
     * @param request
     * @return a response containing a String indicating if the modification was successfully or not
     */
    @PutMapping
    public ResponseEntity<String> modifyMember(@RequestBody MemberRepository.NewMember request){
        return memberService.modifyMember(request);
    }

}


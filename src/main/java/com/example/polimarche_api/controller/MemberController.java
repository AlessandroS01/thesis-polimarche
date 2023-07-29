package com.example.polimarche_api.controller;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Workshop;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.repository.PracticeSessionRepository;
import com.example.polimarche_api.service.MemberService;
import com.example.polimarche_api.service.WorkshopService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping
    public List<Member> getAllAreas(){
        return memberService.getAllMembers();
    }

    @PostMapping
    public void addNewMember(@RequestBody MemberRepository.NewMember request){
        memberService.addNewMember(request);
    }

}


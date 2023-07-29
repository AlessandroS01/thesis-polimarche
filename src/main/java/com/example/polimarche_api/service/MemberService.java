package com.example.polimarche_api.service;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Workshop;
import com.example.polimarche_api.repository.MemberRepository;
import com.example.polimarche_api.repository.PracticeSessionRepository;
import com.example.polimarche_api.repository.WorkshopRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class MemberService {
    private final MemberRepository memberRepository;

    @Autowired
    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    public Member recordReader(MemberRepository.NewMember request){
        return new Member(
                request.matricola(),
                request.password(),
                request.nome(),
                request.cognome(),
                request.data_di_nascita(),
                request.email(),
                request.numero_telefono(),
                request.ruolo(),
                request.reparto()
        );
    }

    public List<Member> getAllMembers() {
        return memberRepository.findAll();
    }

    public void addNewMember(MemberRepository.NewMember request) {
        Member member = recordReader(request);

        if (memberRepository.existsById(member.getMatricola())){
            throw new IllegalArgumentException("Member already exists");
        }
        // check if the new member is enrolled as a Manager without a workshop area
        if (Objects.equals(member.getRuolo(), "Manager") && member.getReparto() != null){
            throw new IllegalArgumentException("A manager can't be part of a workshop area");
        }
        // check if the new member is enrolled as a Caporeparto without a workshop area
        if (Objects.equals(member.getRuolo(), "Caporeparto") && member.getReparto() == null){
            throw new IllegalArgumentException("A caporeparto should manage one workshop area");
        }
        // check if the new member is enrolled as a Caporeparto with a workshop area
        if (Objects.equals(member.getRuolo(), "Caporeparto") && member.getReparto() != null){
            // find the previous Caporeparto of the workshop area
            Optional<Member> optional = Optional.ofNullable(memberRepository.findByRepartoAndRuolo(
                    member.getReparto(), "Caporeparto"
            ));
            // change the role of the previous Caporeparto to Membro
            if(optional.isPresent()){
                Member modifyMember = optional.get();
                modifyMember.setRuolo("Membro");

                memberRepository.save(modifyMember);
            }
        }

        memberRepository.save(member);
    }
}

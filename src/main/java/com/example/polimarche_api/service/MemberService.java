package com.example.polimarche_api.service;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class MemberService {
    private final MemberRepository memberRepository;

    @Autowired
    public MemberService(
            MemberRepository memberRepository
    ) {
        this.memberRepository = memberRepository;
    }

    // check the input values
    public Member checkValues(MemberRepository.NewMember request){
        Member member = new Member();

        if(Objects.equals(request.ruolo(), "Manager")){
            member = new Member(
                    request.matricola(), request.password(), request.nome(), request.cognome(),
                    request.data_di_nascita(), request.email(), request.numero_telefono(), request.ruolo()
            );
        }
        else if(Objects.equals(request.ruolo(), "Caporeparto") && request.reparto().getReparto() == null){
            throw new IllegalArgumentException("A caporeparto should manage one workshop area");
        }
        else if(Objects.equals(request.ruolo(), "Caporeparto") && request.reparto().getReparto() != null){
            System.out.println("We");
            // find the previous Caporeparto of the workshop area
            Optional<Member> optional = Optional.ofNullable(memberRepository.findByRepartoAndRuolo(
                    request.reparto(), "Caporeparto"
            ));
            // change the role of the previous Caporeparto to Membro
            if(optional.isPresent()){
                Member modifyMember = optional.get();
                modifyMember.setRuolo("Membro");

                memberRepository.save(modifyMember);
            }
            member = new Member(
                    request.matricola(), request.password(), request.nome(), request.cognome(),
                    request.data_di_nascita(), request.email(), request.numero_telefono(), request.ruolo(),
                    request.reparto()
            );
        }
        else if(Objects.equals(request.ruolo(), "Membro") && request.reparto().getReparto() == null){
            throw new IllegalArgumentException("A membro should be part of one workshop area");
        }
        else {
            member = new Member(
                    request.matricola(), request.password(), request.nome(), request.cognome(),
                    request.data_di_nascita(), request.email(), request.numero_telefono(), request.ruolo(),
                    request.reparto()
            );
        }
        return member;
    }

    public List<Member> getAllMembers() {
        return memberRepository.findAll();
    }

    public ResponseEntity<String> addNewMember(MemberRepository.NewMember request) {

        // check if the member already exists
        if (memberRepository.existsById(request.matricola())) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("A member with this matricola already exists.");
        }

        Member member = checkValues(request);

        memberRepository.save(member);
        return ResponseEntity.status(HttpStatus.ACCEPTED)
                .body("User created");
    }

    public ResponseEntity<String> modifyMember(MemberRepository.NewMember request) {

        // check if the member exists
        if (!memberRepository.existsById(request.matricola())) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("A member with this matricola doesn't exist.");
        }
        Member member = checkValues(request);

        memberRepository.save(member);
        return ResponseEntity.status(HttpStatus.ACCEPTED)
                .body("User modified");

    }
}

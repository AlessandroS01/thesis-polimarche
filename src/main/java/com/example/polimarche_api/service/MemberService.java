package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.LoginUnauthorizedException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.dto.MemberDTO;
import com.example.polimarche_api.model.dto.mapper.MemberDTOMapper;
import com.example.polimarche_api.model.records.Login;
import com.example.polimarche_api.model.records.NewMember;
import com.example.polimarche_api.repository.MemberRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class MemberService {
    private final MemberRepository memberRepository;
    private final MemberDTOMapper memberDTOMapper = new MemberDTOMapper();

    public MemberService(
            MemberRepository memberRepository
    ) {
        this.memberRepository = memberRepository;
    }

    // Check the input values
    public Member checkValues(NewMember request){
        Member member = new Member();

        // Check if the new member is a Manager => his reparto will be set to null
        if(Objects.equals(request.ruolo(), "Manager")){
            member = new Member(
                    request.matricola(), request.password(), request.nome(), request.cognome(),
                    request.data_di_nascita(), request.email(), request.numero_telefono(), request.ruolo()
            );
        }
        // Check if the new member is a Caporeparto and his reparto is set to null
        else if(Objects.equals(request.ruolo(), "Caporeparto") && request.reparto().getReparto() == null){
            throw new IllegalArgumentException("A caporeparto should manage one workshop area");
        }
        // Check if the new member is a Caporeparto and his reparto is set to null
        else if(Objects.equals(request.ruolo(), "Caporeparto") && request.reparto().getReparto() != null){
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
        // Check if the new member is a Membro and his reparto is set to null
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

    public List<MemberDTO> getAllMembers() {
        return memberRepository.findAll().
                stream()
                .map(memberDTOMapper)
                .collect(Collectors.toList());
    }

    public Integer addNewMember(NewMember request) {
        Member member = checkValues(request);
        memberRepository.save(member);
        return member.getMatricola();
    }

    public void modifyMember(NewMember request, Integer matricola) {

        Member member = memberRepository.findById(matricola).orElseThrow( () ->
                new ResourceNotFoundException("Member with matricola " + matricola + " not found.")
        );
        member = checkValues(request);
        member.setMatricola(matricola);
        memberRepository.save(member);
    }

    public MemberDTO loginMember(Login request) {
        if(memberRepository.findByMatricolaAndPassword(request.matricola(), request.password()).getMatricola() == null){
            throw new LoginUnauthorizedException("No user found.");
        }
        Member member =  memberRepository.findByMatricolaAndPassword(request.matricola(), request.password());
        return memberDTOMapper.apply(member);
    }
}

package com.example.polimarche_api.model.dto.mapper;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.dto.MemberDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class MemberDTOMapper implements Function<Member, MemberDTO> {
    @Override
    public MemberDTO apply(Member member) {
        return new MemberDTO(
                member.getMatricola(),
                member.getNome(),
                member.getCognome(),
                member.getData_di_nascita(),
                member.getEmail(),
                member.getNumero_telefono(),
                member.getRuolo(),
                member.getReparto()
                );
    }
}

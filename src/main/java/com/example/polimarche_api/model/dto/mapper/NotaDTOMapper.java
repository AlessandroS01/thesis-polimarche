package com.example.polimarche_api.model.dto.mapper;

import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.dto.MemberDTO;
import com.example.polimarche_api.model.dto.NotaDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class NotaDTOMapper implements Function<Nota, NotaDTO> {
    @Override
    public NotaDTO apply(Nota nota) {
        Member member = nota.getMembro();
        return new NotaDTO(
                nota.getId(),
                nota.getData(),
                nota.getOra_inizio(),
                nota.getOra_fine(),
                new MemberDTO(
                        member.getMatricola(),
                        member.getNome(),
                        member.getCognome(),
                        member.getData_di_nascita(),
                        member.getEmail(),
                        member.getNumero_telefono(),
                        member.getRuolo(),
                        member.getReparto()
                ),
                nota.getDescrizione()
                );
    }
}

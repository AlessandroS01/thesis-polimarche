package com.example.polimarche_api.model.dto.mapper;

import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.Nota;
import com.example.polimarche_api.model.Participation;
import com.example.polimarche_api.model.dto.DriverDTO;
import com.example.polimarche_api.model.dto.MemberDTO;
import com.example.polimarche_api.model.dto.NotaDTO;
import com.example.polimarche_api.model.dto.ParticipationDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class ParticipationDTOMapper implements Function<Participation, ParticipationDTO> {
    @Override
    public ParticipationDTO apply(Participation participation) {
        Driver driver = participation.getPilota();
        MemberDTO memberDTO = new MemberDTO(
                driver.getMembro().getMatricola(),
                driver.getMembro().getNome(),
                driver.getMembro().getCognome(),
                driver.getMembro().getData_di_nascita(),
                driver.getMembro().getEmail(),
                driver.getMembro().getNumero_telefono(),
                driver.getMembro().getRuolo(),
                driver.getMembro().getReparto()
        );
        return new ParticipationDTO(
                participation.getId(),
                new DriverDTO(
                        memberDTO,
                        driver.getPeso(),
                        driver.getAltezza()
                ),
                participation.getSessione(),
                participation.getOrdine(),
                participation.getCambio_pilota()
        );
    }
}

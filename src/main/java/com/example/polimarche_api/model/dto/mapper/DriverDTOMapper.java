package com.example.polimarche_api.model.dto.mapper;

import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.dto.DriverDTO;
import com.example.polimarche_api.model.dto.MemberDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class DriverDTOMapper implements Function<Driver, DriverDTO> {
    @Override
    public DriverDTO apply(Driver driver) {
        Member member = driver.getMembro();
        return new DriverDTO(
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
                driver.getPeso(),
                driver.getAltezza()
                );
    }
}

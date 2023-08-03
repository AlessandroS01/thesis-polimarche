package com.example.polimarche_api.model.dto;

import com.example.polimarche_api.model.Workshop;

import java.util.Date;

public record MemberDTO(
        Integer matricola,
        String nome,
        String cognome,
        Date data_di_nascita,
        String email,
        String numero_telefono,
        String ruolo,
        Workshop reparto
) {
}

package com.example.polimarche_api.model.dto;

import java.sql.Time;
import java.util.Date;

public record NotaDTO(

        Integer id,
        Date data,
        Time ora_inizio,
        Time ora_fine,
        MemberDTO membro,
        String descrizione
) {
}

package com.example.polimarche_api.model.dto;

import com.example.polimarche_api.model.PracticeSession;

import java.sql.Time;
import java.util.Date;

public record ParticipationDTO(

        Integer id,
        DriverDTO pilota,
        PracticeSession sessione,
        Integer ordine,
        String cambio_pilota
) {
}

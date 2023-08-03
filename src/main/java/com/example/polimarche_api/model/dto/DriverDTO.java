package com.example.polimarche_api.model.dto;

import com.example.polimarche_api.model.Member;
import com.fasterxml.jackson.annotation.JsonProperty;

public record DriverDTO(
        MemberDTO membro,
        Double peso,
        Integer altezza
) {
}

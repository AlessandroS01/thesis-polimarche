package com.example.polimarche_api.model.records;

import com.fasterxml.jackson.annotation.JsonProperty;

public record Login(
        @JsonProperty("matricola") Integer matricola,
        @JsonProperty("password") String password
) {
}

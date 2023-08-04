package com.example.polimarche_api.model.records;


import com.example.polimarche_api.model.Balance;
import com.example.polimarche_api.model.Damper;
import com.example.polimarche_api.model.Spring;
import com.example.polimarche_api.model.Wheel;
import com.fasterxml.jackson.annotation.JsonProperty;

public record NewSetup(
        @JsonProperty("") String ala,
        @JsonProperty("") String note,
        @JsonProperty("") Wheel wheelAntDx,
        @JsonProperty("") Wheel wheelAntSx,
        @JsonProperty("") Wheel wheelPostDx,
        @JsonProperty("") Wheel wheelPostSx,
        @JsonProperty("") Balance balanceAnt,
        @JsonProperty("") Balance balancePost,
        @JsonProperty("") Spring springAnt,
        @JsonProperty("") Spring springPost,
        @JsonProperty("") Damper damperAnt,
        @JsonProperty("") Damper damperPost
) {
}

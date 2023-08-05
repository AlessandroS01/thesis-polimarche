package com.example.polimarche_api.model.sensor.dto.mapper_dto;

import com.example.polimarche_api.model.Driver;
import com.example.polimarche_api.model.Member;
import com.example.polimarche_api.model.dto.DriverDTO;
import com.example.polimarche_api.model.dto.MemberDTO;
import com.example.polimarche_api.model.sensor.Current;
import com.example.polimarche_api.model.sensor.dto.CurrentDTO;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class CurrentDTOMapper implements Function<Current, CurrentDTO> {

    @Override
    public CurrentDTO apply(Current current) {
        return new CurrentDTO(
                current.getSessione().getId(),
                current.getSetup().getId(),
                current.getBpCurrent(),
                current.getLvBattery(),
                current.getWaterPump(),
                current.getCoolingFanSys()
        );
    }
}

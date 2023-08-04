package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ParsingTimeException;
import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.Participation;
import com.example.polimarche_api.model.dto.ParticipationDTO;
import com.example.polimarche_api.model.dto.mapper.ParticipationDTOMapper;
import com.example.polimarche_api.model.records.NewDriverParticipation;
import com.example.polimarche_api.repository.ParticipationRepository;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class ParticipationService {
    private final ParticipationRepository participationRepository;
    private final ParticipationDTOMapper participationDTOMapper = new ParticipationDTOMapper();

    public ParticipationService(ParticipationRepository participationRepository) {
        this.participationRepository = participationRepository;
    }

    public List<ParticipationDTO> getAllParticipation() {
        return participationRepository.findAll().
                stream().
                map(participationDTOMapper).
                collect(Collectors.toList());
    }

    public Integer addNewParticipation(NewDriverParticipation request) {
        Participation participation = new Participation();

        participation.setPilota(request.pilota());
        participation.setSessione(request.sessione());

        // set ordine to the number of record having session id equals to the one put inside the request
        participation.setOrdine(
                participationRepository.countParticipationBySessioneId(
                        request.sessione().getId()
                ) + 1 );


        // check if cambio_pilota is given
        if(request.cambio_pilota() == null){
            participationRepository.save(participation);
        }
        else{
            // tries to parse the time because it is saved as a String
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss[.SSS][.SS][.S]");
            try{
                LocalTime.parse(request.cambio_pilota(), formatter);
            }
            catch (DateTimeParseException e){
                throw new ParsingTimeException("The time inserted cannot be parsed.");
            }

            participation.setCambio_pilota(request.cambio_pilota());

            participationRepository.save(participation);
        }
        return participation.getId();
    }

    public List<ParticipationDTO> getParticipationBySession(Integer sessionId) {
        if (participationRepository.existsBySessioneId(sessionId)){
            return participationRepository.findBySessioneId(sessionId).
                    stream().
                    map(participationDTOMapper).
                    collect(Collectors.toList());
        }
        else throw new ResourceNotFoundException("No drivers participated on this session.");
    }

    public List<ParticipationDTO> getParticipationByDriver(Integer driver) {
        if (participationRepository.existsByPilotaId(driver)){
            return participationRepository.findByPilotaId(driver).
                    stream().
                    map(participationDTOMapper).
                    collect(Collectors.toList());
        }
        else throw new ResourceNotFoundException("No session joined by the driver.");

    }

    public void modifyParticipation(NewDriverParticipation request, Integer id) {
        // check if the participation exists
        Participation participation = participationRepository.findById(id).orElseThrow(() ->
                new ResourceNotFoundException("No participation found.")
        );
        participation.setPilota(request.pilota());

        // decrease the value of ordine in all the different participation's records having the same session of the
        // participation the user wants to modify and ordine greater than the one saved inside
        participationRepository.findBySessioneIdAndOrdineGreaterThan(
                participation.getSessione().getId(),
                participation.getOrdine()
        ).forEach( element -> {
            element.setOrdine( element.getOrdine() - 1 );
            participationRepository.save(element);
        });

        // check if the newest value of ordine is given
        if(request.ordine() != null){

            // increase the value of all participation's records having session id equals to the one written inside the
            // request and ordine greater or equal to the one inserted in the request
            participationRepository.findBySessioneIdAndOrdineGreaterThanEqual(
                    request.sessione().getId(),
                    request.ordine()
            ).forEach( element -> {
                // in case the newest session is equal to the older, only the participation's records having
                // id different from the one written inside the URL will be modified
                if (!Objects.equals(element.getId(), id)){
                    element.setOrdine( element.getOrdine() + 1 );
                    participationRepository.save(element);
                }
            });

            participation.setOrdine(request.ordine());
        }
        else{
            participation.setOrdine(
                    participationRepository.countParticipationBySessioneIdAndIdNot(
                            request.sessione().getId(),
                            id
                    ) + 1
            );
        }

        if(request.cambio_pilota() != null){
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss[.SSS][.SS][.S]");
            try{
                LocalTime.parse(request.cambio_pilota(), formatter);
            }
            catch (DateTimeParseException e){
                throw new ParsingTimeException("The time inserted cannot be parsed.");
            }

            participation.setCambio_pilota(request.cambio_pilota());
        }

        participation.setSessione(request.sessione());
        participation.setId(id);

        participationRepository.save(participation);
    }
}

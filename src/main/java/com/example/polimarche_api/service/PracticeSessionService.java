package com.example.polimarche_api.service;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Track;
import com.example.polimarche_api.repository.PracticeSessionRepository;
import com.example.polimarche_api.repository.TrackRepository;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class PracticeSessionService {

    private final PracticeSessionRepository practiceSessionRepository;

    public PracticeSessionService(PracticeSessionRepository practiceSessionRepository) {
        this.practiceSessionRepository = practiceSessionRepository;
    }

    // read the record created with the parameters sent with the request
    public PracticeSession recordReader(PracticeSessionRepository.NewPracticeSession request){
        return new PracticeSession(
                request.id(),
                request.evento(),
                request.data(),
                request.ora_inizio(),
                request.ora_fine(),
                request.tracciato(),
                request.meteo(),
                request.pressione_atmosferica(),
                request.temperatura_aria(),
                request.temperatura_tracciato(),
                request.condizione_tracciato()
        );
    }

    /**
     *
     * @return list of all practice sessions
     */
    public List<PracticeSession> getAll() {
        return practiceSessionRepository.findAll();
    }


    public void addSession(PracticeSessionRepository.NewPracticeSession request) {
        PracticeSession sessione = recordReader(request);

        practiceSessionRepository.save(sessione);
    }

    public PracticeSession getSessionById(Integer id) {
        Optional<PracticeSession> optional = practiceSessionRepository.findById(id);

        if (optional.isPresent()){
            return optional.get();
        }
        else{
            throw new NoSuchElementException("Session " + id + " doesn't exist.");
        }
    }

    public List<PracticeSession> getSessionByEvent(String event) {
        if (!practiceSessionRepository.findByEvento(event).isEmpty()){
            return practiceSessionRepository.findByEvento(event);
        }
        else{
            throw new NoSuchElementException("No session done for the event " + event);
        }
    }

    public void modifySession(PracticeSessionRepository.NewPracticeSession request) {

        Optional<PracticeSession> optional = practiceSessionRepository.findById(request.id());
        if(optional.isPresent()){
            PracticeSession session = optional.get();

            session.setAll(
                    request.id(),
                    request.evento(),
                    request.data(),
                    request.ora_inizio(),
                    request.ora_fine(),
                    request.tracciato(),
                    request.meteo(),
                    request.pressione_atmosferica(),
                    request.temperatura_aria(),
                    request.temperatura_tracciato(),
                    request.condizione_tracciato()
            );

            practiceSessionRepository.save(session);
        }
        else throw new NoSuchElementException("Session " + request.id() + " doesn't exist.");
    }
}

package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.records.NewPracticeSession;
import com.example.polimarche_api.repository.PracticeSessionRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PracticeSessionService {

    private final PracticeSessionRepository practiceSessionRepository;

    public PracticeSessionService(PracticeSessionRepository practiceSessionRepository) {
        this.practiceSessionRepository = practiceSessionRepository;
    }

    // read the record created with the parameters sent with the request
    public PracticeSession recordReader(NewPracticeSession request){
        PracticeSession session = new PracticeSession();
        session.setAll(
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
        return session;
    }

    /**
     *
     * @return list of all practice sessions
     */
    public List<PracticeSession> getAll() {
        return practiceSessionRepository.findAll();
    }


    public Integer addSession(NewPracticeSession request) {
        PracticeSession session = recordReader(request);
        practiceSessionRepository.save(session);
        return session.getId();
    }

    public PracticeSession getSessionById(Integer id) {
        return practiceSessionRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No session with id " + id + " found.")
        );
    }

    public List<PracticeSession> getSessionByEvent(String event) {
        List<PracticeSession> sessions = practiceSessionRepository.findByEvento(event);
        if (sessions.isEmpty()) {
            throw new ResourceNotFoundException("No session saved for event " + event);
        }
        return sessions;
    }

    public void modifySession(NewPracticeSession request, Integer id) {
        PracticeSession session = practiceSessionRepository.findById(id).orElseThrow( () ->
                new ResourceNotFoundException("No session with id " + id + " found.")
        );

        session.setAll(
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
}

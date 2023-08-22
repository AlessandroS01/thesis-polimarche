import '../model/Session.dart';
import '../model/Track.dart';

class SessionRepository {

  late List<Session> listSessions;

  SessionRepository() {
    listSessions = [
      Session(
          1,
          "Endurance",
          DateTime(2023, 8, 16, 10, 0),
          DateTime(2023, 8, 16, 10, 30),
          DateTime(2023, 8, 16, 11, 30),
          Track("Mugello", 5.12),
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"),
      Session(
          2,
          "Acceleration",
          DateTime(2023, 8, 20, 10, 0),
          DateTime(2023, 8, 20, 10, 30),
          DateTime(2023, 8, 20, 11, 30),
          Track("Monaco", 7.87),
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"),
      Session(
          3,
          "Autocross",
          DateTime(2023, 8, 20, 10, 0),
          DateTime(2023, 8, 20, 10, 30),
          DateTime(2023, 8, 20, 11, 30),
          Track("Imola", 6.42),
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"),
      Session(
          4,
          "Skidpad",
          DateTime(2023, 8, 20, 10, 0),
          DateTime(2023, 8, 20, 10, 30),
          DateTime(2023, 8, 20, 11, 30),
          Track("Imola", 6.42),
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"),
    ];
  }

  void modifySession(Session newSession) {
    Session session =
        listSessions.where((element) => element.id == newSession.id).first;

    session.evento = newSession.evento;
    session.data = newSession.data;
    session.oraInizio = newSession.oraInizio;
    session.oraFine = newSession.oraFine;
    session.tracciato = newSession.tracciato;
    session.condizioneTracciato = newSession.condizioneTracciato;
    session.temperaturaTracciato = newSession.temperaturaTracciato;
    session.meteo = newSession.meteo;
    session.pressioneAtmosferica = newSession.pressioneAtmosferica;
    session.temperaturaAria = newSession.temperaturaAria;
  }

  void addSession(Session newSession) {
    listSessions.add(newSession);
  }
}
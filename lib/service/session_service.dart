import 'package:flutter/src/material/time.dart';
import 'package:polimarche/model/session_model.dart';
import 'package:polimarche/repos/session_repo.dart';
import 'package:polimarche/repos/track_repo.dart';
import '../model/note_model.dart';
import '../model/track_model.dart';
import '../repos/agenda_repo.dart';

class SessionService {
  final SessionRepo _sessionRepo = SessionRepo();

  Future<List<Session>> getSessions() async {
    return await _sessionRepo.getSessions();
  }

  Future<void> addSession(
      String event,
      DateTime newDate,
      TimeOfDay newStartingTime,
      TimeOfDay newEndingTime,
      Track newTrack,
      String meteo,
      String pressioneAtmosferica,
      String temperaturaAria,
      String temperaturaTracciato,
      String condizioneTracciato) async {
    await _sessionRepo.addSession(
        event,
        newDate,
        newStartingTime,
        newEndingTime,
        newTrack,
        meteo,
        pressioneAtmosferica,
        temperaturaAria,
        temperaturaTracciato,
        condizioneTracciato);
  }

  Future<Session> getSessionById(int? uid) async {
    return await _sessionRepo.getSessionsById(uid);
  }

  Future<void> modifySession(
      int? uid,
      String event,
      DateTime newDate,
      TimeOfDay newStartingTime,
      TimeOfDay newEndingTime,
      Track newTrack,
      String meteo,
      String pressioneAtmosferica,
      String temperaturaAria,
      String temperaturaTracciato,
      String condizioneTracciato) async{
    await _sessionRepo.modifySession(
        uid,
        event,
        newDate,
        newStartingTime,
        newEndingTime,
        newTrack,
        meteo,
        pressioneAtmosferica,
        temperaturaAria,
        temperaturaTracciato,
        condizioneTracciato);
  }
}

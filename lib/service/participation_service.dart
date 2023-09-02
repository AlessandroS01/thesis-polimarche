import 'package:flutter/src/material/time.dart';
import 'package:polimarche/repos/participation_repo.dart';
import '../model/note_model.dart';
import '../model/participation_model.dart';
import '../repos/agenda_repo.dart';

class ParticipationService {
  final ParticipationRepo _participationRepo = ParticipationRepo();

  Future<List<Participation>> getParticipationsBySessionId(
      int sessionId) async {
    return await _participationRepo.getParticipationsBySessionId(sessionId);
  }

  Future<void> addNewParticipation(
      String matricola, int sessionId, String cambioPilota) async {
    await _participationRepo.addNewParticipation(matricola, sessionId, cambioPilota);
  }

}

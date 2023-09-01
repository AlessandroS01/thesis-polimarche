import 'package:flutter/src/material/time.dart';
import '../model/note_model.dart';
import '../repos/agenda_repo.dart';

class AgendaService {
  final AgendaRepo _agendaRepo = AgendaRepo();

  Future<List<Note>> getNotesByMemberMatricola(int matricola) async {
    return await _agendaRepo.getNotesByMemberMatricola(matricola);
  }

  Future<void> addNewNote(int matricola, String descrizione, DateTime newDate,
      TimeOfDay oraInizio, TimeOfDay oraFine) async {
    await _agendaRepo.addNewNote(matricola, descrizione, newDate, oraInizio, oraFine);
  }

  Future<void> modifyNote(String? uid, String description, DateTime newDate,
      TimeOfDay oraInizio, TimeOfDay oraFine) async {
    await _agendaRepo.modifyNote(uid, description, newDate, oraInizio, oraFine);
  }

  Future<void> deleteNote(String? uid) async {
    await _agendaRepo.deleteNote(uid);
  }
}

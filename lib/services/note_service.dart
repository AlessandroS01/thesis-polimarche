import 'package:flutter/src/material/time.dart';

import '../model/Member.dart';
import '../model/Note.dart';
import '../model/Workshop.dart';

class NoteService {
  late List<Note> listNotes;

  NoteService()
      : listNotes = [
          Note(
            1,
            DateTime(2023, 8, 15),
            DateTime(2023, 8, 15, 10, 0),
            DateTime(2023, 8, 15, 12, 0),
            Member(2, "Antonio", "AA", DateTime(2001, 10, 10, 0, 0, 0),
                "S1097941@univpm.it", "3927602953", "Manager", Workshop("")),
            'Meeting with clients',
          ),
          Note(
            2,
            DateTime(2023, 8, 18),
            DateTime(2023, 8, 18, 14, 0),
            DateTime(2023, 8, 18, 16, 0),
            Member(
                21,
                "Ponzio",
                "AA",
                DateTime(2001, 10, 10, 0, 0, 0),
                "S1097941@univpm.it",
                "3927602953",
                "Caporeparto",
                Workshop("Battery pack")),
            'Submit project report',
          ),
          Note(
            3,
            DateTime(2023, 8, 20),
            DateTime(2023, 8, 20, 19, 0),
            DateTime(2023, 8, 20, 20, 0),
            Member(
                21,
                "Ponzio",
                "AA",
                DateTime(2001, 10, 10, 0, 0, 0),
                "S1097941@univpm.it",
                "3927602953",
                "Caporeparto",
                Workshop("Battery pack")),
            'Birthday party',
          ),
          Note(
            4,
            DateTime(2023, 8, 20),
            DateTime(2023, 8, 20, 20, 0),
            DateTime(2023, 8, 20, 21, 0),
            Member(
                21,
                "Ponzio",
                "AA",
                DateTime(2001, 10, 10, 0, 0, 0),
                "S1097941@univpm.it",
                "3927602953",
                "Caporeparto",
                Workshop("Battery pack")),
            'Birthday party',
          ),
        ];

  List<Note> getNotesByMemberMatricolaDuringDay(int matricola, DateTime date) {
    return listNotes.where(
      (note) {
        return note.membro.matricola == matricola &&
            note.data.year == date.year &&
            note.data.month == date.month &&
            note.data.day == date.day;
      },
    ).toList();
  }

  void modifyNote(Note note, DateTime newDate, TimeOfDay oraInizio,
      TimeOfDay oraFine, String descrizione) {
    DateTime newOraInizio = DateTime(newDate.year, newDate.month, newDate.day,
        oraInizio.hour, oraInizio.minute);

    DateTime newOraFine = DateTime(
        newDate.year, newDate.month, newDate.day, oraFine.hour, oraFine.minute);

    Note oldNote = listNotes.where((element) => element.id == note.id).first;

    oldNote.data = newDate;
    oldNote.ora_inizio = newOraInizio;
    oldNote.ora_fine = newOraFine;
    oldNote.descrizione = descrizione;

    //TODO FARE L'UPDATE DELLA NOTA
  }

  void deleteNote(Note note) {
    listNotes.removeWhere((element) => note.id == element.id);

    // TODO FARE L'ELIMINAZIONE DELLA NOTA
  }

  void createNote(Member member, DateTime newDate, TimeOfDay oraInizio,
      TimeOfDay oraFine, String descrizione) {
    // TODO FARE LA CREAZIONE DELLA NOTA

    DateTime newOraInizio = DateTime(newDate.year, newDate.month, newDate.day,
        oraInizio.hour, oraInizio.minute);

    DateTime newOraFine = DateTime(
        newDate.year, newDate.month, newDate.day, oraFine.hour, oraFine.minute);

    Note note = new Note(listNotes.last.id + 1, newDate, newOraInizio,
        newOraFine, member, descrizione);

    listNotes.add(note);
  }
}

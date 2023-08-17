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
            Member(2, "Antonio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Manager", Workshop("")),
            'Meeting with clients',
          ),
          Note(
            2,
            DateTime(2023, 8, 18),
            DateTime(2023, 8, 18, 14, 0),
            DateTime(2023, 8, 18, 16, 0),
            Member(21, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
            'Submit project report',
          ),
          Note(
            3,
            DateTime(2023, 8, 20),
            DateTime(2023, 8, 20, 19, 0),
            DateTime(2023, 8, 20, 20, 0),
            Member(21, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
            'Birthday party',
          ),
          Note(
            4,
            DateTime(2023, 8, 20),
            DateTime(2023, 8, 20, 20, 0),
            DateTime(2023, 8, 20, 21, 0),
            Member(21, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
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


}
import 'Member.dart';

class Note {

  final int id;
  final DateTime data;
  final DateTime ora_inizio;
  final DateTime ora_fine;
  final Member membro;
  final String descrizione;

  Note(this.id, this.data, this.ora_inizio, this.ora_fine, this.membro,
      this.descrizione);

}
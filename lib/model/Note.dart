import 'Member.dart';

class Note {

  int id;
  DateTime data;
  DateTime ora_inizio;
  DateTime ora_fine;
  Member membro;
  String descrizione;

  Note(this.id, this.data, this.ora_inizio, this.ora_fine, this.membro,
      this.descrizione);


  Map<String, dynamic> toJsonWithoutId() {
    return {
      'data': data.toIso8601String(),
      'ora_inizio': ora_inizio.toIso8601String(),
      'ora_fine': ora_fine.toIso8601String(),
      'membro': membro.toJson(), // Assuming you have a toJson method in Member class
      'descrizione': descrizione,
    };
  }
}
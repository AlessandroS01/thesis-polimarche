import 'Workshop.dart';

class Member{

  final int matricola;
  final String nome;
  final String cognome;
  final DateTime dob;
  final String email;
  final String telefono;
  final String ruolo;
  final Workshop reparto;

  Member(this.matricola, this.nome, this.cognome, this.dob, this.email,
      this.telefono, this.ruolo, this.reparto);


  Map<String, dynamic> toJson() {
    return {
      'matricola': matricola,
      'nome': nome,
      'cognome': cognome,
      'dob': dob.toIso8601String(),
      'email': email,
      'telefono': telefono,
      'ruolo': ruolo,
      'reparto': reparto.toJson(), // Assuming you have a toJson method in Workshop class
    };
  }

  @override
  String toString() {
    return 'Member('
        'matricola: $matricola,'
        ' nome: $nome,'
        ' cognome: $cognome,'
        ' dob: $dob,'
        ' email: $email,'
        ' telefono: $telefono,'
        ' ruolo: $ruolo,'
        ' reparto: $reparto'
        ')';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          matricola == other.matricola &&
          nome == other.nome &&
          cognome == other.cognome &&
          dob == other.dob &&
          email == other.email &&
          telefono == other.telefono &&
          ruolo == other.ruolo &&
          reparto == other.reparto;

  @override
  int get hashCode =>
      matricola.hashCode ^
      nome.hashCode ^
      cognome.hashCode ^
      dob.hashCode ^
      email.hashCode ^
      telefono.hashCode ^
      ruolo.hashCode ^
      reparto.hashCode;
}
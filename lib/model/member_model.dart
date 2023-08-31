import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/core/firestore/converter_timestamp_datetime.dart';


class Member {
  final int matricola;
  final String nome;
  final String cognome;
  final DateTime dob;
  final String email;
  final int telefono;
  final String ruolo;
  final String? reparto;

  Member({required this.matricola, required this.nome, required this.cognome, required this.dob, required this.email,
      required this.telefono, required this.ruolo, required this.reparto});


  Map<String, dynamic> toMap() {
    return {
      'matricola': this.matricola,
      'nome': this.nome,
      'cognome': this.cognome,
      'dob': this.dob,
      'email': this.email,
      'telefono': this.telefono,
      'ruolo': this.ruolo,
      'reparto': this.reparto,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      matricola: map['matricola'] as int,
      nome: map['nome'] as String,
      cognome: map['cognome'] as String,
      dob: FirestoreTimestampDatetimeConverter.fromTimestamp(map['dob'] as Timestamp),
      email: map['email'] as String,
      telefono: map['telefono'] as int,
      ruolo: map['ruolo'] as String,
      reparto: map['reparto'] as String,
    );
  }

  @override
  String toString() {
    return 'Member(matricola: $matricola, nome: $nome, cognome: $cognome, dob: $dob, '
        'email: $email, telefono: $telefono, ruolo: $ruolo, reparto: $reparto)';
  }
}

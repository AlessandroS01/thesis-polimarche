import 'package:polimarche/model/member_model.dart';

class Driver {
  final Member membro;
  final double peso;
  final int altezza;

  Driver(
      {
      required this.membro,
      required this.peso,
      required this.altezza});

  Map<String, dynamic> toMap() {
    return {
      'membro': this.membro.toMap(),
      'peso': this.peso,
      'altezza': this.altezza,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      membro: Member.fromMap(map['membro'] as Map<String, dynamic>),
      peso: map['peso'] is double ? map['peso'] as double : (map['peso'] as int).toDouble(),
      altezza: map['altezza'] as int,
    );
  }

  @override
  String toString() {
    return 'Driver{membro: $membro, peso: $peso, altezza: $altezza}';
  }
}

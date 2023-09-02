
class Participation {
  int matricolaPilota;
  int sessionId;
  int ordine;
  String cambioPilota;

  Participation(
      {
      required this.matricolaPilota,
      required this.sessionId,
      required this.ordine,
      required this.cambioPilota});

  Map<String, dynamic> toMap() {
    return {
      'matricolaPilota': this.matricolaPilota,
      'sessionId': this.sessionId,
      'ordine': this.ordine,
      'cambioPilota': this.cambioPilota,
    };
  }

  factory Participation.fromMap(Map<String, dynamic> map) {
    return Participation(
      matricolaPilota: map['matricolaPilota'] as int,
      sessionId: map['sessionId'] as int,
      ordine: map['ordine'] as int,
      cambioPilota: map['cambioPilota'] as String,
    );
  }
}

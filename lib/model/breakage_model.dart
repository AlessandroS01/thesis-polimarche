class Breakage {
  String descrizione;
  int sessionId;
  bool colpaPilota;

  Breakage(
      {required this.descrizione,
      required this.sessionId,
      required this.colpaPilota});

  Map<String, dynamic> toMap() {
    return {
      'descrizione': this.descrizione,
      'sessionId': this.sessionId,
      'colpaPilota': this.colpaPilota,
    };
  }

  factory Breakage.fromMap(Map<String, dynamic> map) {
    return Breakage(
      descrizione: map['descrizione'] as String,
      sessionId: map['sessionId'] as int,
      colpaPilota: map['colpaPilota'] as bool,
    );
  }
}

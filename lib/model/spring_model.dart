class Spring {
  final int id;
  final String posizione;
  final String codifica;
  final String posizioneArb;
  final String rigidezzaArb;
  final double altezza;

  Spring({
    required this.id,
    required this.posizione,
    required this.codifica,
    required this.posizioneArb,
    required this.rigidezzaArb,
    required this.altezza,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'posizione': this.posizione,
      'codifica': this.codifica,
      'posizioneArb': this.posizioneArb,
      'rigidezzaArb': this.rigidezzaArb,
      'altezza': this.altezza,
    };
  }

  factory Spring.fromMap(Map<String, dynamic> map) {
    return Spring(
      id: map['id'] as int,
      posizione: map['posizione'] as String,
      codifica: map['codifica'] as String,
      posizioneArb: map['posizioneArb'] as String,
      rigidezzaArb: map['rigidezzaArb'] as String,
      altezza: map['altezza'] is double
          ? map['altezza'] as double
          : (map['altezza'] as int).toDouble(),
    );
  }
}

class Wheel {
  final int id;
  final String codifica;
  final String posizione;
  final String frontale;
  final String superiore;
  final double pressione;

  Wheel({
    required this.id,
    required this.codifica,
    required this.posizione,
    required this.frontale,
    required this.superiore,
    required this.pressione,
  });

  Map<String, dynamic> toMap(int newId) {
    return {
      'id': newId,
      'codifica': this.codifica,
      'posizione': this.posizione,
      'frontale': this.frontale,
      'superiore': this.superiore,
      'pressione': this.pressione,
    };
  }

  factory Wheel.fromMap(Map<String, dynamic> map) {
    return Wheel(
      id: map['id'] as int,
      codifica: map['codifica'] as String,
      posizione: map['posizione'] as String,
      frontale: map['frontale'] as String,
      superiore: map['superiore'] as String,
      pressione: map['pressione'] is double
          ? map['pressione'] as double
          : (map['pressione'] as int).toDouble(),
    );
  }
}

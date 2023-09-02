class Balance {
  final int id;
  final String posizione;
  final double frenata;
  final double peso;

  Balance({
    required this.id,
    required this.posizione,
    required this.frenata,
    required this.peso,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'posizione': this.posizione,
      'frenata': this.frenata,
      'peso': this.peso,
    };
  }

  factory Balance.fromMap(Map<String, dynamic> map) {
    return Balance(
      id: map['id'] as int,
      posizione: map['posizione'] as String,
      frenata: map['frenata'] is double ? map['frenata'] as double : (map['frenata'] as int).toDouble(),
      peso: map['peso'] is double ? map['peso'] as double : (map['peso'] as int).toDouble(),
    );
  }
}

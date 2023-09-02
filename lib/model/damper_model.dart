class Damper {
  final int id;
  final String posizione;
  final double lsr;
  final double hsr;
  final double lsc;
  final double hsc;

  Damper({
    required this.id,
    required this.posizione,
    required this.lsr,
    required this.hsr,
    required this.lsc,
    required this.hsc,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'posizione': this.posizione,
      'lsr': this.lsr,
      'hsr': this.hsr,
      'lsc': this.lsc,
      'hsc': this.hsc,
    };
  }

  factory Damper.fromMap(Map<String, dynamic> map) {
    return Damper(
      id: map['id'] as int,
      posizione: map['posizione'] as String,
      lsr: map['lsr'] is double
          ? map['lsr'] as double
          : (map['lsr'] as int).toDouble(),
      hsr: map['hsr'] is double
          ? map['hsr'] as double
          : (map['hsr'] as int).toDouble(),
      lsc: map['lsc'] is double
          ? map['lsc'] as double
          : (map['lsc'] as int).toDouble(),
      hsc: map['hsc'] is double
          ? map['hsc'] as double
          : (map['hsc'] as int).toDouble(),
    );
  }
}

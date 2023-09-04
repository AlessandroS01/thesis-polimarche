class Speed {
  final int? id;
  final int setupId;
  final int sessionId;
  final double? wheelFR;
  final double? wheelFL;

  Speed({
    required this.id,
    required this.setupId,
    required this.sessionId,
    required this.wheelFR,
    required this.wheelFL,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'sessionId': this.sessionId,
      'wheelFR': this.wheelFR,
      'wheelFL': this.wheelFL,
    };
  }

  factory Speed.fromMap(Map<String, dynamic> map) {
    return Speed(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      sessionId: map['sessionId'] as int,
      wheelFR: map['wheelFR'] is double ? map['wheelFR'] as double : (map['wheelFR'] as int).toDouble(),
      wheelFL: map['wheelFL'] is double ? map['wheelFL'] as double : (map['wheelFL'] as int).toDouble(),
    );
  }
}

class Pressure {
  final int? id;
  final int setupId;
  final int sessionId;
  final double? brakeF;
  final double? brakeR;
  final double? coolant;

  Pressure({
    required this.id,
    required this.setupId,
    required this.sessionId,
    required this.brakeF,
    required this.brakeR,
    required this.coolant,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'sessionId': this.sessionId,
      'brakeF': this.brakeF,
      'brakeR': this.brakeR,
      'coolant': this.coolant,
    };
  }

  factory Pressure.fromMap(Map<String, dynamic> map) {
    return Pressure(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      sessionId: map['sessionId'] as int,
      brakeF: map['brakeF'] is double ? map['brakeF'] as double : (map['brakeF'] as int).toDouble(),
      brakeR: map['brakeR'] is double ? map['brakeR'] as double : (map['brakeR'] as int).toDouble(),
      coolant: map['coolant'] is double ? map['coolant'] as double : (map['coolant'] as int).toDouble(),
    );
  }
}

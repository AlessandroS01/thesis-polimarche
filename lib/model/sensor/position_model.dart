class Position {
  final int? id;
  final int setupId;
  final int sessionId;
  final double? throttle;
  final double? steeringAngle;
  final double? suspensionFR;
  final double? suspensionFL;
  final double? suspensionRR;
  final double? suspensionRL;

  Position({
    required this.id,
    required this.setupId,
    required this.sessionId,
    required this.throttle,
    required this.steeringAngle,
    required this.suspensionFR,
    required this.suspensionFL,
    required this.suspensionRR,
    required this.suspensionRL,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'sessionId': this.sessionId,
      'throttle': this.throttle,
      'steeringAngle': this.steeringAngle,
      'suspensionFR': this.suspensionFR,
      'suspensionFL': this.suspensionFL,
      'suspensionRR': this.suspensionRR,
      'suspensionRL': this.suspensionRL,
    };
  }

  factory Position.fromMap(Map<String, dynamic> map) {
    return Position(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      sessionId: map['sessionId'] as int,
      throttle: map['throttle'] is double ? map['throttle'] as double : (map['throttle'] as int).toDouble(),
      steeringAngle: map['steeringAngle'] is double ? map['steeringAngle'] as double : (map['steeringAngle'] as int).toDouble(),
      suspensionFR: map['suspensionFR'] is double ? map['suspensionFR'] as double : (map['suspensionFR'] as int).toDouble(),
      suspensionFL: map['suspensionFL'] is double ? map['suspensionFL'] as double : (map['suspensionFL'] as int).toDouble(),
      suspensionRR: map['suspensionRR'] is double ? map['suspensionRR'] as double : (map['suspensionRR'] as int).toDouble(),
      suspensionRL: map['suspensionRL'] is double ? map['suspensionRL'] as double : (map['suspensionRL'] as int).toDouble(),
    );
  }
}

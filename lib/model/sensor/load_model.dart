class Load {
  final int? id;
  final int setupId;
  final int sessionId;
  final double? steerTorque;
  final double? pushFR;
  final double? pushFL;
  final double? pushRR;
  final double? pushRL;

  Load({
    required this.id,
    required this.setupId,
    required this.sessionId,
    required this.steerTorque,
    required this.pushFR,
    required this.pushFL,
    required this.pushRR,
    required this.pushRL,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'sessionId': this.sessionId,
      'steerTorque': this.steerTorque,
      'pushFR': this.pushFR,
      'pushFL': this.pushFL,
      'pushRR': this.pushRR,
      'pushRL': this.pushRL,
    };
  }

  factory Load.fromMap(Map<String, dynamic> map) {
    return Load(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      sessionId: map['sessionId'] as int,
      steerTorque: map['steerTorque'] is double ? map['steerTorque'] as double : (map['steerTorque'] as int).toDouble(),
      pushFR: map['pushFR'] is double ? map['pushFR'] as double : (map['pushFR'] as int).toDouble(),
      pushFL: map['pushFL'] is double ? map['pushFL'] as double : (map['pushFL'] as int).toDouble(),
      pushRR: map['pushRR'] is double ? map['pushRR'] as double : (map['pushRR'] as int).toDouble(),
      pushRL: map['pushRL'] is double ? map['pushRL'] as double : (map['pushRL'] as int).toDouble(),
    );
  }
}
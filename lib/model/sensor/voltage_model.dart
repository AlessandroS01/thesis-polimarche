class Voltage {
  final int? id;
  final int setupId;
  final int sessionId;
  final double? lvBattery;
  final double? source24v;
  final double? source5v;

  Voltage({
    required this.id,
    required this.setupId,
    required this.sessionId,
    required this.lvBattery,
    required this.source24v,
    required this.source5v,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'sessionId': this.sessionId,
      'lvBattery': this.lvBattery,
      'source24v': this.source24v,
      'source5v': this.source5v,
    };
  }

  factory Voltage.fromMap(Map<String, dynamic> map) {
    return Voltage(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      sessionId: map['sessionId'] as int,
      lvBattery: map['lvBattery'] is double ? map['lvBattery'] as double : (map['lvBattery'] as int).toDouble(),
      source24v: map['source24v'] is double ? map['source24v'] as double : (map['source24v'] as int).toDouble(),
      source5v: map['source5v'] is double ? map['source5v'] as double : (map['source5v'] as int).toDouble(),
    );
  }
}

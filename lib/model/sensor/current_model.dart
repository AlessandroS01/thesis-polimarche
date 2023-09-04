class Current {
  final int? id;
  final int setupId;
  final int sessionId;
  final double? bpCurrent;
  final double? lvBattery;
  final double? waterPump;
  final double? coolingFanSys;

  Current({
    required this.id,
    required this.setupId,
    required this.sessionId,
    required this.bpCurrent,
    required this.lvBattery,
    required this.waterPump,
    required this.coolingFanSys,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'sessionId': this.sessionId,
      'bpCurrent': this.bpCurrent,
      'lvBattery': this.lvBattery,
      'waterPump': this.waterPump,
      'coolingFanSys': this.coolingFanSys,
    };
  }

  factory Current.fromMap(Map<String, dynamic> map) {
    return Current(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      sessionId: map['sessionId'] as int,
      bpCurrent: map['bpCurrent'] is double ? map['bpCurrent'] as double : (map['bpCurrent'] as int).toDouble(),
      lvBattery: map['lvBattery'] is double ? map['lvBattery'] as double : (map['lvBattery'] as int).toDouble(),
      waterPump: map['waterPump'] is double ? map['waterPump'] as double : (map['waterPump'] as int).toDouble(),
      coolingFanSys: map['coolingFanSys'] is double ? map['coolingFanSys'] as double : (map['coolingFanSys'] as int).toDouble(),
    );
  }
}
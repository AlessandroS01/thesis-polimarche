class Temperature {
  final int? id;
  final int setupId;
  final int sessionId;
  final double? igbt;
  final double? motorOne;
  final double? motorTwo;
  final double? inverter;
  final double? module;
  final double? pdm;
  final double? coolantIn;
  final double? coolantOut;
  final double? mcu;
  final double? vcu;
  final double? air;
  final double? humidity;
  final double? brakeFR;
  final double? brakeFL;
  final double? brakeRR;
  final double? brakeRL;
  final double? tyreFR;
  final double? tyreFL;
  final double? tyreRR;
  final double? tyreRL;

  Temperature({
    required this.id,
    required this.setupId,
    required this.sessionId,
    required this.igbt,
    required this.motorOne,
    required this.motorTwo,
    required this.inverter,
    required this.module,
    required this.pdm,
    required this.coolantIn,
    required this.coolantOut,
    required this.mcu,
    required this.vcu,
    required this.air,
    required this.humidity,
    required this.brakeFR,
    required this.brakeFL,
    required this.brakeRR,
    required this.brakeRL,
    required this.tyreFR,
    required this.tyreFL,
    required this.tyreRR,
    required this.tyreRL,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'sessionId': this.sessionId,
      'igbt': this.igbt,
      'motorOne': this.motorOne,
      'motorTwo': this.motorTwo,
      'inverter': this.inverter,
      'module': this.module,
      'pdm': this.pdm,
      'coolantIn': this.coolantIn,
      'coolantOut': this.coolantOut,
      'mcu': this.mcu,
      'vcu': this.vcu,
      'air': this.air,
      'humidity': this.humidity,
      'brakeFR': this.brakeFR,
      'brakeFL': this.brakeFL,
      'brakeRR': this.brakeRR,
      'brakeRL': this.brakeRL,
      'tyreFR': this.tyreFR,
      'tyreFL': this.tyreFL,
      'tyreRR': this.tyreRR,
      'tyreRL': this.tyreRL,
    };
  }

  factory Temperature.fromMap(Map<String, dynamic> map) {
    return Temperature(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      sessionId: map['sessionId'] as int,
      igbt: map['igbt'] is double ? map['igbt'] as double : (map['igbt'] as int).toDouble(),
      motorOne: map['motorOne'] is double ? map['motorOne'] as double : (map['motorOne'] as int).toDouble(),
      motorTwo: map['motorTwo'] is double ? map['motorTwo'] as double : (map['motorTwo'] as int).toDouble(),
      inverter: map['inverter'] is double ? map['inverter'] as double : (map['inverter'] as int).toDouble(),
      module: map['module'] is double ? map['module'] as double : (map['module'] as int).toDouble(),
      pdm: map['pdm'] is double ? map['pdm'] as double : (map['pdm'] as int).toDouble(),
      coolantIn: map['coolantIn'] is double ? map['coolantIn'] as double : (map['coolantIn'] as int).toDouble(),
      coolantOut: map['coolantOut'] is double ? map['coolantOut'] as double : (map['coolantOut'] as int).toDouble(),
      mcu: map['mcu'] is double ? map['mcu'] as double : (map['mcu'] as int).toDouble(),
      vcu: map['vcu'] is double ? map['vcu'] as double : (map['vcu'] as int).toDouble(),
      air: map['air'] is double ? map['air'] as double : (map['air'] as int).toDouble(),
      humidity: map['humidity'] is double ? map['humidity'] as double : (map['humidity'] as int).toDouble(),
      brakeFR: map['brakeFR'] is double ? map['brakeFR'] as double : (map['brakeFR'] as int).toDouble(),
      brakeFL: map['brakeFL'] is double ? map['brakeFL'] as double : (map['brakeFL'] as int).toDouble(),
      brakeRR: map['brakeRR'] is double ? map['brakeRR'] as double : (map['brakeRR'] as int).toDouble(),
      brakeRL: map['brakeRL'] is double ? map['brakeRL'] as double : (map['brakeRL'] as int).toDouble(),
      tyreFR: map['tyreFR'] is double ? map['tyreFR'] as double : (map['tyreFR'] as int).toDouble(),
      tyreFL: map['tyreFL'] is double ? map['tyreFL'] as double : (map['tyreFL'] as int).toDouble(),
      tyreRR: map['tyreRR'] is double ? map['tyreRR'] as double : (map['tyreRR'] as int).toDouble(),
      tyreRL: map['tyreRL'] is double ? map['tyreRL'] as double : (map['tyreRL'] as int).toDouble(),
    );
  }
}
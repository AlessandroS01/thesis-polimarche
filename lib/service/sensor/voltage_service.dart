import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/repos/sensor/temperature_repo.dart';

import '../../model/sensor/current_model.dart';
import '../../model/sensor/load_model.dart';
import '../../model/sensor/position_model.dart';
import '../../model/sensor/pressure_model.dart';
import '../../model/sensor/temperature_model.dart';
import '../../model/sensor/voltage_model.dart';
import '../../repos/sensor/current_repo.dart';
import '../../repos/sensor/load_repo.dart';
import '../../repos/sensor/position_repo.dart';
import '../../repos/sensor/pressure_repo.dart';
import '../../repos/sensor/voltage_repo.dart';

class VoltageService {
  final VoltageRepo _voltageRepo = VoltageRepo();

  Future<List<Voltage>> getVoltageDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _voltageRepo.getVoltageDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

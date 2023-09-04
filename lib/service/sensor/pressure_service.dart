import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/repos/sensor/temperature_repo.dart';

import '../../model/sensor/current_model.dart';
import '../../model/sensor/load_model.dart';
import '../../model/sensor/position_model.dart';
import '../../model/sensor/pressure_model.dart';
import '../../model/sensor/temperature_model.dart';
import '../../repos/sensor/current_repo.dart';
import '../../repos/sensor/load_repo.dart';
import '../../repos/sensor/position_repo.dart';
import '../../repos/sensor/pressure_repo.dart';

class PressureService {
  final PressureRepo _pressureRepo = PressureRepo();

  Future<List<Pressure>> getPressureDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _pressureRepo.getPressureDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

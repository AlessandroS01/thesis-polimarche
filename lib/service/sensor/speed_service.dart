import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/sensor/speed_model.dart';
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
import '../../repos/sensor/speed_repo.dart';

class SpeedService {
  final SpeedRepo _speedRepo = SpeedRepo();

  Future<List<Speed>> getSpeedDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _speedRepo.getSpeedDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

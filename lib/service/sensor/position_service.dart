import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/repos/sensor/temperature_repo.dart';

import '../../model/sensor/current_model.dart';
import '../../model/sensor/load_model.dart';
import '../../model/sensor/position_model.dart';
import '../../model/sensor/temperature_model.dart';
import '../../repos/sensor/current_repo.dart';
import '../../repos/sensor/load_repo.dart';
import '../../repos/sensor/position_repo.dart';

class PositionService {
  final PositionRepo _positionRepo = PositionRepo();

  Future<List<Position>> getPositionDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _positionRepo.getPositionDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

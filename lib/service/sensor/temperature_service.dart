import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/repos/sensor/temperature_repo.dart';

import '../../model/sensor/temperature_model.dart';

class TemperatureService {
  final TemperatureRepo _temperatureRepo = TemperatureRepo();

  Future<List<Temperature>> getTemperatureDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _temperatureRepo.getTemperatureDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

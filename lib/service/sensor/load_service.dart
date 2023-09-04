import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/repos/sensor/temperature_repo.dart';

import '../../model/sensor/current_model.dart';
import '../../model/sensor/load_model.dart';
import '../../model/sensor/temperature_model.dart';
import '../../repos/sensor/current_repo.dart';
import '../../repos/sensor/load_repo.dart';

class LoadService {
  final LoadRepo _loadRepo = LoadRepo();

  Future<List<Load>> getLoadDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _loadRepo.getLoadDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

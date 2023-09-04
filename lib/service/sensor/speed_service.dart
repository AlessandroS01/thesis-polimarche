import 'package:polimarche/model/sensor/speed_model.dart';

import '../../repos/sensor/speed_repo.dart';

class SpeedService {
  final SpeedRepo _speedRepo = SpeedRepo();

  Future<List<Speed>> getSpeedDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _speedRepo.getSpeedDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

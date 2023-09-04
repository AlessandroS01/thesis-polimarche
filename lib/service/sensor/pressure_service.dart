import '../../model/sensor/pressure_model.dart';
import '../../repos/sensor/pressure_repo.dart';

class PressureService {
  final PressureRepo _pressureRepo = PressureRepo();

  Future<List<Pressure>> getPressureDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _pressureRepo.getPressureDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

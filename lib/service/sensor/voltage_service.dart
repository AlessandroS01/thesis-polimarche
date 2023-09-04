import '../../model/sensor/voltage_model.dart';
import '../../repos/sensor/voltage_repo.dart';

class VoltageService {
  final VoltageRepo _voltageRepo = VoltageRepo();

  Future<List<Voltage>> getVoltageDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _voltageRepo.getVoltageDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

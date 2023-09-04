import '../../model/sensor/current_model.dart';
import '../../repos/sensor/current_repo.dart';

class CurrentService {
  final CurrentRepo _currentRepo = CurrentRepo();

  Future<List<Current>> getCurrentDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _currentRepo.getCurrentDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

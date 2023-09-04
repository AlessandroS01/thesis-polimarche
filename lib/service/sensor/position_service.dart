import '../../model/sensor/position_model.dart';
import '../../repos/sensor/position_repo.dart';

class PositionService {
  final PositionRepo _positionRepo = PositionRepo();

  Future<List<Position>> getPositionDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _positionRepo.getPositionDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

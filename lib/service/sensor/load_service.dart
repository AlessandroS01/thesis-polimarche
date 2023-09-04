import '../../model/sensor/load_model.dart';
import '../../repos/sensor/load_repo.dart';

class LoadService {
  final LoadRepo _loadRepo = LoadRepo();

  Future<List<Load>> getLoadDataBySessionAndSetupId(
      int sessionId, int setupId) async {
    return await _loadRepo.getLoadDataBySessionAndSetupId(
        sessionId, setupId);
  }
}

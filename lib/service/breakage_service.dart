import '../model/breakage_model.dart';
import '../repos/breakage_repo.dart';

class BreakageService {
  final BreakageRepo _breakageRepo = BreakageRepo();

  Future<List<Breakage>> getBreakagesBySessionId(int sessionId) async {
    return await _breakageRepo.getBreakagesBySessionId(sessionId);
  }

  Future<void> addNewBreakage(
      int sessionId, bool colpaPilota, String descrizione) async {
    await _breakageRepo.addNewBreakage(sessionId, colpaPilota, descrizione);
  }
}

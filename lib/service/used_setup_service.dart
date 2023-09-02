import 'package:polimarche/model/used_setup_model.dart';

import '../repos/used_setup_repo.dart';

class UsedSetupService {
  final UsedSetupRepo _usedSetupRepo = UsedSetupRepo();

  Future<List<UsedSetup>> getUsedSetupsBySessionId(int sessionId) async {
    return await _usedSetupRepo.getUsedSetupsBySessionId(sessionId);
  }

  Future<void> addNewUsedSetup(int sessionId, int newSetupUsedId, String newComment) async {
    await _usedSetupRepo.addNewUsedSetup(sessionId, newSetupUsedId, newComment);
  }

}

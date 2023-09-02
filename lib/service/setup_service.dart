import '../model/setup_model.dart';
import '../repos/setup_repo.dart';

class SetupService {
  final SetupRepo _setupRepo = SetupRepo();

  Future<List<Setup>> getSetups() async {
    return await _setupRepo.getSetups();
  }

}

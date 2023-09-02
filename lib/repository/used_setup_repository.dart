import 'package:polimarche/model/used_setup_model.dart';

class UsedSetupRepository {
  late List<UsedSetup> listSetupsUsed;

  UsedSetupRepository() {
    listSetupsUsed = [];


  }

  void addNewUsedSetup(UsedSetup newUsedSetup) {
    listSetupsUsed.add(newUsedSetup);
  }
}

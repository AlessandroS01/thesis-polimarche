import 'package:polimarche/model/UsedSetup.dart';
import '../model/session_model.dart';
import '../model/track_model.dart';
import '../model/Balance.dart';
import '../model/Damper.dart';
import '../model/Setup.dart';
import '../model/Spring.dart';
import '../model/Wheel.dart';

class UsedSetupRepository {
  late List<UsedSetup> listSetupsUsed;

  UsedSetupRepository() {
    listSetupsUsed = [];


  }

  void addNewUsedSetup(UsedSetup newUsedSetup) {
    listSetupsUsed.add(newUsedSetup);
  }
}

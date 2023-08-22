import 'package:polimarche/model/UsedSetup.dart';
import 'package:polimarche/repository/balance_repository.dart';
import 'package:polimarche/repository/damper_repository.dart';
import 'package:polimarche/repository/setup_repository.dart';
import 'package:polimarche/repository/spring_repository.dart';
import 'package:polimarche/repository/used_setup_repository.dart';
import 'package:polimarche/repository/wheel_repository.dart';

import '../model/Setup.dart';

class SetupService {

  late SetupRepository setupRepository;
  late WheelRepository wheelRepository;
  late BalanceRepository balanceRepository;
  late SpringRepository springRepository;
  late DamperRepository damperRepository;

  late UsedSetupRepository usedSetupRepository;

  late List<Setup> listSetups;
  late List<UsedSetup> listUsedSetups;

  SetupService() {
    setupRepository = SetupRepository();
    wheelRepository = WheelRepository();
    balanceRepository = BalanceRepository();
    springRepository = SpringRepository();
    damperRepository = DamperRepository();
    usedSetupRepository = UsedSetupRepository();

    listSetups = setupRepository.listSetups;
    listUsedSetups = usedSetupRepository.listSetupsUsed;
  }

  void updateLists() {
    listSetups = setupRepository.listSetups;
    listUsedSetups = usedSetupRepository.listSetupsUsed;
  }
}

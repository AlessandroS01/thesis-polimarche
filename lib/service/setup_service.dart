import 'package:polimarche/model/balance_model.dart';
import 'package:polimarche/model/damper_model.dart';
import 'package:polimarche/model/spring_model.dart';
import 'package:polimarche/model/wheel_model.dart';

import '../model/setup_model.dart';
import '../repos/setup_repo.dart';

class SetupService {
  final SetupRepo _setupRepo = SetupRepo();

  Future<List<Setup>> getSetups() async {
    return await _setupRepo.getSetups();
  }

  Future<Setup> getSetupById(int setupId) async {
    return await _setupRepo.getSetupById(setupId);
  }

  Future<void> modifySetup(
      int id,
      List<Wheel> wheelsUsed,
      List<Balance> balanceUsed,
      List<Spring> springsUsed,
      List<Damper> dampersUsed,
      List<String> genInfosUsed) async {
    await _setupRepo.modifySetup(
        id, wheelsUsed, balanceUsed, springsUsed, dampersUsed, genInfosUsed);
  }

  Future<void> createSetup(
      List<Wheel> wheelsUsed,
      List<Balance> balanceUsed,
      List<Spring> springsUsed,
      List<Damper> dampersUsed,
      List<String> genInfosUsed) async {
    await _setupRepo.createSetup(
        wheelsUsed, balanceUsed, springsUsed, dampersUsed, genInfosUsed);
  }
}

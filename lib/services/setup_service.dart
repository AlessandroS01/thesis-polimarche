import 'package:polimarche/model/UsedSetup.dart';
import 'package:polimarche/model/Wheel.dart';
import 'package:polimarche/repository/balance_repository.dart';
import 'package:polimarche/repository/damper_repository.dart';
import 'package:polimarche/repository/setup_repository.dart';
import 'package:polimarche/repository/spring_repository.dart';
import 'package:polimarche/repository/used_setup_repository.dart';
import 'package:polimarche/repository/wheel_repository.dart';

import '../model/Balance.dart';
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
  late List<Wheel> listWheels;
  late List<Balance> listBalance;

  SetupService() {
    setupRepository = SetupRepository();
    wheelRepository = WheelRepository();
    balanceRepository = BalanceRepository();
    springRepository = SpringRepository();
    damperRepository = DamperRepository();
    usedSetupRepository = UsedSetupRepository();

    listSetups = setupRepository.listSetups;
    listUsedSetups = usedSetupRepository.listSetupsUsed;
    listWheels = wheelRepository.listWheels;
    listBalance = balanceRepository.listBalances;
  }

  void updateLists() {
    listSetups = setupRepository.listSetups;
    listUsedSetups = usedSetupRepository.listSetupsUsed;
    listWheels = wheelRepository.listWheels;
    listBalance = balanceRepository.listBalances;
  }

  List<Wheel> findFrontRightWheelParams() {
    return listWheels
        .where((element) => element.posizione == "Ant dx")
        .toList();
  }

  List<Wheel> findFrontLeftWheelParams() {
    return listWheels
        .where((element) => element.posizione == "Ant sx")
        .toList();
  }

  List<Wheel> findRearRightWheelParams() {
    return listWheels
        .where((element) => element.posizione == "Post dx")
        .toList();
  }

  List<Wheel> findRearLeftWheelParams() {
    return listWheels
        .where((element) => element.posizione == "Post sx")
        .toList();
  }

  dynamic findFrontRightFromExistingParams(
      String codifica, String pressione, String camber, String toe) {
    List<Wheel> matchingWheels = listWheels
        .where((element) =>
            element.posizione == "Ant dx" &&
            element.codifica == codifica &&
            double.parse(pressione) == element.pressione &&
            element.frontale == camber &&
            element.superiore == toe)
        .toList();

    return matchingWheels.isNotEmpty ? matchingWheels.first : false;
  }

  dynamic findFrontLeftFromExistingParams(
      String codifica, String pressione, String camber, String toe) {
    List<Wheel> matchingWheels = listWheels
        .where((element) =>
            element.posizione == "Ant sx" &&
            element.codifica == codifica &&
            double.parse(pressione) == element.pressione &&
            element.frontale == camber &&
            element.superiore == toe)
        .toList();

    return matchingWheels.isNotEmpty ? matchingWheels.first : false;
  }

  dynamic findRearRightFromExistingParams(
      String codifica, String pressione, String camber, String toe) {
    List<Wheel> matchingWheels = listWheels
        .where((element) =>
            element.posizione == "Post dx" &&
            element.codifica == codifica &&
            double.parse(pressione) == element.pressione &&
            element.frontale == camber &&
            element.superiore == toe)
        .toList();

    return matchingWheels.isNotEmpty ? matchingWheels.first : false;
  }

  dynamic findRearLeftFromExistingParams(
      String codifica, String pressione, String camber, String toe) {
    List<Wheel> matchingWheels = listWheels
        .where((element) =>
            element.posizione == "Post sx" &&
            element.codifica == codifica &&
            double.parse(pressione) == element.pressione &&
            element.frontale == camber &&
            element.superiore == toe)
        .toList();

    return matchingWheels.isNotEmpty ? matchingWheels.first : false;
  }

  List<Balance> findFrontBalanceParams() {
    return listBalance.where((element) => element.posizione == "Ant").toList();
  }

  List<Balance> findRearBalanceParams() {
    return listBalance.where((element) => element.posizione == "Post").toList();
  }

  dynamic findFrontFromExistingParams(String peso, String frenata) {
    List<Balance> matchingBalance = listBalance
        .where((element) =>
            element.posizione == "Ant" &&
            element.peso == double.parse(peso) &&
            element.frenata == double.parse(frenata))
        .toList();

    return matchingBalance.isNotEmpty ? matchingBalance.first : false;
  }

  findRearFromExistingParams(String peso, String frenata) {
    List<Balance> matchingBalance = listBalance
        .where((element) =>
            element.posizione == "Post" &&
            element.peso == double.parse(peso) &&
            element.frenata == double.parse(frenata))
        .toList();

    return matchingBalance.isNotEmpty ? matchingBalance.first : false;
  }
}

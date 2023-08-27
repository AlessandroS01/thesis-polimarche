import 'package:polimarche/model/UsedSetup.dart';
import 'package:polimarche/model/Wheel.dart';
import 'package:polimarche/repository/balance_repository.dart';
import 'package:polimarche/repository/damper_repository.dart';
import 'package:polimarche/repository/setup_repository.dart';
import 'package:polimarche/repository/spring_repository.dart';
import 'package:polimarche/repository/used_setup_repository.dart';
import 'package:polimarche/repository/wheel_repository.dart';

import '../model/Balance.dart';
import '../model/Damper.dart';
import '../model/Setup.dart';
import '../model/Spring.dart';

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
  late List<Spring> listSprings;
  late List<Damper> listDampers;

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
    listSprings = springRepository.listSprings;
    listDampers = damperRepository.listDampers;
  }

  void updateLists() {
    listSetups = setupRepository.listSetups;
    listUsedSetups = usedSetupRepository.listSetupsUsed;
    listWheels = wheelRepository.listWheels;
    listBalance = balanceRepository.listBalances;
    listSprings = springRepository.listSprings;
    listDampers = damperRepository.listDampers;
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

  dynamic findFrontBalanceFromExistingParams(String peso, String frenata) {
    List<Balance> matchingBalance = listBalance
        .where((element) =>
            element.posizione == "Ant" &&
            element.peso == double.parse(peso) &&
            element.frenata == double.parse(frenata))
        .toList();

    return matchingBalance.isNotEmpty ? matchingBalance.first : false;
  }

  dynamic findRearBalanceFromExistingParams(String peso, String frenata) {
    List<Balance> matchingBalance = listBalance
        .where((element) =>
            element.posizione == "Post" &&
            element.peso == double.parse(peso) &&
            element.frenata == double.parse(frenata))
        .toList();

    return matchingBalance.isNotEmpty ? matchingBalance.first : false;
  }

  List<Spring> findFrontSpringParams() {
    return listSprings.where((element) => element.posizione == "Ant").toList();
  }

  List<Spring> findRearSpringParams() {
    return listSprings.where((element) => element.posizione == "Post").toList();
  }

  dynamic findFrontSpringFromExistingParams(
      String codifica, String altezza, String rigArb, String posArb) {
    List<Spring> matchingSprings = listSprings
        .where((element) =>
            element.posizione == "Ant" &&
            element.codifica == codifica &&
            element.altezza == double.parse(altezza) &&
            element.rigidezzaArb == rigArb &&
            element.posizioneArb == posArb)
        .toList();

    return matchingSprings.isNotEmpty ? matchingSprings.first : false;
  }

  dynamic findRearSpringFromExistingParams(
      String codifica, String altezza, String rigArb, String posArb) {
    List<Spring> matchingSprings = listSprings
        .where((element) =>
            element.posizione == "Post" &&
            element.codifica == codifica &&
            element.altezza == double.parse(altezza) &&
            element.rigidezzaArb == rigArb &&
            element.posizioneArb == posArb)
        .toList();

    return matchingSprings.isNotEmpty ? matchingSprings.first : false;
  }

  List<Damper> findFrontDamperParams() {
    return listDampers.where((element) => element.posizione == "Ant").toList();
  }

  List<Damper> findRearDamperParams() {
    return listDampers.where((element) => element.posizione == "Post").toList();
  }

  dynamic findFrontDamperFromExistingParams(
      String lsr, String hsr, String hsc, String lsc) {
    List<Damper> matchingDampers = listDampers
        .where((element) =>
            element.posizione == "Ant" &&
            element.lsr == double.parse(lsr) &&
            element.hsr == double.parse(hsr) &&
            element.hsc == double.parse(hsc) &&
            element.lsc == double.parse(lsc))
        .toList();

    return matchingDampers.isNotEmpty ? matchingDampers.first : false;
  }

  dynamic findRearDamperFromExistingParams(
      String lsr, String hsr, String hsc, String lsc) {
    List<Damper> matchingDampers = listDampers
        .where((element) =>
            element.posizione == "Post" &&
            element.lsr == double.parse(lsr) &&
            element.hsr == double.parse(hsr) &&
            element.hsc == double.parse(hsc) &&
            element.lsc == double.parse(lsc))
        .toList();

    return matchingDampers.isNotEmpty ? matchingDampers.first : false;
  }

  void modifySetup(Setup setup, List<Wheel> wheels, List<Balance> balance,
      List<Spring> springs, List<Damper> dampers, List<String> genInfos) {
    wheels.forEach((wheel) {
      var posizione = wheel.posizione;
      var codifica = wheel.codifica;
      var pressione = wheel.pressione;
      var frontale = wheel.frontale;
      var superiore = wheel.superiore;

      var matchingWheel = listWheels.where(
        (element) =>
            element.posizione == posizione &&
            element.codifica == codifica &&
            element.pressione == pressione &&
            element.frontale == frontale &&
            element.superiore == superiore
      ).toList();

      if (matchingWheel.isNotEmpty) {
        wheel.id = matchingWheel.first.id;
      } else {
        // Assuming wheelRepository.addWheel() method adds a new wheel to the list
        wheelRepository.addWheel(wheel);
      }
    });

    Setup newSetup = Setup(
        id: setup.id,
        ala: genInfos[0],
        note: genInfos[1],
        wheelAntDx: wheels[0],
        wheelAntSx: wheels[1],
        wheelPostDx: wheels[2],
        wheelPostSx: wheels[3],
        balanceAnt: balance[0],
        balancePost: balance[1],
        springAnt: springs[0],
        springPost: springs[1],
        damperAnt: dampers[0],
        damperPost: dampers[1]);

    setupRepository.modifySetup(newSetup);

    updateLists();
  }

  void createSetup(List<Wheel> wheels, List<Balance> balance, List<Spring> springs, List<Damper> dampers, List<String> genInfos) {
    wheels.forEach((wheel) {
      var posizione = wheel.posizione;
      var codifica = wheel.codifica;
      var pressione = wheel.pressione;
      var frontale = wheel.frontale;
      var superiore = wheel.superiore;

      var matchingWheel = listWheels.where(
        (element) =>
            element.posizione == posizione &&
            element.codifica == codifica &&
            element.pressione == pressione &&
            element.frontale == frontale &&
            element.superiore == superiore
      ).toList();

      if (matchingWheel.isNotEmpty) {
        wheel.id = matchingWheel.first.id;
      } else {
        // Assuming wheelRepository.addWheel() method adds a new wheel to the list
        wheelRepository.addWheel(wheel);
      }
    });

    Setup newSetup = Setup(
        id: listSetups.last.id + 1,
        ala: genInfos[0],
        note: genInfos[1],
        wheelAntDx: wheels[0],
        wheelAntSx: wheels[1],
        wheelPostDx: wheels[2],
        wheelPostSx: wheels[3],
        balanceAnt: balance[0],
        balancePost: balance[1],
        springAnt: springs[0],
        springPost: springs[1],
        damperAnt: dampers[0],
        damperPost: dampers[1]);

    setupRepository.createSetup(newSetup);

    updateLists();
  }
}

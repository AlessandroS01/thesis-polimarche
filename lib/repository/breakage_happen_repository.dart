import 'package:polimarche/model/BreakageHappen.dart';

class BreakageHappenRepository {
  late List<BreakageHappen> listBreakagesHappened;

  BreakageHappenRepository() {
    listBreakagesHappened = []; /*[
      BreakageHappen(
          1,
          "Prova rottura avvenuta",
          Session(
              1,
              "Endurance",
              DateTime(2023, 8, 16, 10, 0),
              DateTime(2023, 8, 16, 10, 30),
              DateTime(2023, 8, 16, 11, 30),
              Track("Mugello", 5.12),
              "Sunny",
              1013.25,
              25.0,
              30.0,
              "Dry"),
          Breakage(3, "Motore"),
          true),
      BreakageHappen(
          2,
          "Prova rottura avvenuta",
          Session(
              1,
              "Endurance",
              DateTime(2023, 8, 16, 10, 0),
              DateTime(2023, 8, 16, 10, 30),
              DateTime(2023, 8, 16, 11, 30),
              Track("Mugello", 5.12),
              "Sunny",
              1013.25,
              25.0,
              30.0,
              "Dry"),
          Breakage(3, "Motore"),
          false),
    ];
    */
  }

  void addBreakageHappend(BreakageHappen breakageHappen) {
    listBreakagesHappened.add(breakageHappen);
  }
}

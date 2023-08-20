import 'package:polimarche/model/BreakageHappen.dart';
import 'package:polimarche/model/Session.dart';

import '../model/Breakage.dart';

class BreakageService {

  late List<Breakage> listBreakages;
  late List<BreakageHappen> listBreakagesHappened;

  BreakageService(List<Session> listSessions) {
    listBreakages = [
      Breakage(1, "motore"),
      Breakage(2, "telaio"),
      Breakage(3, "ammortizzatori"),
    ];

    listBreakagesHappened  = [
      BreakageHappen(1, "tutto", listSessions[0], listBreakages[0], true),
      BreakageHappen(2, "prova rottura avvenuta", listSessions[0], listBreakages[1], false),
    ];
  }
}
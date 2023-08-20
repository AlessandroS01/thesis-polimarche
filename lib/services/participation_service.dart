import 'package:polimarche/model/Session.dart';
import 'package:polimarche/services/team_service.dart';

import '../model/Participation.dart';

class ParticipationService {

  late TeamService teamService;
  late List<Participation> listParticipations;

  ParticipationService(List<Session> listSessions) {
    teamService = TeamService();

    listParticipations = [
      Participation(
          1,
          teamService.drivers[0],
          listSessions[0],
          1,
          "00:00:00.000"
      ),Participation(
          2,
          teamService.drivers[1],
          listSessions[0],
          2,
          "00:00:00.000"
      ),
    ];
  }
}
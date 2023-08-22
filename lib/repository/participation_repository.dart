import '../model/Driver.dart';
import '../model/Member.dart';
import '../model/Participation.dart';
import '../model/Session.dart';
import '../model/Track.dart';
import '../model/Workshop.dart';

class ParticipationRepository {
  late List<Participation> listParticipations;

  ParticipationRepository() {
    listParticipations = [
      Participation(
          1,
          Driver(
              1,
              Member(
                  1097941,
                  "Francesco",
                  "AA",
                  DateTime(2001, 10, 10, 0, 0, 0),
                  "S1097941@univpm.it",
                  "3927602953",
                  "Caporeparto",
                  Workshop("Telaio")),
              80,
              180),
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
          1,
          "00:00:00.000"),

    ];
  }

  void addNewParticipation(Participation newParticipation) {
    listParticipations.add(newParticipation);
  }
}

import 'package:polimarche/model/Session.dart';
import 'package:polimarche/model/Track.dart';

class SessionService {

  late List<Session> listSessions;
  late List<Track> listTracks;

  SessionService () {
    listTracks = [
        Track("Mugello", 5.12),
        Track("Monaco", 7.87),
        Track("Imola", 6.42)
    ];

    listSessions = [
      Session(
          1,
          "Endurance",
          DateTime(2023, 8, 19, 10, 0),
          DateTime(2023, 8, 19, 10, 30),
          DateTime(2023, 8, 19, 11, 30),
          listTracks[0],
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"
      ),
      Session(
          2,
          "Acceleration",
          DateTime(2023, 8, 20, 10, 0),
          DateTime(2023, 8, 20, 10, 30),
          DateTime(2023, 8, 20, 11, 30),
          listTracks[1],
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"
      ),
    ];

  }
}
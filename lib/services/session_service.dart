import 'package:polimarche/model/Participation.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/model/Track.dart';
import 'package:polimarche/model/Comment.dart';
import 'package:polimarche/services/breakage_service.dart';
import 'package:polimarche/services/participation_service.dart';
import 'package:polimarche/services/team_service.dart';

class SessionService {

  late BreakageService breakageService;
  late ParticipationService participationService;

  late List<Session> listSessions;
  late List<Track> listTracks;


  late List<Comment> listComments;

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
          DateTime(2023, 8, 16, 10, 0),
          DateTime(2023, 8, 16, 10, 30),
          DateTime(2023, 8, 16, 11, 30),
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
      Session(
          3,
          "Autocross",
          DateTime(2023, 8, 20, 10, 0),
          DateTime(2023, 8, 20, 10, 30),
          DateTime(2023, 8, 20, 11, 30),
          listTracks[2],
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"
      ),
      Session(
          4,
          "Skidpad",
          DateTime(2023, 8, 20, 10, 0),
          DateTime(2023, 8, 20, 10, 30),
          DateTime(2023, 8, 20, 11, 30),
          listTracks[2],
          "Sunny",
          1013.25,
          25.0,
          30.0,
          "Dry"
      ),
    ];

    listComments = [
      Comment(
        1,
        "Team",
        "Commento team",
        listSessions[0]
      ),
      Comment(
        2,
        "Pilota",
        "Commento pilota",
        listSessions[0]
      ),
    ];
    breakageService = BreakageService(listSessions);
    participationService = ParticipationService(listSessions);

  }


  List<Comment> getCommentsBySessionId(int sessionId) {
    return listComments.where(
            (element) => element.sessione.id == sessionId
    ).toList();
  }

  void deleteComment(Comment comment) {
    listComments.remove(comment);
  }

  void modifyComment(Comment oldComment, String newDescrizione, String newFlag) {
    Comment comment = listComments.where(
            (element) => element.id == oldComment.id
    ).first;

    comment.descrizione = newDescrizione;
    comment.flag = capitalizeFirstLetter(newFlag);
  }

  void addComment(String newDescrizione, String newFlag, Session session) {
    listComments.add(
      Comment(
          listComments.last.id + 1,
          capitalizeFirstLetter(newFlag),
          newDescrizione,
          session
      )
    );
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input; // Handle empty string case
    return input[0].toUpperCase() + input.substring(1);
  }
}
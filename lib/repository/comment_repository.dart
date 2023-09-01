import '../model/Comment.dart';
import '../model/session_model.dart';
import '../model/track_model.dart';

class CommentRepository {
  late List<Comment> listComments;

  CommentRepository() {
    listComments = []; /*[
      Comment(
        1,
        "Team",
        "Commento team",
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
      ),
      Comment(
        2,
        "Pilota",
        "Commento pilota",
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
      ),
    ];
    */
  }

  void delete(Comment comment) {
    listComments.removeWhere((element) => element.id == comment.id);
  }

  void modifyComment(Comment oldComment, String newDescrizione, String newFlag) {
    Comment comment =
          listComments.where((element) => element.id == oldComment.id).first;
      comment.descrizione = newDescrizione;
      comment.flag = newFlag;
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input; // Handle empty string case
    return input[0].toUpperCase() + input.substring(1);
  }

  void addComment(String newDescrizione, String newFlag, Session session) {
    listComments.add(Comment(listComments.last.id + 1,
        newFlag, newDescrizione, session));
  }
}

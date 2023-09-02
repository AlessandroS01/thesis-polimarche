import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../model/comment_model.dart';

class CommentRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Comment] saved in firebase with uid specified if exists or null
  Future<List<Comment>> getCommentsBySessionId(int id) async {
    List<Comment> comments = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('comment')
        .where('sessionId', isEqualTo: id)
        .get();

    if (snapshot.size != 0) {
      comments = snapshot.docs.map((doc) {
        final data = doc.data();
        return Comment.fromMap(data);
      }).toList();
    }

    return comments;
  }

  Future<void> addNewComment(
      String flag, String description, int sessionUid) async {
    String newUid = Uuid().v4();

    Comment newComment = Comment(
        uid: newUid,
        flag: flag,
        descrizione: description,
        sessionId: sessionUid);

    await _firestore.collection('comment').doc(newUid).set(newComment.toMap());
  }

  Future<void> deleteComment(String commentUid) async {
    await _firestore.collection('comment').doc(commentUid).delete();
  }

  Future<void> modifyComment(
      Comment comment, String description, String newFlag) async {
    Map<String, dynamic> updatedData = {
      'descrizione': description,
      'flag': newFlag,
    };
    print(comment.uid!);
    // Update the document with the new data
    await _firestore.collection('comment').doc(comment.uid!).update(updatedData);
  }
}

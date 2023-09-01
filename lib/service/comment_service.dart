import 'package:flutter/src/material/time.dart';
import 'package:polimarche/repos/comment_repo.dart';
import 'package:polimarche/repos/track_repo.dart';
import '../model/comment_model.dart';
import '../model/note_model.dart';
import '../model/track_model.dart';
import '../repos/agenda_repo.dart';

class CommentService {
  final CommentRepo _commentRepo = CommentRepo();

  Future<List<Comment>> getCommentsBySessionId(int sessionId) async {
    return await _commentRepo.getCommentsBySessionId(sessionId);
  }

  Future<void> addNewComment(String flag, String description, int? sessionUid) async {
    await _commentRepo.addNewComment(flag, description, sessionUid!);
  }

  Future<void> deleteComment(String? commentUid) async {
    await _commentRepo.deleteComment(commentUid!);
  }

  Future<void> modifyComment(Comment comment, String description, String newFlag) async {
    await _commentRepo.modifyComment(comment, description, newFlag);
  }

}

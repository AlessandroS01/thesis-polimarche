import 'package:flutter/src/material/time.dart';
import 'package:polimarche/repos/track_repo.dart';
import '../model/note_model.dart';
import '../model/track_model.dart';
import '../repos/agenda_repo.dart';

class TrackService {
  final TrackRepo _trackRepo = TrackRepo();

  Future<List<Track>> getTracks() async {
    return await _trackRepo.getTracks();
  }

}

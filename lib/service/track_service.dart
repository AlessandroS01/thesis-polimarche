import 'package:polimarche/repos/track_repo.dart';

import '../model/track_model.dart';

class TrackService {
  final TrackRepo _trackRepo = TrackRepo();

  Future<List<Track>> getTracks() async {
    return await _trackRepo.getTracks();
  }

}

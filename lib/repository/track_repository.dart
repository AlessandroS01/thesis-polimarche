import '../model/Track.dart';

class TrackRepository {

  late List<Track> listTracks;

  TrackRepository() {
    listTracks = [
      Track("Mugello", 5.12),
      Track("Monaco", 7.87),
      Track("Imola", 6.42)
    ];
  }
}
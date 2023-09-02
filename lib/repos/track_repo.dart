import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/track_model.dart';

class TrackRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Track] saved in firebase with uid specified if exists or null
  Future<List<Track>> getTracks() async {

    List<Track> tracks = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('track')
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Track.fromMap(data);
      }).toList();
    }

    return tracks;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/sensor/speed_model.dart';

class SpeedRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Speed>> getSpeedDataBySessionAndSetupId(
      int sessionId, int setupId) async {

    List<Speed> speed = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sensor_speed')
        .where('setupId', isEqualTo: setupId)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Speed.fromMap(data);
      }).toList();
    }

    return speed;
  }
}

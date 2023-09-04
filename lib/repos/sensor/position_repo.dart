import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/sensor/current_model.dart';
import 'package:polimarche/model/sensor/load_model.dart';
import 'package:polimarche/model/sensor/position_model.dart';

import '../../model/sensor/temperature_model.dart';

class PositionRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Position>> getPositionDataBySessionAndSetupId(
      int sessionId, int setupId) async {

    List<Position> position = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sensor_position')
        .where('setupId', isEqualTo: setupId)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Position.fromMap(data);
      }).toList();
    }

    return position;
  }
}

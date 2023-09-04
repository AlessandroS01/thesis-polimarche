import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/sensor/temperature_model.dart';

class TemperatureRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Temperature>> getTemperatureDataBySessionAndSetupId(
      int sessionId, int setupId) async {

    List<Temperature> temperature = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sensor_temperature')
        .where('setupId', isEqualTo: setupId)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Temperature.fromMap(data);
      }).toList();
    }

    return temperature;
  }
}

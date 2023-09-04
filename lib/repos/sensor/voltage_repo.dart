import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/sensor/voltage_model.dart';

class VoltageRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Voltage>> getVoltageDataBySessionAndSetupId(
      int sessionId, int setupId) async {

    List<Voltage> voltage = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sensor_voltage')
        .where('setupId', isEqualTo: setupId)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Voltage.fromMap(data);
      }).toList();
    }

    return voltage;
  }
}

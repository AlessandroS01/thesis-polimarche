import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/sensor/pressure_model.dart';

class PressureRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Pressure>> getPressureDataBySessionAndSetupId(
      int sessionId, int setupId) async {

    List<Pressure> pressure = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sensor_pressure')
        .where('setupId', isEqualTo: setupId)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Pressure.fromMap(data);
      }).toList();
    }

    return pressure;
  }
}

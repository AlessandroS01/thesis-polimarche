import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/sensor/current_model.dart';

class CurrentRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Current>> getCurrentDataBySessionAndSetupId(
      int sessionId, int setupId) async {

    List<Current> current = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sensor_current')
        .where('setupId', isEqualTo: setupId)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Current.fromMap(data);
      }).toList();
    }

    return current;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/sensor/load_model.dart';

class LoadRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Load>> getLoadDataBySessionAndSetupId(
      int sessionId, int setupId) async {

    List<Load> load = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sensor_load')
        .where('setupId', isEqualTo: setupId)
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Load.fromMap(data);
      }).toList();
    }

    return load;
  }
}

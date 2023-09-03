import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/wheel_model.dart';

class WheelRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Wheel] saved in firebase with uid specified if exists or null
  Future<List<Wheel>> getWheels() async {

    List<Wheel> wheels = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('wheel')
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Wheel.fromMap(data);
      }).toList();
    }

    return wheels;
  }

  Future<int> addNewWheel(Wheel wheel) async {

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('wheel').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (int.parse(data.id) > maxId) {
           maxId = int.parse(data.id);
        }
      });
    }

    await _firestore
        .collection('wheel')
        .doc((maxId + 1).toString())
        .set(wheel.toMap(maxId + 1));

    return maxId + 1;
  }
}

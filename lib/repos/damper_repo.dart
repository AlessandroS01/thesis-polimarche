import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/damper_model.dart';

class DamperRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Damper] saved in firebase with uid specified if exists or null
  Future<List<Damper>> getDampers() async {

    List<Damper> dampers = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('damper')
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Damper.fromMap(data);
      }).toList();
    }

    return dampers;
  }

  Future<int> addNewDamper(Damper damper) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('damper').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (int.parse(data.id) > maxId) {
           maxId = int.parse(data.id);
        }
      });
    }

    await _firestore
        .collection('damper')
        .doc((maxId + 1).toString())
        .set(damper.toMap(maxId + 1));

    return maxId + 1;
  }
}

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
}

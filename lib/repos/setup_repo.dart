import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/setup_model.dart';

class SetupRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Setup] saved in firebase with uid specified if exists or null
  Future<List<Setup>> getSetups() async {

    List<Setup> setups = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('setup')
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Setup.fromMap(data);
      }).toList();
    }

    return setups;
  }
}

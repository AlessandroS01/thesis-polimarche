import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/used_setup_model.dart';

class UsedSetupRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [UsedSetup] saved in firebase with uid specified if exists or null
  Future<List<UsedSetup>> getUsedSetupsBySessionId(int sessionId) async {
    List<UsedSetup> usedSetups = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('used_setup')
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return UsedSetup.fromMap(data);
      }).toList();
    }

    return usedSetups;
  }

  Future<void> addNewUsedSetup(
      int sessionId, int newSetupUsedId, String newComment) async {
    UsedSetup newUsedSetup = UsedSetup(
        sessionId: sessionId, setupId: newSetupUsedId, commento: newComment);

    _firestore.collection('used_setup').add(newUsedSetup.toMap());
  }
}

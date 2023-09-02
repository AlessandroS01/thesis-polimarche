import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/breakage_model.dart';

class BreakageRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Breakage] saved in firebase with uid specified if exists or null
  Future<List<Breakage>> getBreakagesBySessionId(int sessionId) async {
    List<Breakage> breakages = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('breakage')
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Breakage.fromMap(data);
      }).toList();
    }

    return breakages;
  }

  Future<void> addNewBreakage(
      int sessionId, bool colpaPilota, String descrizione) async {
    Breakage breakage = Breakage(
        descrizione: descrizione,
        sessionId: sessionId,
        colpaPilota: colpaPilota);

    _firestore.collection('breakage').add(breakage.toMap());
  }
}

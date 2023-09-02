import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/participation_model.dart';

class ParticipationRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Participation] saved in firebase with uid specified if exists or null
  Future<List<Participation>> getParticipationsBySessionId(
      int sessionId) async {
    List<Participation> participations = List.empty();

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('participation')
        .where('sessionId', isEqualTo: sessionId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Participation.fromMap(data);
      }).toList();
    }

    return participations;
  }

  Future<void> addNewParticipation(
      String matricola, int sessionId, String cambioPilota) async {

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('participation')
            .where('sessionId', isEqualTo: sessionId)
            .get();

    int maxOrdine = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (data.get('ordine') > maxOrdine) {
          maxOrdine = data.get('ordine');
        }
      });
    }

    Participation newParticipation = Participation(
        matricolaPilota: int.parse(matricola),
        sessionId: sessionId,
        ordine: maxOrdine + 1,
        cambioPilota: cambioPilota);


    await _firestore
        .collection('participation')
        .add(newParticipation.toMap());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/balance_model.dart';
import 'package:polimarche/model/damper_model.dart';
import 'package:polimarche/model/spring_model.dart';
import 'package:polimarche/model/wheel_model.dart';

import '../model/setup_model.dart';

class SetupRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Setup] saved in firebase with uid specified if exists or null
  Future<List<Setup>> getSetups() async {
    List<Setup> setups = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('setup').get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Setup.fromMap(data);
      }).toList();
    }

    return setups;
  }

  Future<Setup> getSetupById(int setupId) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('setup').doc(setupId.toString()).get();

    return Setup.fromMap(documentSnapshot.data()!);
  }

  Future<void> modifySetup(
      int id,
      List<Wheel> wheelsUsed,
      List<Balance> balanceUsed,
      List<Spring> springsUsed,
      List<Damper> dampersUsed,
      List<String> genInfosUsed) async {
    Setup newSetup = Setup(
        id: id,
        ala: genInfosUsed[0],
        note: genInfosUsed[1],
        wheelAntDx: wheelsUsed[0],
        wheelAntSx: wheelsUsed[1],
        wheelPostDx: wheelsUsed[2],
        wheelPostSx: wheelsUsed[3],
        balanceAnt: balanceUsed[0],
        balancePost: balanceUsed[1],
        springAnt: springsUsed[0],
        springPost: springsUsed[1],
        damperAnt: dampersUsed[0],
        damperPost: dampersUsed[1]);

    _firestore.collection('setup').doc(id.toString()).update(newSetup.toMap());
  }

  Future<void> createSetup(
      List<Wheel> wheelsUsed,
      List<Balance> balanceUsed,
      List<Spring> springsUsed,
      List<Damper> dampersUsed,
      List<String> genInfosUsed) async {

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('setup').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (int.parse(data.id) > maxId) {
           maxId = int.parse(data.id);
        }
      });
    }

    Setup newSetup = Setup(
        id: maxId + 1,
        ala: genInfosUsed[0],
        note: genInfosUsed[1],
        wheelAntDx: wheelsUsed[0],
        wheelAntSx: wheelsUsed[1],
        wheelPostDx: wheelsUsed[2],
        wheelPostSx: wheelsUsed[3],
        balanceAnt: balanceUsed[0],
        balancePost: balanceUsed[1],
        springAnt: springsUsed[0],
        springPost: springsUsed[1],
        damperAnt: dampersUsed[0],
        damperPost: dampersUsed[1]);

    await _firestore
        .collection('setup')
        .doc((maxId + 1).toString())
        .set(newSetup.toMap());
  }
}

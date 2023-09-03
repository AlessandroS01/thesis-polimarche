import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/spring_model.dart';

class SpringRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Spring] saved in firebase with uid specified if exists or null
  Future<List<Spring>> getSprings() async {

    List<Spring> springs = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('spring')
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Spring.fromMap(data);
      }).toList();
    }

    return springs;
  }

  Future<int> addNewSpring(Spring spring) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('spring').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (int.parse(data.id) > maxId) {
           maxId = int.parse(data.id);
        }
      });
    }

    await _firestore
        .collection('spring')
        .doc((maxId + 1).toString())
        .set(spring.toMap(maxId + 1));

    return maxId + 1;
  }
}

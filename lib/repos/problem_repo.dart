import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/problem_model.dart';

class ProblemRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Problem] saved in firebase with uid specified if exists or null
  Future<List<Problem>> getProblems() async {
    List<Problem> problems = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('problem').get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Problem.fromMap(data);
      }).toList();
    }

    return problems;
  }

  Future<void> addNewProblem(String description) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('problem').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (data.get('id') > maxId) {
          maxId = data.get('id');
        }
      });
    }

    Problem newProblem = Problem(id: maxId + 1, descrizione: description);

    await _firestore
        .collection('problem')
        .doc((maxId + 1).toString())
        .set(newProblem.toMap());
  }
}

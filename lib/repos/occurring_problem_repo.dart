import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/occurring_problem_model.dart';
import '../model/problem_model.dart';

class OccurringProblemRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [OccurringProblem] saved in firebase with uid specified if exists or null
  Future<List<OccurringProblem>> getOccurringProblemsByProblemId(
      int problemId) async {
    List<OccurringProblem> occurringProblems = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('occurring_problem')
        .where('problemId', isEqualTo: problemId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return OccurringProblem.fromMap(data);
      }).toList();
    }

    return occurringProblems;
  }

  Future<void> addNewOccurringProblem(
      int problemId, String description, int newSetupIdWithProblem) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('occurring_problem').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (int.parse(data.id) > maxId) {
          maxId = int.parse(data.id);
        }
      });
    }

    OccurringProblem newOccurringProblem = OccurringProblem(
        id: maxId + 1,
        setupId: newSetupIdWithProblem,
        problemId: problemId,
        descrizione: description);

    await _firestore
        .collection('occurring_problem')
        .doc((maxId + 1).toString())
        .set(newOccurringProblem.toMap(maxId + 1));
  }

  Future<void> removeOccurringProblem(int id) async {
    await _firestore
        .collection('occurring_problem')
        .doc(id.toString())
        .delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/solved_problem_model.dart';

class SolvedProblemRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [SolvedProblem] saved in firebase with uid specified if exists or null
  Future<List<SolvedProblem>> getSolvedProblemsByProblemId(problemId) async {

    List<SolvedProblem> solvedProblems = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('solved_problem')
        .where('problemId', isEqualTo: problemId)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return SolvedProblem.fromMap(data);
      }).toList();
    }

    return solvedProblems;
  }

  Future<void> addNewSolvedProblem(String description, int problemId, int setupId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('solved_problem').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (int.parse(data.id) > maxId) {
          maxId = int.parse(data.id);
        }
      });
    }

    SolvedProblem newSolvedProblem = SolvedProblem(
        id: maxId + 1,
        setupId: setupId,
        problemId: problemId,
        descrizione: description);

    await _firestore
        .collection('solved_problem')
        .doc((maxId + 1).toString())
        .set(newSolvedProblem.toMap(maxId + 1));
  }

  Future<void> removeSolvedProblem(int id) async{
    await _firestore.collection('solved_problem').doc(id.toString()).delete();
  }
}

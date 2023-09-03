import '../model/occurring_problem_model.dart';
import '../model/problem_model.dart';
import '../model/solved_problem_model.dart';
import '../repos/occurring_problem_repo.dart';
import '../repos/problem_repo.dart';
import '../repos/solved_problem_repo.dart';

class SolvedProblemService {
  final SolvedProblemRepo _solvedProblemRepo = SolvedProblemRepo();

  Future<List<SolvedProblem>> getSolvedProblemsByProblemId(
      int problemId) async {
    return await _solvedProblemRepo
        .getSolvedProblemsByProblemId(problemId);
  }

  Future<void> addNewSolvedProblem(String description, int problemId, int setupId) async {
    await _solvedProblemRepo.addNewSolvedProblem(description, problemId, setupId);
  }

  Future<void> removeSolvedProblem(int id) async {
    await _solvedProblemRepo.removeSolvedProblem(id);
  }
}

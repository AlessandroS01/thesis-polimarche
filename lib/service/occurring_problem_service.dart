import '../model/occurring_problem_model.dart';
import '../repos/occurring_problem_repo.dart';

class OccurringProblemService {
  final OccurringProblemRepo _occurringProblemRepo = OccurringProblemRepo();

  Future<List<OccurringProblem>> getOccurringProblemsByProblemId(
      int problemId) async {
    return await _occurringProblemRepo
        .getOccurringProblemsByProblemId(problemId);
  }

  Future<void> addNewOccurringProblem(
      int problemId, String description, int newSetupIdWithProblem) async {
    await _occurringProblemRepo.addNewOccurringProblem(
        problemId, description, newSetupIdWithProblem);
  }

  Future<void> removeOccurringProblem(int id) async {
    await _occurringProblemRepo.removeOccurringProblem(id);
  }
}

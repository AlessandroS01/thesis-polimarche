import '../model/problem_model.dart';
import '../repos/problem_repo.dart';

class ProblemService {
  final ProblemRepo _problemRepo = ProblemRepo();

  Future<List<Problem>> getProblems() async {
    return await _problemRepo.getProblems();
  }

}

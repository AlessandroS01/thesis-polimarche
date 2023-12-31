import '../model/spring_model.dart';
import '../repos/spring_repo.dart';

class SpringService {
  final SpringRepo _springRepo = SpringRepo();

  Future<List<Spring>> getSprings() async {
    return await _springRepo.getSprings();
  }

  Future<int> addNewSpring(Spring spring) async{
    return await _springRepo.addNewSpring(spring);
  }

}

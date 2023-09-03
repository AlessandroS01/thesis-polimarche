import '../model/damper_model.dart';
import '../repos/damper_repo.dart';

class DamperService {
  final DamperRepo _damperRepo = DamperRepo();

  Future<List<Damper>> getDampers() async {
    return await _damperRepo.getDampers();
  }

  Future<int> addNewDampers(Damper damper) async{
    return await _damperRepo.addNewDamper(damper);
  }

}

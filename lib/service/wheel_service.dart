import 'package:polimarche/model/wheel_model.dart';

import '../repos/Wheel_repo.dart';

class WheelService {
  final WheelRepo _wheelRepo = WheelRepo();

  Future<List<Wheel>> getWheels() async {
    return await _wheelRepo.getWheels();
  }

  Future<int> addNewWheel(Wheel wheel) async {
    return await _wheelRepo.addNewWheel(wheel);
  }

}

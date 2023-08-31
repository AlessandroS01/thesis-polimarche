
import 'package:polimarche/model/member_model.dart';

import '../model/driver_model.dart';
import '../repos/driver_repo.dart';

class DriverService {
  final DriverRepo _driverRepo = DriverRepo();

  Future<List<Driver>> getDrivers() async {
    return await _driverRepo.getDrivers();
  }

  Future<void> addNewDriver(int height, double weight, Member member) async {
    await _driverRepo.addNewDriver(height, weight, member);
  }
}
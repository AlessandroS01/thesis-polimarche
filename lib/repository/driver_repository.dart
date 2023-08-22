import '../model/Driver.dart';
import '../model/Member.dart';
import '../model/Workshop.dart';

class DriverRepository {

  late List<Driver> listDrivers;

  DriverRepository() {
    listDrivers = [
      Driver(
          1,
          Member(
              1097941,
              "Francesco",
              "AA",
              DateTime(2001, 10, 10, 0, 0, 0),
              "S1097941@univpm.it",
              "3927602953",
              "Caporeparto",
              Workshop("Telaio")),
          80,
          180),
      Driver(
          4,
          Member(
              789,
              "Ponzio",
              "AA",
              DateTime(2001, 10, 10, 0, 0, 0),
              "S1097941@univpm.it",
              "3927602953",
              "Caporeparto",
              Workshop("Battery pack")),
          80,
          180),
    ];
  }
}
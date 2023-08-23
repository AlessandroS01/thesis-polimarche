import '../model/Breakage.dart';

class BreakageRepository {


  late List<Breakage> listBreakages;

  BreakageRepository() {

    listBreakages = [
      Breakage(1, "Telaio"),
      Breakage(3, "Motore")
    ];
  }
}
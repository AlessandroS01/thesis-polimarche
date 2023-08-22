import '../model/Wheel.dart';

class WheelRepository {
  late List<Wheel> listWheels;

  WheelRepository() {
    listWheels = [
      Wheel(
        id: 4,
        codifica: 'example_codifica',
        posizione: 'Post sx',
        frontale: 'example_frontal',
        superiore: 'example_superiore',
        pressione: 11111.0000,
      ),
      Wheel(
        id: 5,
        codifica: 'setup ant dx',
        posizione: 'Ant dx',
        frontale: 'setup ant dx',
        superiore: 'setup ant dx',
        pressione: 11111.0000,
      ),
      Wheel(
        id: 6,
        codifica: 'setup ant sx',
        posizione: 'Ant sx',
        frontale: 'setup ant sx',
        superiore: 'setup ant sx',
        pressione: 11111.0000,
      ),
      Wheel(
        id: 2,
        codifica: 'setup post dx',
        posizione: 'Post dx',
        frontale: 'setup post dx',
        superiore: 'setup post dx',
        pressione: 123.4500,
      ),
      Wheel(
        id: 3,
        codifica: 'setup post sx',
        posizione: 'Post sx',
        frontale: 'setup post sx',
        superiore: 'setup post sx',
        pressione: 123.4500,
      ),
    ];
  }
}

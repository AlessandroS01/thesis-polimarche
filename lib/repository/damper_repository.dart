import '../model/damper_model.dart';

class DamperRepository {
  late List<Damper> listDampers;

  DamperRepository() {
    listDampers = [
      Damper(
        id: 4,
        posizione: 'Ant',
        lsr: 9.10,
        hsr: 10.00,
        lsc: 10.00,
        hsc: 10.00,
      ),
      Damper(
        id: 3,
        posizione: 'Ant',
        lsr: 9.10,
        hsr: 12.30,
        lsc: 10.00,
        hsc: 10.00,
      ),
      Damper(
        id: 2,
        posizione: 'Post',
        lsr: 9.10,
        hsr: 12.30,
        lsc: 4.50,
        hsc: -7.20,
      ),
    ];
  }
}

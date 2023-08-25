import '../model/Balance.dart';

class BalanceRepository {
  late List<Balance> listBalances;

  BalanceRepository() {
    listBalances = [
      Balance(
        id: 4,
        posizione: 'Ant',
        frenata: 49.20,
        peso: 56.78,
      ),
      Balance(
        id: 5,
        posizione: 'Post',
        frenata: 49.20,
        peso: 56.78,
      ),
      Balance(
        id: 2,
        posizione: 'Post',
        frenata: 50.80,
        peso: 43.22,
      ),
    ];
  }
}

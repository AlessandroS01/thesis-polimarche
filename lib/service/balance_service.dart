import '../model/balance_model.dart';
import '../repos/balance_repo.dart';

class BalanceService {
  final BalanceRepo _BalanceRepo = BalanceRepo();

  Future<List<Balance>> getBalances() async {
    return await _BalanceRepo.getBalances();
  }

}

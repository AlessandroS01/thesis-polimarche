import '../model/balance_model.dart';
import '../repos/balance_repo.dart';

class BalanceService {
  final BalanceRepo _balanceRepo = BalanceRepo();

  Future<List<Balance>> getBalances() async {
    return await _balanceRepo.getBalances();
  }

  Future<int> addNewBalance(Balance balance) async {
    return await _balanceRepo.addNewBalance(balance);
  }

}

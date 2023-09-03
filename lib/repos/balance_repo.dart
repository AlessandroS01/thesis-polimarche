import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/balance_model.dart';

class BalanceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Balance] saved in firebase with uid specified if exists or null
  Future<List<Balance>> getBalances() async {

    List<Balance> balance = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('balance')
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Balance.fromMap(data);
      }).toList();
    }

    return balance;
  }

  Future<int> addNewBalance(Balance balance) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('balance').get();

    int maxId = 0;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        if (int.parse(data.id) > maxId) {
           maxId = int.parse(data.id);
        }
      });
    }

    await _firestore
        .collection('balance')
        .doc((maxId + 1).toString())
        .set(balance.toMap(maxId + 1));

    return maxId + 1;
  }
}

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
}

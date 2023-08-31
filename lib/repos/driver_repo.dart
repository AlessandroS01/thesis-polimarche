import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/member_model.dart';

import '../model/driver_model.dart';

class DriverRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return all [Driver] saved in firebase
  Future<List<Driver>> getDrivers() async {
    final snapshot = await _firestore.collection('drivers').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Driver.fromMap(data);
    }).toList();
  }

  /// add [Driver] if the member is not already set as driver
  Future<void> addNewDriver(int height, double weight, Member member) async {
      if (!(await getDriverByMatricola(member.matricola))) {
        final Driver newDriver = Driver(membro: member, peso: weight, altezza: height);
        await _firestore.collection('drivers').add(newDriver.toMap());
      }
  }

  /// return [bool] true if the matricola used doesn't match with the drivers
  Future<bool> getDriverByMatricola(int matricola) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('drivers')
        .where('membro.matricola', isEqualTo: matricola)
        .get();
    if (snapshot.size != 0) {
      return true;
    }

    return false;
  }


}
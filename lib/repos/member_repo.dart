import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/member_model.dart';

class MemberRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<Member?> getMemberByUid(String uid) async {
    Member? member;
    
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (snapshot.size != 0) {
      final data = snapshot.docs.first.data();
      member = Member.fromMap(data);
    }

    return member;
  }
}
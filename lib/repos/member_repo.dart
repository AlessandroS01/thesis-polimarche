import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polimarche/model/member_model.dart';

class MemberRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Member] saved in firebase with uid specified if exists or null
  Future<Member?> getMemberByUid(String uid) async {
    Member? member;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').where('uid', isEqualTo: uid).get();

    if (snapshot.size != 0) {
      final data = snapshot.docs.first.data();
      member = Member.fromMap(data);
    }

    return member;
  }

  /// return all [Member] saved in firebase
  Future<List<Member>> getMembers() async {
    final snapshot = await _firestore.collection('users').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Member.fromMap(data);
    }).toList();
  }

  Future<void> createNewMember(Member newMember) async {
    String role = newMember.ruolo;

    if (role == "Caporeparto") {
      String workshopArea = newMember.reparto!;

      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .where('ruolo', isEqualTo: role)
          .where('reparto', isEqualTo: workshopArea)
          .get();

      if (snapshot.size != 0) {
        final id = snapshot.docs.first.id;
        final data = snapshot.docs.first.data();
        Member previousHeadDip = Member.fromMap(data);

        Member updatePreviousHeadDip = Member(
            matricola: previousHeadDip.matricola,
            nome: previousHeadDip.nome,
            cognome: previousHeadDip.cognome,
            dob: previousHeadDip.dob,
            email: previousHeadDip.email,
            telefono: previousHeadDip.telefono,
            ruolo: "Membro",
            reparto: previousHeadDip.reparto,
            uid: previousHeadDip.uid);

        await _firestore
            .collection('users')
            .doc(id)
            .set(updatePreviousHeadDip.toMap());
      }
    }

    _firestore.collection('users').add(newMember.toMap());
  }
}

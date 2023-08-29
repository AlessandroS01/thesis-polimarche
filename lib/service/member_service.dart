
import '../model/member_model.dart';
import '../repos/member_repo.dart'; // Import the MemberRepo class

class MemberService {
  final MemberRepo _memberRepo = MemberRepo();

  Future<Member?> getMemberByUid(String uid) async {
    return _memberRepo.getMemberByUid(uid);
  }
}
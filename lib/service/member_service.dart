
import '../model/member_model.dart';
import '../repos/member_repo.dart'; // Import the MemberRepo class

class MemberService {
  final MemberRepo _memberRepo = MemberRepo();

  /// return [Member] with a specific uid
  Future<Member?> getMemberByUid(String uid) async {
    return _memberRepo.getMemberByUid(uid);
  }

  /// return [List<Member>] containing all the members
  Future<List<Member>> getMembers() async {
    return _memberRepo.getMembers();
  }
}
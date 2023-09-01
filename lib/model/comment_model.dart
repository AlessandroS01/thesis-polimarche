
class Comment {
  final String? uid;
  final String flag;
  final String descrizione;
  final int sessionId;

  Comment(
      {required this.uid,
      required this.flag,
      required this.descrizione,
      required this.sessionId});

  Map<String, dynamic> toMap() {
    return {
      'flag': this.flag,
      'descrizione': this.descrizione,
      'sessionId': this.sessionId,
      'uid': this.uid
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      uid: map['uid'] as String,
      flag: map['flag'] as String,
      descrizione: map['descrizione'] as String,
      sessionId: map['sessionId'] as int,
    );
  }
}

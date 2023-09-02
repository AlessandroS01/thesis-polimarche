class UsedSetup {
  final int sessionId;
  final int setupId;
  final String commento;

  UsedSetup({
    required this.sessionId,
    required this.setupId,
    required this.commento,
  });

  Map<String, dynamic> toMap() {
    return {
      'sessionId': this.sessionId,
      'setupId': this.setupId,
      'commento': this.commento,
    };
  }

  factory UsedSetup.fromMap(Map<String, dynamic> map) {
    return UsedSetup(
      sessionId: map['sessionId'] as int,
      setupId: map['setupId'] as int,
      commento: map['commento'] as String,
    );
  }
}

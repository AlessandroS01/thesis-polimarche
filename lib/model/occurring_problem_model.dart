class OccurringProblem {
  final int id;
  final int setupId;
  final int problemId;
  final String descrizione;

  OccurringProblem({
    required this.id,
    required this.setupId,
    required this.problemId,
    required this.descrizione,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'id': id,
      'setupId': this.setupId,
      'problemId': this.problemId,
      'descrizione': this.descrizione,
    };
  }

  factory OccurringProblem.fromMap(Map<String, dynamic> map) {
    return OccurringProblem(
      id: map['id'] as int,
      setupId: map['setupId'] as int,
      problemId: map['problemId'] as int,
      descrizione: map['descrizione'] as String,
    );
  }
}

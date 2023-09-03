class Problem {

  final int id;
  final String descrizione;

  Problem({required this.id, required this.descrizione});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'descrizione': this.descrizione,
    };
  }

  factory Problem.fromMap(Map<String, dynamic> map) {
    return Problem(
      id: map['id'] as int,
      descrizione: map['descrizione'] as String,
    );
  }
}
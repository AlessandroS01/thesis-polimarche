class Track {
  final String nome;
  final double lunghezza;

  Track({required this.nome, required this.lunghezza});

  Map<String, dynamic> toMap() {
    return {
      'nome': this.nome,
      'lunghezza': this.lunghezza,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      nome: map['nome'] as String,
      lunghezza: map['lunghezza'] is double
          ? map['lunghezza'] as double
          : (map['lunghezza'] as int).toDouble(),
    );
  }
}

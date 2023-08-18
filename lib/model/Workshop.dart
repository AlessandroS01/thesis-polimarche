class Workshop {
  final String reparto;

  Workshop(this.reparto);

  Map<String, dynamic> toJson() {
    return {
      'reparto': reparto
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workshop &&
          runtimeType == other.runtimeType &&
          reparto == other.reparto;

  @override
  int get hashCode => reparto.hashCode;

  @override
  String toString() {
    return 'Workshop(reparto: $reparto)';
  }
}

import '../model/Spring.dart';

class SpringRepository {
  late List<Spring> listSprings;

  SpringRepository() {
    listSprings = [
      Spring(
        id: 3,
        posizione: 'stiff',
        codifica: 'rear',
        posizioneArb: 'Ant',
        rigidezzaArb: 'ABCD1234',
        altezza: 30.0000,
      ),
      Spring(
        id: 4,
        posizione: 'stiff',
        codifica: 'rear',
        posizioneArb: 'Ant',
        rigidezzaArb: 'ABCD1234',
        altezza: 111.0000,
      ),
      Spring(
        id: 1,
        posizione: 'stiff',
        codifica: 'rear',
        posizioneArb: 'Post',
        rigidezzaArb: 'ABCD1234',
        altezza: 24.0000,
      ),
      Spring(
        id: 5,
        posizione: 'stiff',
        codifica: 'rear',
        posizioneArb: 'Post',
        rigidezzaArb: 'ABCD1234',
        altezza: 111.0000,
      ),
    ];
  }
}

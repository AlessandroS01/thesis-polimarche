import '../model/Balance.dart';
import '../model/Damper.dart';
import '../model/Setup.dart';
import '../model/Spring.dart';
import '../model/Wheel.dart';

class SetupRepository {
  late List<Setup> listSetups;

  SetupRepository() {
    listSetups = [
      Setup(
        id: 1,
        ala: 'ala',
        note: 'note',
        wheelAntDx: Wheel(
          id: 5,
          codifica: 'setup ant dxsdfsdfsdfsdfds',
          posizione: 'Ant dx',
          frontale: 'setup ant dx',
          superiore: 'setup ant dx',
          pressione: 2,
        ),
        wheelAntSx: Wheel(
          id: 6,
          codifica: 'setup ant sx',
          posizione: 'Ant sx',
          frontale: 'setup ant sx',
          superiore: 'setup ant sx',
          pressione: 11111.0000,
        ),
        wheelPostDx: Wheel(
          id: 2,
          codifica: 'setup post dx',
          posizione: 'Post dx',
          frontale: 'setup post dx',
          superiore: 'setup post dx',
          pressione: 123.4500,
        ),
        wheelPostSx: Wheel(
          id: 3,
          codifica: 'setup post sx',
          posizione: 'Post sx',
          frontale: 'setup post sx',
          superiore: 'setup post sx',
          pressione: 123.4500,
        ),
        balanceAnt: Balance(
          id: 4,
          posizione: 'Ant',
          frenata: 49.20,
          peso: 56.78,
        ),
        balancePost: Balance(
          id: 2,
          posizione: 'Post',
          frenata: 50.80,
          peso: 43.22,
        ),
        springAnt: Spring(
          id: 3,
          posizione: 'Ant',
          codifica: 'rear',
          posizioneArb: 'Ant',
          rigidezzaArb: 'ABCD1234',
          altezza: 30.0000,
        ),
        springPost: Spring(
          id: 1,
          posizione: 'Post',
          codifica: 'rear',
          posizioneArb: 'Post',
          rigidezzaArb: 'ABCD1234',
          altezza: 24.0000,
        ),
        damperAnt: Damper(
          id: 4,
          posizione: 'Ant',
          lsr: 9.10,
          hsr: 10.00,
          lsc: 10.00,
          hsc: 10.00,
        ),
        damperPost: Damper(
          id: 2,
          posizione: 'Post',
          lsr: 9.10,
          hsr: 12.30,
          lsc: 4.50,
          hsc: -7.20,
        ),
      ),
      Setup(
        id: 2,
        ala: 'ala',
        note: 'note',
        wheelAntDx: Wheel(
          id: 5,
          codifica: 'setup ant dxsdfsdfsdfsdfds',
          posizione: 'Ant dx',
          frontale: 'setup ant dx',
          superiore: 'setup ant dx',
          pressione: 2,
        ),
        wheelAntSx: Wheel(
          id: 6,
          codifica: 'setup ant sx',
          posizione: 'Ant sx',
          frontale: 'setup ant sx',
          superiore: 'setup ant sx',
          pressione: 11111.0000,
        ),
        wheelPostDx: Wheel(
          id: 2,
          codifica: 'setup post dx',
          posizione: 'Post dx',
          frontale: 'setup post dx',
          superiore: 'setup post dx',
          pressione: 123.4500,
        ),
        wheelPostSx: Wheel(
          id: 3,
          codifica: 'setup post sx',
          posizione: 'Post sx',
          frontale: 'setup post sx',
          superiore: 'setup post sx',
          pressione: 123.4500,
        ),
        balanceAnt: Balance(
          id: 4,
          posizione: 'Ant',
          frenata: 49.20,
          peso: 56.78,
        ),
        balancePost: Balance(
          id: 2,
          posizione: 'Post',
          frenata: 50.80,
          peso: 43.22,
        ),
        springAnt: Spring(
          id: 3,
          posizione: 'Ant',
          codifica: 'rear',
          posizioneArb: 'Ant',
          rigidezzaArb: 'ABCD1234',
          altezza: 30.0000,
        ),
        springPost: Spring(
          id: 1,
          posizione: 'Post',
          codifica: 'rear',
          posizioneArb: 'Post',
          rigidezzaArb: 'ABCD1234',
          altezza: 24.0000,
        ),
        damperAnt: Damper(
          id: 4,
          posizione: 'Ant',
          lsr: 9.10,
          hsr: 10.00,
          lsc: 10.00,
          hsc: 10.00,
        ),
        damperPost: Damper(
          id: 2,
          posizione: 'Post',
          lsr: 9.10,
          hsr: 12.30,
          lsc: 4.50,
          hsc: -7.20,
        ),
      ),
      Setup(
        id: 3,
        ala: 'ala',
        note: 'note',
        wheelAntDx: Wheel(
          id: 5,
          codifica: 'setup ant dxsdfsdfsdfsdfds',
          posizione: 'Ant dx',
          frontale: 'setup ant dx',
          superiore: 'setup ant dx',
          pressione: 2,
        ),
        wheelAntSx: Wheel(
          id: 6,
          codifica: 'setup ant sx',
          posizione: 'Ant sx',
          frontale: 'setup ant sx',
          superiore: 'setup ant sx',
          pressione: 11111.0000,
        ),
        wheelPostDx: Wheel(
          id: 2,
          codifica: 'setup post dx',
          posizione: 'Post dx',
          frontale: 'setup post dx',
          superiore: 'setup post dx',
          pressione: 123.4500,
        ),
        wheelPostSx: Wheel(
          id: 3,
          codifica: 'setup post sx',
          posizione: 'Post sx',
          frontale: 'setup post sx',
          superiore: 'setup post sx',
          pressione: 123.4500,
        ),
        balanceAnt: Balance(
          id: 4,
          posizione: 'Ant',
          frenata: 49.20,
          peso: 56.78,
        ),
        balancePost: Balance(
          id: 2,
          posizione: 'Post',
          frenata: 50.80,
          peso: 43.22,
        ),
        springAnt: Spring(
          id: 3,
          posizione: 'Ant',
          codifica: 'rear',
          posizioneArb: 'Ant',
          rigidezzaArb: 'ABCD1234',
          altezza: 30.0000,
        ),
        springPost: Spring(
          id: 1,
          posizione: 'Post',
          codifica: 'rear',
          posizioneArb: 'Post',
          rigidezzaArb: 'ABCD1234',
          altezza: 24.0000,
        ),
        damperAnt: Damper(
          id: 4,
          posizione: 'Ant',
          lsr: 9.10,
          hsr: 10.00,
          lsc: 10.00,
          hsc: 10.00,
        ),
        damperPost: Damper(
          id: 2,
          posizione: 'Post',
          lsr: 9.10,
          hsr: 12.30,
          lsc: 4.50,
          hsc: -7.20,
        ),
      ),
      Setup(
        id: 4,
        ala: 'ala',
        note: 'note',
        wheelAntDx: Wheel(
          id: 5,
          codifica: 'setup ant dxsdfsdfsdfsdfds',
          posizione: 'Ant dx',
          frontale: 'setup ant dx',
          superiore: 'setup ant dx',
          pressione: 2,
        ),
        wheelAntSx: Wheel(
          id: 6,
          codifica: 'setup ant sx',
          posizione: 'Ant sx',
          frontale: 'setup ant sx',
          superiore: 'setup ant sx',
          pressione: 11111.0000,
        ),
        wheelPostDx: Wheel(
          id: 2,
          codifica: 'setup post dx',
          posizione: 'Post dx',
          frontale: 'setup post dx',
          superiore: 'setup post dx',
          pressione: 123.4500,
        ),
        wheelPostSx: Wheel(
          id: 3,
          codifica: 'setup post sx',
          posizione: 'Post sx',
          frontale: 'setup post sx',
          superiore: 'setup post sx',
          pressione: 123.4500,
        ),
        balanceAnt: Balance(
          id: 4,
          posizione: 'Ant',
          frenata: 49.20,
          peso: 56.78,
        ),
        balancePost: Balance(
          id: 2,
          posizione: 'Post',
          frenata: 50.80,
          peso: 43.22,
        ),
        springAnt: Spring(
          id: 3,
          posizione: 'Ant',
          codifica: 'rear',
          posizioneArb: 'Ant',
          rigidezzaArb: 'ABCD1234',
          altezza: 30.0000,
        ),
        springPost: Spring(
          id: 1,
          posizione: 'Post',
          codifica: 'rear',
          posizioneArb: 'Post',
          rigidezzaArb: 'ABCD1234',
          altezza: 24.0000,
        ),
        damperAnt: Damper(
          id: 4,
          posizione: 'Ant',
          lsr: 9.10,
          hsr: 10.00,
          lsc: 10.00,
          hsc: 10.00,
        ),
        damperPost: Damper(
          id: 2,
          posizione: 'Post',
          lsr: 9.10,
          hsr: 12.30,
          lsc: 4.50,
          hsc: -7.20,
        ),
      ),
    ];
  }

  void modifySetup(Setup newSetup) {
    Setup setup = listSetups.where((element) => element.id == newSetup.id).first;

    setup.note = newSetup.note;
    setup.ala = newSetup.ala;
    setup.damperPost = newSetup.damperPost;
    setup.damperAnt = newSetup.damperAnt;
    setup.springPost = newSetup.springPost;
    setup.springAnt = newSetup.springAnt;
    setup.balancePost = newSetup.balancePost;
    setup.balanceAnt = newSetup.balanceAnt;
    setup.wheelPostSx = newSetup.wheelPostSx;
    setup.wheelPostDx = newSetup.wheelPostDx;
    setup.wheelAntSx = newSetup.wheelAntSx;
    setup.wheelAntDx = newSetup.wheelAntDx;
  }

  void createSetup(Setup newSetup) {
    listSetups.add(newSetup);
  }
}

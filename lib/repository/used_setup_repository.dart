import 'package:polimarche/model/UsedSetup.dart';
import '../model/Session.dart';
import '../model/Track.dart';
import '../model/Balance.dart';
import '../model/Damper.dart';
import '../model/Setup.dart';
import '../model/Spring.dart';
import '../model/Wheel.dart';

class UsedSetupRepository {
  late List<UsedSetup> listSetupsUsed;

  UsedSetupRepository() {
    listSetupsUsed = [
      UsedSetup(
          id: 1,
          sessione: Session(
              1,
              "Endurance",
              DateTime(2023, 8, 16, 10, 0),
              DateTime(2023, 8, 16, 10, 30),
              DateTime(2023, 8, 16, 11, 30),
              Track("Mugello", 5.12),
              "Sunny",
              1013.25,
              25.0,
              30.0,
              "Dry"),
          setup: Setup(
            id: 1,
            ala: 'ala',
            note: 'note',
            wheelAntDx: Wheel(
              id: 5,
              codifica: 'setup ant dx',
              posizione: 'Ant dx',
              frontale: 'setup ant dx',
              superiore: 'setup ant dx',
              pressione: 11111.0000,
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
              posizione: 'stiff',
              codifica: 'rear',
              posizioneArb: 'Ant',
              rigidezzaArb: 'ABCD1234',
              altezza: 30.0000,
            ),
            springPost: Spring(
              id: 1,
              posizione: 'stiff',
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
          commento: "Example commento")
    ];


  }

  void addNewUsedSetup(UsedSetup newUsedSetup) {
    listSetupsUsed.add(newUsedSetup);
  }
}

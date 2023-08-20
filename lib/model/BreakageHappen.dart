import 'package:polimarche/model/Breakage.dart';
import 'package:polimarche/model/Session.dart';

class BreakageHappen {
  int id;
  String descrizione;
  Session sessione;
  Breakage rottura;
  bool colpaPilota;

  BreakageHappen(
      this.id, this.descrizione, this.sessione, this.rottura, this.colpaPilota);
}

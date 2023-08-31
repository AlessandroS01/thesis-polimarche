import 'package:polimarche/model/driver_model.dart';
import 'package:polimarche/model/Session.dart';

class Participation {
  int id;
  Driver pilota;
  Session sessione;
  int ordine;
  String cambioPilota;

  Participation(
      this.id, this.pilota, this.sessione, this.ordine, this.cambioPilota);
}

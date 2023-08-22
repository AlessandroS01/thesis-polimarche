import 'package:polimarche/model/Session.dart';
import 'package:polimarche/model/Setup.dart';

class UsedSetup {
  late int id;
  late Session sessione;
  late Setup setup;
  late String commento;

  UsedSetup({
    required this.id,
    required this.sessione,
    required this.setup,
    required this.commento,
  });
}

import 'package:polimarche/model/session_model.dart';

class Comment {
  int id;
  String flag;
  String descrizione;
  Session sessione;

  Comment(this.id, this.flag, this.descrizione, this.sessione);
}

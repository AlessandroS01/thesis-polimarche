import 'package:polimarche/model/Breakage.dart';
import 'package:polimarche/model/Problem.dart';


class ProblemLeadBreakage {

  final int id;
  final Problem problem;
  final Breakage rottura;
  final String descrizione;

  ProblemLeadBreakage(this.id, this.problem, this.rottura, this.descrizione);
}
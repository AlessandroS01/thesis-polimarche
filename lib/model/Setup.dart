import 'package:polimarche/model/Wheel.dart';
import 'package:polimarche/model/Balance.dart';
import 'package:polimarche/model/Spring.dart';
import 'package:polimarche/model/Damper.dart';

class Setup {
  late int id;
  late String ala;
  late String note;
  late Wheel wheelAntDx;
  late Wheel wheelAntSx;
  late Wheel wheelPostDx;
  late Wheel wheelPostSx;
  late Balance balanceAnt;
  late Balance balancePost;
  late Spring springAnt;
  late Spring springPost;
  late Damper damperAnt;
  late Damper damperPost;

  Setup({
    required this.id,
    required this.ala,
    required this.note,
    required this.wheelAntDx,
    required this.wheelAntSx,
    required this.wheelPostDx,
    required this.wheelPostSx,
    required this.balanceAnt,
    required this.balancePost,
    required this.springAnt,
    required this.springPost,
    required this.damperAnt,
    required this.damperPost,
  });


}

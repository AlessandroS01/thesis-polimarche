import 'package:polimarche/model/balance_model.dart';
import 'package:polimarche/model/damper_model.dart';
import 'package:polimarche/model/spring_model.dart';
import 'package:polimarche/model/wheel_model.dart';

class Setup {
  final int id;
  final String ala;
  final String note;
  final Wheel wheelAntDx;
  final Wheel wheelAntSx;
  final Wheel wheelPostDx;
  final Wheel wheelPostSx;
  final Balance balanceAnt;
  final Balance balancePost;
  final Spring springAnt;
  final Spring springPost;
  final Damper damperAnt;
  final Damper damperPost;

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

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'ala': this.ala,
      'note': this.note,
      'wheelAntDx': this.wheelAntDx.toMap(this.wheelAntDx.id),
      'wheelAntSx': this.wheelAntSx.toMap(this.wheelAntSx.id),
      'wheelPostDx': this.wheelPostDx.toMap(this.wheelPostDx.id),
      'wheelPostSx': this.wheelPostSx.toMap(this.wheelPostSx.id),
      'balanceAnt': this.balanceAnt.toMap(this.balanceAnt.id),
      'balancePost': this.balancePost.toMap(this.balancePost.id),
      'springAnt': this.springAnt.toMap(this.springAnt.id),
      'springPost': this.springPost.toMap(this.springPost.id),
      'damperAnt': this.damperAnt.toMap(this.damperAnt.id),
      'damperPost': this.damperPost.toMap(this.damperPost.id),
    };
  }

  factory Setup.fromMap(Map<String, dynamic> map) {
    return Setup(
      id: map['id'] as int,
      ala: map['ala'] as String,
      note: map['note'] as String,
      wheelAntDx: Wheel.fromMap(map['wheelAntDx'] as Map<String, dynamic>),
      wheelAntSx: Wheel.fromMap(map['wheelAntSx'] as Map<String, dynamic>),
      wheelPostDx: Wheel.fromMap(map['wheelPostDx'] as Map<String, dynamic>),
      wheelPostSx: Wheel.fromMap(map['wheelPostSx'] as Map<String, dynamic>),
      balanceAnt: Balance.fromMap(map['balanceAnt'] as Map<String, dynamic>),
      balancePost: Balance.fromMap(map['balancePost'] as Map<String, dynamic>),
      springAnt: Spring.fromMap(map['springAnt'] as Map<String, dynamic>),
      springPost: Spring.fromMap(map['springPost'] as Map<String, dynamic>),
      damperAnt: Damper.fromMap(map['damperAnt'] as Map<String, dynamic>),
      damperPost: Damper.fromMap(map['damperPost'] as Map<String, dynamic>),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:polimarche/model/Wheel.dart';

class WheelProvider with ChangeNotifier {

  late Wheel? _frontRight;
  bool _existingFrontRight = true;

  bool get existingFrontRight => _existingFrontRight;

  set existingFrontRight(bool value) {
    _existingFrontRight = value;
  }

  late Wheel _frontLeft;
  late Wheel _rearRight;
  late Wheel _rearLeft;


  WheelProvider(
      this._frontRight, this._frontLeft, this._rearRight, this._rearLeft);

  Wheel? get frontRight => _frontRight;

  set frontRight(Wheel? value) {
    _frontRight = value;
  }

  Wheel get frontLeft => _frontLeft;

  set frontLeft(Wheel value) {
    _frontLeft = value;
  }

  Wheel get rearRight => _rearRight;

  set rearRight(Wheel value) {
    _rearRight = value;
  }

  Wheel get rearLeft => _rearLeft;

  set rearLeft(Wheel value) {
    _rearLeft = value;
  }
}

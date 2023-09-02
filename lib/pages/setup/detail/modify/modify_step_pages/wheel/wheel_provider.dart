import 'package:flutter/material.dart';
import 'package:polimarche/model/wheel_model.dart';

class WheelProvider with ChangeNotifier {
  late Wheel? _frontRight;
  bool _existingFrontRight = true;

  late Wheel? _frontLeft;
  bool _existingFrontLeft = true;

  late Wheel? _rearRight;
  bool _existingRearRight = true;

  late Wheel? _rearLeft;
  bool _existingRearLeft = true;

  WheelProvider(
      this._frontRight, this._frontLeft, this._rearRight, this._rearLeft);

  Wheel? get frontRight => _frontRight;

  set frontRight(Wheel? value) {
    _frontRight = value;
  }

  bool get existingFrontRight => _existingFrontRight;

  set existingFrontRight(bool value) {
    _existingFrontRight = value;
  }

  Wheel? get frontLeft => _frontLeft;

  set frontLeft(Wheel? value) {
    _frontLeft = value;
  }

  bool get existingFrontLeft => _existingFrontLeft;

  set existingFrontLeft(bool value) {
    _existingFrontLeft = value;
  }

  Wheel? get rearRight => _rearRight;

  set rearRight(Wheel? value) {
    _rearRight = value;
  }

  bool get existingRearRight => _existingRearRight;

  set existingRearRight(bool value) {
    _existingRearRight = value;
  }

  Wheel? get rearLeft => _rearLeft;

  set rearLeft(Wheel? value) {
    _rearLeft = value;
  }

  bool get existingRearLeft => _existingRearLeft;

  set existingRearLeft(bool value) {
    _existingRearLeft = value;
  }
}

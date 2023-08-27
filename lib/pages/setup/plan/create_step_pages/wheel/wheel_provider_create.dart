import 'package:flutter/material.dart';
import 'package:polimarche/model/Wheel.dart';

class WheelProviderCreate with ChangeNotifier {
  Wheel? _frontRight = null;
  bool _existingFrontRight = false;

  Wheel? _frontLeft = null;
  bool _existingFrontLeft = false;

  Wheel? _rearRight = null;
  bool _existingRearRight = false;

  Wheel? _rearLeft = null;
  bool _existingRearLeft = false;

  WheelProviderCreate();

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

import 'package:flutter/material.dart';
import 'package:polimarche/model/Wheel.dart';

import '../../../../../../model/Balance.dart';

class BalanceProvider with ChangeNotifier {
  late Balance? _front;
  bool _existingFront = true;

  late Balance? _rear;
  bool _existingRear = true;

  BalanceProvider(this._front, this._rear);

  bool get existingRear => _existingRear;

  set existingRear(bool value) {
    _existingRear = value;
  }

  Balance? get rear => _rear;

  set rear(Balance? value) {
    _rear = value;
  }

  bool get existingFront => _existingFront;

  set existingFront(bool value) {
    _existingFront = value;
  }

  Balance? get front => _front;

  set front(Balance? value) {
    _front = value;
  }
}

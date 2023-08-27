import 'package:flutter/material.dart';
import '../../../../../../model/Balance.dart';

class BalanceProviderCreate with ChangeNotifier {
  Balance? _front = null;
  bool _existingFront = false;

  Balance? _rear = null;
  bool _existingRear = false;

  BalanceProviderCreate();

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

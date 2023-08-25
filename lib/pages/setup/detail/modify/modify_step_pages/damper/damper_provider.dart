import 'package:flutter/material.dart';
import '../../../../../../model/Damper.dart';

class DamperProvider with ChangeNotifier {
  late Damper? _front;
  bool _existingFront = true;

  late Damper? _rear;
  bool _existingRear = true;

  DamperProvider(this._front, this._rear);

  bool get existingRear => _existingRear;

  set existingRear(bool value) {
    _existingRear = value;
  }

  Damper? get rear => _rear;

  set rear(Damper? value) {
    _rear = value;
  }

  bool get existingFront => _existingFront;

  set existingFront(bool value) {
    _existingFront = value;
  }

  Damper? get front => _front;

  set front(Damper? value) {
    _front = value;
  }
}

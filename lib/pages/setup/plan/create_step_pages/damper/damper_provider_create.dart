import 'package:flutter/material.dart';

import '../../../../../../model/damper_model.dart';

class DamperProviderCreate with ChangeNotifier {
  Damper? _front = null;
  bool _existingFront = false;

  Damper? _rear = null;
  bool _existingRear = false;

  DamperProviderCreate();

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

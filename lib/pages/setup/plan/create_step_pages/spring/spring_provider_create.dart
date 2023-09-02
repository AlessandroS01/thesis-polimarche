import 'package:flutter/material.dart';

import '../../../../../../model/spring_model.dart';

class SpringProviderCreate with ChangeNotifier {
  Spring? _front = null;
  bool _existingFront = false;

  Spring? _rear = null;
  bool _existingRear = false;

  SpringProviderCreate();

  bool get existingRear => _existingRear;

  set existingRear(bool value) {
    _existingRear = value;
  }

  Spring? get rear => _rear;

  set rear(Spring? value) {
    _rear = value;
  }

  bool get existingFront => _existingFront;

  set existingFront(bool value) {
    _existingFront = value;
  }

  Spring? get front => _front;

  set front(Spring? value) {
    _front = value;
  }
}

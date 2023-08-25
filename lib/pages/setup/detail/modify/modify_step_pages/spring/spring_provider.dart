import 'package:flutter/material.dart';
import '../../../../../../model/Spring.dart';

class SpringProvider with ChangeNotifier {
  late Spring? _front;
  bool _existingFront = true;

  late Spring? _rear;
  bool _existingRear = true;

  SpringProvider(this._front, this._rear);

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

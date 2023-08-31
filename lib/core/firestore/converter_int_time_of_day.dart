import 'package:flutter/material.dart';

class FirestoreIntTimeOfDayConverter {
  static String timeOfDayToString(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static TimeOfDay stringToTimeOfDay(String timeString) {
    final List<String> components = timeString.split(':');
    final int hour = int.parse(components[0]);
    final int minute = int.parse(components[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}

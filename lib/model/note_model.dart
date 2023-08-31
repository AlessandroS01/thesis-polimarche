import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/firestore/converter_int_time_of_day.dart';
import '../core/firestore/converter_timestamp_datetime.dart';

class Note {
  DateTime data;
  TimeOfDay ora_inizio;
  TimeOfDay ora_fine;
  int matricola;
  String descrizione;

  Note(
      {required this.data,
      required this.ora_inizio,
      required this.ora_fine,
      required this.matricola,
      required this.descrizione});

  Map<String, dynamic> toMap() {
    return {
      'matricola': matricola,
      'descrizione': descrizione,
      'data': Timestamp.fromDate(data),
      'inizio': FirestoreIntTimeOfDayConverter.timeOfDayToString(ora_inizio),
      'fine': FirestoreIntTimeOfDayConverter.timeOfDayToString(ora_fine),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      data: FirestoreTimestampDatetimeConverter.fromTimestamp(map['data'] as Timestamp),
      ora_inizio: FirestoreIntTimeOfDayConverter.stringToTimeOfDay( map['inizio'] as String),
      ora_fine: FirestoreIntTimeOfDayConverter.stringToTimeOfDay( map['fine'] as String),
      matricola: map['matricola'] as int,
      descrizione: map['descrizione'] as String,
    );
  }
}

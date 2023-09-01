import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/firestore/converter_int_time_of_day.dart';
import '../core/firestore/converter_timestamp_datetime.dart';
import 'track_model.dart';

class Session {
  final int? uid;
  final String evento;
  final DateTime data;
  final TimeOfDay oraInizio;
  final TimeOfDay oraFine;
  final Track tracciato;
  final String meteo;
  final double pressioneAtmosferica;
  final double temperaturaAria;
  final double temperaturaTracciato;
  final String condizioneTracciato;

  Session(
      {required this.uid,
      required this.evento,
      required this.data,
      required this.oraInizio,
      required this.oraFine,
      required this.tracciato,
      required this.meteo,
      required this.pressioneAtmosferica,
      required this.temperaturaAria,
      required this.temperaturaTracciato,
      required this.condizioneTracciato,
      });

  Map<String, dynamic> toMap() {
    return {
      'evento': this.evento,
      'data': Timestamp.fromDate(data),
      'inizio': FirestoreIntTimeOfDayConverter.timeOfDayToString(oraInizio),
      'fine': FirestoreIntTimeOfDayConverter.timeOfDayToString(oraFine),
      'tracciato': this.tracciato.toMap(),
      'meteo': this.meteo,
      'pressioneAtmosferica': this.pressioneAtmosferica,
      'temperaturaAria': this.temperaturaAria,
      'temperaturaTracciato': this.temperaturaTracciato,
      'condizioneTracciato': this.condizioneTracciato,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map, String uidDoc) {
    return Session(
      uid: int.parse(uidDoc),
      evento: map['evento'] as String,
      data: FirestoreTimestampDatetimeConverter.fromTimestamp(map['data'] as Timestamp),
      oraInizio: FirestoreIntTimeOfDayConverter.stringToTimeOfDay( map['inizio'] as String),
      oraFine: FirestoreIntTimeOfDayConverter.stringToTimeOfDay( map['fine'] as String),
      tracciato: Track.fromMap(map['tracciato'] as Map<String, dynamic>),
      meteo: map['meteo'] as String,
      pressioneAtmosferica: map['pressioneAtmosferica']  is double ? map['pressioneAtmosferica'] as double : (map['pressioneAtmosferica'] as int).toDouble(),
      temperaturaAria: map['temperaturaAria']  is double ? map['temperaturaAria'] as double : (map['temperaturaAria'] as int).toDouble(),
      temperaturaTracciato: map['temperaturaTracciato']  is double ? map['temperaturaTracciato'] as double : (map['temperaturaTracciato'] as int).toDouble(),
      condizioneTracciato: map['condizioneTracciato'] as String,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polimarche/model/session_model.dart';

import '../core/firestore/converter_int_time_of_day.dart';
import '../model/note_model.dart';
import '../model/track_model.dart';

class SessionRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Session>> getSessions() async {
    try {
      List<Session> sessions = [];

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('session').get();

      if (snapshot.size != 0) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Session.fromMap(data, doc.id);
        }).toList();
      } else {
        // Handle the case where there are no documents in the collection
        return sessions; // Return an empty list or handle it as needed
      }
    } catch (error, stackTrace) {
      // Handle the error here
      print('Error fetching sessions: $error');
      print('Stack trace: $stackTrace');
      // You can also throw the error or return an empty list as needed
      throw error;
    }
  }

  Future<void> addSession(
      String event,
      DateTime newDate,
      TimeOfDay newStartingTime,
      TimeOfDay newEndingTime,
      Track newTrack,
      String meteo,
      String pressioneAtmosferica,
      String temperaturaAria,
      String temperaturaTracciato,
      String condizioneTracciato) async {
    Session newSession = Session(
        uid: null,
        evento: event,
        data: newDate,
        oraInizio: newStartingTime,
        oraFine: newEndingTime,
        tracciato: newTrack,
        meteo: meteo,
        pressioneAtmosferica: double.parse(pressioneAtmosferica),
        temperaturaAria: double.parse(temperaturaAria),
        temperaturaTracciato: double.parse(temperaturaTracciato),
        condizioneTracciato: condizioneTracciato);

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('session').get();

    int maxId = 1;
    if (snapshot.size != 0) {
      snapshot.docs.forEach((data) {
        maxId = int.parse(data.id);
      });
    }
    await _firestore
        .collection('session')
        .doc((maxId + 1).toString())
        .set(newSession.toMap());
  }

  Future<Session> getSessionsById(int? uid) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('session').doc(uid.toString()).get();

    return Session.fromMap(documentSnapshot.data()!, uid.toString());
  }

  Future<void> modifySession(
      int? uid,
      String event,
      DateTime newDate,
      TimeOfDay newStartingTime,
      TimeOfDay newEndingTime,
      Track newTrack,
      String meteo,
      String pressioneAtmosferica,
      String temperaturaAria,
      String temperaturaTracciato,
      String condizioneTracciato) async {
    if (uid != null) {
      // Create a map of fields to update
      Map<String, dynamic> updatedData = {
        'evento': event,
        'data': Timestamp.fromDate(newDate),
        'inizio':
            FirestoreIntTimeOfDayConverter.timeOfDayToString(newStartingTime),
        'fine': FirestoreIntTimeOfDayConverter.timeOfDayToString(newEndingTime),
        'tracciato': newTrack.toMap(),
        'meteo': meteo,
        'pressioneAtmosferica': double.parse(pressioneAtmosferica),
        'temperaturaAria': double.parse(temperaturaAria),
        'temperaturaTracciato': double.parse(temperaturaTracciato),
        'condizioneTracciato': condizioneTracciato,
      };

      // Update the document with the new data
      await _firestore
          .collection('session')
          .doc(uid.toString())
          .update(updatedData);
    }
  }
}

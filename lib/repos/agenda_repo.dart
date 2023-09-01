import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/firestore/converter_int_time_of_day.dart';
import '../model/note_model.dart';

class AgendaRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Member] saved in firebase with uid specified if exists or null
  Future<List<Note>> getNotesByMemberMatricola(int matricola) async {
    List<Note> notes = List.empty();

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('agenda')
        .where('matricola', isEqualTo: matricola)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Note.fromMap(data, doc.id);
      }).toList();
    }

    return notes;
  }

  Future<void> addNewNote(int matricola, String descrizione, DateTime data,
      TimeOfDay inizio, TimeOfDay fine) async {
    Note newNote = Note(
        data: data,
        ora_inizio: inizio,
        ora_fine: fine,
        matricola: matricola,
        descrizione: descrizione,
        uid: null);
    // Add the note to the 'agenda' collection
    await _firestore.collection('agenda').add(newNote.toMap());
  }

  Future<void> modifyNote(String? uid, String description, DateTime newDate,
      TimeOfDay oraInizio, TimeOfDay oraFine) async {

    if (uid != null) {
      // Create a map of fields to update
      Map<String, dynamic> updatedData = {
        'descrizione': description,
        'data': Timestamp.fromDate(newDate),
        'inizio': FirestoreIntTimeOfDayConverter.timeOfDayToString(oraInizio),
        'fine': FirestoreIntTimeOfDayConverter.timeOfDayToString(oraFine),
      };

      // Update the document with the new data
      await _firestore.collection('agenda').doc(uid).update(updatedData);
    }
  }

  Future<void> deleteNote(String? uid) async {
    if (uid != null) {
      await _firestore.collection('agenda').doc(uid).delete();
    }
  }
}

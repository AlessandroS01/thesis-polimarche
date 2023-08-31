
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/note_model.dart';

class AgendaRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// return [Member] saved in firebase with uid specified if exists or null
  Future<List<Note>> getNotesByMemberMatricola(int matricola) async {
    List<Note> notes = List.empty();

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('agenda')
        .where('matricola', isEqualTo: matricola)
        .get();

    if (snapshot.size != 0) {
      return snapshot.docs.map((doc) {
      final data = doc.data();
      return Note.fromMap(data);
    }).toList();
    }
    return notes;
  }

  Future<void> addNewNote(int matricola, String descrizione, DateTime data, TimeOfDay inizio, TimeOfDay fine) async {

    Note newNote = Note(data: data, ora_inizio: inizio, ora_fine: fine, matricola: matricola, descrizione: descrizione);
    // Add the note to the 'agenda' collection
    await _firestore.collection('agenda').add(newNote.toMap());
  }


}
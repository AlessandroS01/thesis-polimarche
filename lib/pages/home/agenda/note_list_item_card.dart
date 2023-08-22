import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/inherited_widgets/agenda_state.dart';
import 'package:polimarche/model/Note.dart';
import 'package:intl/intl.dart';
import 'package:polimarche/services/note_service.dart';

class CardNoteListItem extends StatefulWidget {
  final Note note;
  final VoidCallback updateStateAgendaPage;
  final NoteService noteService;

  const CardNoteListItem(
      {required this.note, required this.updateStateAgendaPage, required this.noteService});

  @override
  State<CardNoteListItem> createState() => _CardNoteListItemState();
}

class _CardNoteListItemState extends State<CardNoteListItem> {
  bool isModificaPressed = false;
  bool isCancellaPressed = false;

  late final Note note;
  late final NoteService noteService;
  late final VoidCallback updateStateAgendaPage;

  final backgroundColor = Colors.grey.shade300;

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    note = widget.note;
    noteService = widget.noteService;
    updateStateAgendaPage = widget.updateStateAgendaPage;

    _textFieldController.text = note.descrizione;
  }

  @override
  Widget build(BuildContext context) {

    Offset distanceModifica = isModificaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurModifica = isModificaPressed ? 5 : 10;
    Offset distanceCancella = isCancellaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurCancella = isCancellaPressed ? 5 : 10;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(12),
        ),
        color: backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(5, 5),
              blurRadius: 15,
              inset: false),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 10,
              inset: false),
        ],
      ),
      child: Column(
        children: [
          Text(
            "${note.descrizione}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            "${DateFormat('EEEE, MMM d, yyyy').format(note.data)}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 2),
          Text("${DateFormat('HH:mm:ss').format(note.ora_inizio)} "
              "- ${DateFormat('HH:mm:ss').format(note.ora_fine)}"),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _modificaButton(distanceModifica, blurModifica),
              _cancellaButton(distanceCancella, blurCancella),
            ],
          )
        ],
      ),
    );
  }

  Listener _cancellaButton(Offset distanceCancella, double blurCancella) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isCancellaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation
        setState(() => isCancellaPressed = false); // Reset the state,

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Conferma eliminazione"),
            content: const Text("Sei sicuro di voler eliminare la nota?"),
            actions: <Widget>[
              TextButton(
                child: Text("Cancella"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("Conferma"),
                onPressed: () {
                  noteService.deleteNote(note);

                  updateStateAgendaPage();

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isCancellaPressed
                ? [
                    BoxShadow(
                        offset: distanceCancella,
                        blurRadius: blurCancella,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distanceCancella,
                        blurRadius: blurCancella,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(children: [
          Text(
            "Cancella",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.delete_forever,
            color: Colors.black,
          )
        ]),
      ),
    );
  }

  Listener _modificaButton(Offset distanceModifica, double blurModifica) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isModificaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation
        setState(() => isModificaPressed = false); // Reset the state,

        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: note.data,
            firstDate: DateTime(note.data.year),
            lastDate: DateTime(note.data.year + 3));

        if (newDate != null) {
          TimeOfDay? oraInizio = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: note.ora_inizio.hour, minute: note.ora_inizio.minute));

          if (oraInizio != null) {
            TimeOfDay? oraFine = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                    hour: note.ora_fine.hour, minute: note.ora_fine.minute));

            if (oraFine != null) {
              if (isTimeOfDayEarlier(oraInizio, oraFine)) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Nuova descrizione"),
                    content: TextField(
                      controller: _textFieldController,
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancella"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text("Conferma"),
                        onPressed: () {
                          noteService.modifyNote(note, newDate, oraInizio,
                              oraFine, _textFieldController.text);

                          updateStateAgendaPage();

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                showToast(
                    "L'ora di inizio deve essere precedente all'ora di fine.");
              }
            }
          } else
            return;
        } else
          return;
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isModificaPressed
                ? [
                    BoxShadow(
                        offset: distanceModifica,
                        blurRadius: blurModifica,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distanceModifica,
                        blurRadius: blurModifica,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(children: [
          Text(
            "Modifica",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.event_note,
            color: Colors.black,
          )
        ]),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength:
          Toast.LENGTH_SHORT, // Duration for which the toast will be displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
      backgroundColor: Colors.grey[600], // Background color of the toast
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }

  bool isTimeOfDayEarlier(TimeOfDay time1, TimeOfDay time2) {
    if (time1.hour < time2.hour) {
      return true;
    } else if (time1.hour == time2.hour) {
      return time1.minute < time2.minute;
    } else {
      return false;
    }
  }
}

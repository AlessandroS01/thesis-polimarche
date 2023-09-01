import 'dart:async';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/note_model.dart';
import 'package:intl/intl.dart';
import 'package:polimarche/service/agenda_service.dart';

class CardNoteListItem extends StatefulWidget {
  final Note note;
  final AgendaService agendaService;
  final Future<void> Function() updateStateAgenda;

  const CardNoteListItem(
      {required this.note,
      required this.agendaService,
      required this.updateStateAgenda});

  @override
  State<CardNoteListItem> createState() => _CardNoteListItemState();
}

class _CardNoteListItemState extends State<CardNoteListItem> {
  bool isModificaPressed = false;
  bool isCancellaPressed = false;

  late Note note;
  late AgendaService _agendaService;
  late Future<void> Function() updateStateAgenda;

  final backgroundColor = Colors.grey.shade300;

  TextEditingController _controllerNewDescription = TextEditingController();

  // Called once when the widget is first built and added to the widget tree
  @override
  void initState() {
    super.initState();
    note = widget.note;
    _controllerNewDescription =
        TextEditingController(text: widget.note.descrizione);

    _agendaService = widget.agendaService;
    updateStateAgenda = widget.updateStateAgenda;
  }

  // Called when the parent widget provides new values to this widget or, generally,
  // when the widget should be rebuilt with new widget properties
  @override
  void didUpdateWidget(covariant CardNoteListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.note.uid != oldWidget.note.uid) {
      note = widget.note;
      _controllerNewDescription.text = widget.note.descrizione;
    }
  }

  DateTime _fromTimeOfDayToDatetime(TimeOfDay time) {
    DateTime currentDate =
        DateTime.now(); // You can replace this with the desired date

    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      time.hour,
      time.minute,
    );
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
          Text(
            "${DateFormat('HH:mm:ss').format(_fromTimeOfDayToDatetime(note.ora_inizio))} - ${DateFormat('HH:mm:ss').format(_fromTimeOfDayToDatetime(note.ora_fine))}",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(height: 2),
          //Text("${DateFormat('HH:mm:ss').format(note.ora_inizio)} "
          //    "- ${DateFormat('HH:mm:ss').format(note.ora_fine)}"),
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
            title: Center(child: const Text("CONFERMA ELIMINAZIONE")),
            content: const Text("Sei sicuro di voler eliminare la nota?"),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  "INDIETRO",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  "CONFERMA",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  await _agendaService.deleteNote(note.uid);

                  updateStateAgenda();

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
            builder: (context, child) {
              return Theme(
                data: ThemeData(
                  fontFamily: "aleo",
                  textTheme:
                      Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
                  colorScheme: ColorScheme.light(
                    primary: Colors.black, // Calendar header color
                    onPrimary: Colors.white,
                    surface: Colors.white, // Dialog background color
                    onSurface: Colors.black, // Dialog background color
                  ),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: note.data,
            firstDate: DateTime(note.data.year),
            lastDate: DateTime(note.data.year + 3));

        if (newDate != null) {
          TimeOfDay? oraInizio = await showTimePicker(
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    fontFamily: "aleo",
                    textTheme:
                        Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
                    colorScheme: ColorScheme.light(
                      primary: Colors.black, // Calendar header color
                      onPrimary: Colors.white,
                      surface: Colors.white, // Dialog background color
                      onSurface: Colors.black, // Dialog background color
                    ),
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
              context: context,
              initialTime: TimeOfDay(
                  hour: note.ora_inizio.hour, minute: note.ora_inizio.minute));

          if (oraInizio != null) {
            TimeOfDay? oraFine = await showTimePicker(
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      fontFamily: "aleo",
                      textTheme:
                          Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
                      colorScheme: ColorScheme.light(
                        primary: Colors.black, // Calendar header color
                        onPrimary: Colors.white,
                        surface: Colors.white, // Dialog background color
                        onSurface: Colors.black, // Dialog background color
                      ),
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
                context: context,
                initialTime: TimeOfDay(
                    hour: note.ora_fine.hour, minute: note.ora_fine.minute));

            if (oraFine != null) {
              if (isTimeOfDayEarlier(oraInizio, oraFine)) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Center(child: const Text("NUOVA DESCRIZIONE")),
                    content: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'aleo',
                          letterSpacing: 1),
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: 'Descrizione',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      controller: _controllerNewDescription,
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          "CANCELLA",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          "CONFERMA",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          try {
                            await _agendaService.modifyNote(
                                note.uid,
                                _controllerNewDescription.text,
                                newDate,
                                oraInizio,
                                oraFine);

                            updateStateAgenda();

                            Navigator.pop(context);
                          } catch (e) {
                            // Handle the error here
                            print("Error adding new note: $e");
                            // You can also show a snackbar or dialog to inform the user about the error
                          }
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

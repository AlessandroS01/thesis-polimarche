import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/Note.dart';
import 'package:polimarche/pages/home/agenda/note_list_item_card.dart';
import 'package:polimarche/services/note_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../inherited_widgets/agenda_state.dart';
import '../../../inherited_widgets/authorization_provider.dart';
import '../../../model/Member.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late Member loggedMember;

  final backgroundColor = Colors.grey.shade300;
  bool isAddPressed = false;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;

  late final NoteService noteService;
  late List<Note> _notesForSelectedDay = [];

  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();

  // return all the different events by date
  List<Note> _getEventsByDate(DateTime day) {
    return noteService.getNotesByMemberMatricolaDuringDay(
        loggedMember.matricola, day);
  }

  void updateState() {
    setState(() {
      return;
    });
  }

  // called whenever the user change the focused day
  void changeDateSelected(selectDay, focusedDay) {
    setState(() {
      selectedDay = selectDay;
      today = focusedDay;

      _notesForSelectedDay = noteService.getNotesByMemberMatricolaDuringDay(
          loggedMember.matricola, today);
    });
  }

  @override
  void initState() {
    noteService = NoteService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loggedMember = AuthorizationProvider.of(context)!.loggedMember;

    _notesForSelectedDay = noteService.getNotesByMemberMatricolaDuringDay(
        loggedMember.matricola, selectedDay);

    return AgendaInheritedState(
      noteService: noteService, // extends an inherited widget
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),

              // CALENDAR
              _calendar(),

              SizedBox(height: 10),

              Expanded(
                flex: 2,
                child: Container(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll
                          .disallowIndicator(); // Disable the overscroll glow effect
                      return false;
                    },
                    child: ListView.builder(
                        itemCount: _notesForSelectedDay.length,
                        itemBuilder: (context, index) {
                          final element = _notesForSelectedDay[index];
                          return CardNoteListItem(
                              note: element,
                              updateStateAgendaPage: updateState);
                        }),
                  ),
                ),
              ),

              _newNoteButton(backgroundColor, distanceAdd, blurAdd)
            ],
          ),
        ),
      ),
    );
  }

  Align _newNoteButton(
      Color backgroundColor, Offset distanceAdd, double blurAdd) {
    TextEditingController _textFieldController = TextEditingController();
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Listener(
              onPointerDown: (_) async {
                setState(() => isAddPressed = true); // Reset the state
                await Future.delayed(
                    const Duration(milliseconds: 200)); // Wait for animation
                setState(() => isAddPressed = false); // Reset the state,

                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: today,
                    firstDate: DateTime(today.year),
                    lastDate: DateTime(today.year + 3));

                if (newDate != null) {
                  TimeOfDay? oraInizio = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 0, minute: 0));

                  if (oraInizio != null) {
                    TimeOfDay? oraFine = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 0, minute: 0));

                    if (oraFine != null) {
                      if (isTimeOfDayEarlier(oraInizio, oraFine)) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Descrizione"),
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
                                  noteService.createNote(
                                      loggedMember,
                                      newDate,
                                      oraInizio,
                                      oraFine,
                                      _textFieldController.text);

                                  updateState();

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
                    } else
                      return;
                  } else
                    return;
                }
              },
              child: AnimatedContainer(
                padding: EdgeInsets.all(10),
                duration: Duration(milliseconds: 150),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: isAddPressed
                        ? []
                        : [
                            BoxShadow(
                                offset: distanceAdd,
                                blurRadius: blurAdd,
                                color: Colors.grey.shade500),
                            BoxShadow(
                                offset: -distanceAdd,
                                blurRadius: blurAdd,
                                color: Colors.white),
                          ]),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 27,
                ),
              ),
            )));
  }

  Container _calendar() {
    return Container(
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: today,
        startingDayOfWeek: StartingDayOfWeek.monday,
        eventLoader: _getEventsByDate,
        headerStyle:
            HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: changeDateSelected,
        calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayTextStyle: TextStyle(color: Colors.black),
            todayDecoration: BoxDecoration(
                color: Colors.grey.shade400, shape: BoxShape.circle),
            selectedTextStyle: TextStyle(color: Colors.white),
            selectedDecoration: BoxDecoration(
                color: Colors.grey.shade600, shape: BoxShape.circle),
            markerSize: 5,
            markersMaxCount: 5,
            markersAlignment: Alignment.center),
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

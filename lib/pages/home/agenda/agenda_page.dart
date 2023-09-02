import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/note_model.dart';
import 'package:polimarche/pages/home/agenda/note_list_item_card.dart';
import 'package:polimarche/service/agenda_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/member_model.dart';

class AgendaPage extends StatefulWidget {
  final Member loggedMember;

  const AgendaPage({super.key, required this.loggedMember});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final backgroundColor = Colors.grey.shade300;
  bool isAddPressed = false;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;

  late Member loggedMember;

  late final AgendaService _agendaService;
  List<Note> _notes = [];
  List<Note> _notesForSelectedDay = [];

  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  Future<void> _getNotesByMember() async {
    _notes =
        await _agendaService.getNotesByMemberMatricola(loggedMember.matricola);

    changeDateSelected(selectedDay, today);
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getNotesByMember(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
      changeDateSelected(selectedDay, today);
    });
  }

  // return all the different events by date => table calendar loading method
  List<Note> _getEventsByDate(DateTime day) {
    return _notes.where((note) => isSameDay(note.data, day)).toList();
  }

  // called whenever the user change the focused day
  void changeDateSelected(selectDay, focusedDay) {
    setState(() {
      selectedDay = selectDay;

      _notesForSelectedDay = _getEventsByDate(selectedDay);
    });
  }

  @override
  void initState() {
    super.initState();
    loggedMember = widget.loggedMember;
    _agendaService = AgendaService();
    _dataLoading = _getNotesByMember();

    _notesForSelectedDay = _getEventsByDate(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
            future: _dataLoading,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  _isDataLoading) {
                // Return a loading indicator if still waiting for data
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                return Container(
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
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
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
                                  return CardNoteListItem(note: element, agendaService: _agendaService, updateStateAgenda: _refreshState);
                                }),
                          ),
                        ),
                      ),

                      _newNoteButton()
                    ],
                  ),
                );
              }
            }));
  }

  Align _newNoteButton() {
    TextEditingController _controllerDescriptionNewNote =
        TextEditingController();
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 15, 20, 15),
          child: Listener(
            onPointerDown: (_) async {
              setState(() => isAddPressed = true); // Reset the state
              await Future.delayed(
                  const Duration(milliseconds: 200)); // Wait for animation
              setState(() => isAddPressed = false); // Reset the state,

              DateTime? newDate = await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        fontFamily: "aleo",
                        textTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: 'aleo'),
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
                  initialDate: today,
                  firstDate: DateTime(today.year),
                  lastDate: DateTime(today.year + 3));

              if (newDate != null) {
                TimeOfDay? oraInizio = await showTimePicker(
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          fontFamily: "aleo",
                          textTheme: Theme.of(context)
                              .textTheme
                              .apply(fontFamily: 'aleo'),
                          colorScheme: ColorScheme.light(
                            primary: Colors.black, // Calendar header color
                            onPrimary: Colors.white,
                            surface: Colors.white, // Dialog background color
                            onSurface: Colors.black, // Dialog background color
                          ),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialTime: TimeOfDay(hour: 0, minute: 0));

                if (oraInizio != null) {
                  TimeOfDay? oraFine = await showTimePicker(
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            fontFamily: "aleo",
                            textTheme: Theme.of(context)
                                .textTheme
                                .apply(fontFamily: 'aleo'),
                            colorScheme: ColorScheme.light(
                              primary: Colors.black, // Calendar header color
                              onPrimary: Colors.white,
                              surface: Colors.white, // Dialog background color
                              onSurface:
                                  Colors.black, // Dialog background color
                            ),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialTime: TimeOfDay(hour: 0, minute: 0));

                  if (oraFine != null) {
                    if (isTimeOfDayEarlier(oraInizio, oraFine)) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Center(child: const Text("DESCRIZIONE")),
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
                            controller: _controllerDescriptionNewNote,
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: Text(
                                "CONFERMA",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () async {
                                try {
                                  await _agendaService.addNewNote(
                                    loggedMember.matricola,
                                    _controllerDescriptionNewNote.text,
                                    newDate,
                                    oraInizio,
                                    oraFine,
                                  );
                                  _refreshState();

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
          ),
        ));
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

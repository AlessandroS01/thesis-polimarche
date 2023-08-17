import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/Note.dart';
import 'package:polimarche/pages/home/cards/note_list_item_card.dart';
import 'package:polimarche/services/note_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../inherited_widgets/agenda_state.dart';


class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}


class _AgendaPageState extends State<AgendaPage> {

  bool isAddPressed = false;

  late final NoteService noteService;
  late List<Note> _notesForSelectedDay = [];

  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();



  // return all the different events by date
  List<Note> _getEventsByDate(DateTime day) {
    return noteService.getNotesByMemberMatricolaDuringDay(21, day) ?? [];
  }

  // called whenever the user change the focused day
  void changeDateSelected(selectDay, focusedDay){
    setState(() {
      selectedDay = selectDay;
      today = focusedDay;

      _notesForSelectedDay =
          noteService.getNotesByMemberMatricolaDuringDay(21, today);
    });
  }

  @override
  void initState() {
    noteService = NoteService();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _notesForSelectedDay =
        noteService.getNotesByMemberMatricolaDuringDay(21, selectedDay);

    final backgroundColor = Colors.grey.shade300;
    Offset distanceAdd = isAddPressed ? Offset(5, 5) : Offset(6, 6);
    double blurAdd = isAddPressed ? 5 : 8;

    return AgendaInheritedState(
      noteService: noteService,// extends an inherited widget
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 25),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                  "Agenda",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
              ),
              SizedBox(height: 10),

              // CALENDAR
              _calendar(),

              SizedBox(height: 10),


              Expanded(
                flex: 2,
                child: Container(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator(); // Disable the overscroll glow effect
                      return false;
                    },
                    child: ListView.builder(
                        itemCount: _notesForSelectedDay.length,
                        itemBuilder: (context, index) {
                          final element = _notesForSelectedDay[index];
                          return CardNoteListItem(note: element);
                        }
                    ),
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

  Align _newNoteButton(Color backgroundColor, Offset distanceAdd, double blurAdd) {
    return Align(
                alignment:Alignment.bottomRight,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Listener(
                      onPointerDown: (_) async {
                        setState(() => isAddPressed = true); // Reset the state
                        await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation

                        setState(() => isAddPressed = false); // Reset the state,
                      },
                      child: AnimatedContainer(
                        padding: EdgeInsets.all(10),
                        duration: Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: distanceAdd,
                                  blurRadius: blurAdd,
                                  color: Colors.grey.shade500,
                                  inset: isAddPressed
                              ),
                              BoxShadow(
                                  offset: -distanceAdd,
                                  blurRadius: blurAdd,
                                  color: Colors.white,
                                  inset: isAddPressed
                              ),
                            ]
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                    )
                )
            );
  }

  Container _calendar() {
    return Container(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: today,
              startingDayOfWeek: StartingDayOfWeek.monday,

              eventLoader: _getEventsByDate,

              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true
              ),

              availableGestures: AvailableGestures.all,

              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: changeDateSelected,

              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayTextStyle: TextStyle(
                  color: Colors.black
                ),
                /*
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle
                ),
                */
                selectedTextStyle: TextStyle(
                  color: Colors.white
                ),
                /*
                selectedDecoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  shape: BoxShape.circle
                ),

                 */
                markerSize: 5,
                markersMaxCount: 5,
                markersAlignment: Alignment.center

              ),

            ),
          );
  }
}


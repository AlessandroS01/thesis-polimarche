import 'package:flutter/material.dart';
import 'package:polimarche/model/Note.dart';
import 'package:polimarche/services/NoteService.dart';
import 'package:table_calendar/table_calendar.dart';


class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}


class _AgendaPageState extends State<AgendaPage> {

  late final NoteService noteService;
  List<Note> _notesForSelectedDay = [];

  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    noteService = NoteService();

    _notesForSelectedDay =
        noteService.getNotesByMemberMatricolaDuringDay(21, today);

    super.initState();
  }

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
  Widget build(BuildContext context) {

    return SafeArea(
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

            SizedBox(height: 30),


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
                        return ListTile(title: Text(_notesForSelectedDay[index].descrizione));
                      }
                  ),
                ),
              ),
            ),
            
            Align(
                alignment:Alignment.bottomRight,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("A"))
            )
          ],
        ),
      ),
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
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  shape: BoxShape.circle
                ),
                markerSize: 5,
                markersMaxCount: 5,
                markerDecoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  shape: BoxShape.circle
                ),
                markersAlignment: Alignment.center
              ),

            ),
          );
  }
}


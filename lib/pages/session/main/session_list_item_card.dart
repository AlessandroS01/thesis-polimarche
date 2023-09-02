import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/session/detail/detail_page_session.dart';

import '../../../model/session_model.dart';

class CardSessionListItem extends StatefulWidget {
  final Session session;
  final Member loggedMember;
  final Future<void> Function() updateStateSessionPage;

  const CardSessionListItem({
    Key? key,
    required this.session,
    required this.loggedMember,
    required this.updateStateSessionPage,
  }) : super(key: key);

  @override
  State<CardSessionListItem> createState() => _CardSessionListItemState();
}

class _CardSessionListItemState extends State<CardSessionListItem> {
  bool isVisualizzaPressed = false;

  late final Future<void> Function() updateStateSessionPage;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    updateStateSessionPage = widget.updateStateSessionPage;
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;

    final backgroundColor = Colors.grey.shade300;
    Offset distance = Offset(5, 5);
    double blur = 10;


    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(
              "${session.uid} - ${session.evento}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "${DateFormat('EEEE, MMM d, yyyy').format(session.data)}",
              style: TextStyle(fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Inizio: ${DateFormat('HH:mm:ss').format(_fromTimeOfDayToDatetime(session.oraInizio))}",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Fine: ${DateFormat('HH:mm:ss').format(_fromTimeOfDayToDatetime(session.oraFine))}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      _visualizeMemberButton(widget.loggedMember, session,
                          backgroundColor, distance, blur)
                    ]),
              ),
            ),
          ])),
    );
  }

  Listener _visualizeMemberButton(Member loggedMember, Session session,
      Color backgroundColor, Offset distance, double blur) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isVisualizzaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        // PASS THE SESSION TO THE NEXT WIDGET
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailSession(
                    loggedMember: loggedMember, session: session, updateSessionPage: updateStateSessionPage)));

        setState(() => isVisualizzaPressed = false); // Reset the state,
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isVisualizzaPressed
                ? [
                    BoxShadow(
                        offset: distance,
                        blurRadius: blur,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distance,
                        blurRadius: blur,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(children: [
          Text(
            "Visualizza",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.visibility,
            color: Colors.black,
          )
        ]),
      ),
    );
  }
}

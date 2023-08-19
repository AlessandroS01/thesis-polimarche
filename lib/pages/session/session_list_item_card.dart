import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/inherited_widgets/session_state.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/pages/session/detail_page_session.dart';
import 'package:polimarche/services/session_service.dart';
import 'package:intl/intl.dart';

import '../../model/Session.dart';

class CardSessionListItem extends StatefulWidget {
  final Session session;
  final VoidCallback updateStateSessionPage;
  final Member loggedMember;

  const CardSessionListItem({
    Key? key,
    required this.session,
    required this.updateStateSessionPage,
    required this.loggedMember,
  }) : super(key: key);

  @override
  State<CardSessionListItem> createState() => _CardSessionListItemState();
}

class _CardSessionListItemState extends State<CardSessionListItem> {
  bool isVisualizzaPressed = false;


  @override
  Widget build(BuildContext context) {
    final session = widget.session;

    VoidCallback updateState = widget.updateStateSessionPage;

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
            inset: false
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 10,
            inset: false
          ),
        ],
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${session.id} - ${session.evento}",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              Text(
                "${DateFormat('EEEE, MMM d, yyyy').format(session.data)}",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Inizio: ${DateFormat('HH:mm:ss').format(session.oraInizio)}",
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),Text(
                            "Fine: ${DateFormat('HH:mm:ss').format(session.oraFine)}",
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                      _visualizeMemberButton(

                          widget.loggedMember,
                          updateState,
                          session,
                          backgroundColor,
                          distance,
                          blur
                      )
                    ]
                  ),
                ),
              ),
            ]
          )
      ),
    );
  }

  Listener _visualizeMemberButton(
      Member loggedMember,
      VoidCallback updateState,
      Session session,
      Color backgroundColor,
      Offset distance,
      double blur
      ) {
    return Listener(
                      onPointerDown: (_) async {
                        setState(() => isVisualizzaPressed = true); // Reset the state
                        await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation

                        SessionService sessionService = SessionInheritedState.of(context)!.sessionService;


                        // PASS THE SESSION TO THE NEXT WIDGET
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailSession(
                                  updateState: updateState,
                                  loggedMember: loggedMember,
                                  session: session,
                                  sessionService: sessionService,
                                )
                            )
                        );


                        setState(() => isVisualizzaPressed = false); // Reset the state,
                      },
                      child: AnimatedContainer(
                            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                            duration: Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isVisualizzaPressed ? [
                                BoxShadow(
                                  offset: distance,
                                  blurRadius: blur,
                                  color: Colors.grey.shade500,
                                  inset: true
                                ),
                                BoxShadow(
                                  offset: -distance,
                                  blurRadius: blur,
                                  color: Colors.white,
                                  inset: true
                                ),
                              ] : []
                            ),
                        child: Row(
                            children: [
                              Text(
                                  "Visualizza",
                                  style: TextStyle(
                                    color: Colors.black
                                  ),
                              ),
                              Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                              )
                            ]
                        ),
                      ),
                    );
  }
}




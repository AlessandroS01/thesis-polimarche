import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';
import 'package:polimarche/services/session_service.dart';
import '../../../model/Session.dart';

class CardSession extends StatelessWidget {
  final Session session;
  final SessionService sessionService;

  CardSession({super.key, required this.session, required this.sessionService});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade300;

    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(8, 8),
                  blurRadius: 15,
                  color: Colors.grey.shade500),
              BoxShadow(
                  offset: -Offset(8, 8), blurRadius: 15, color: Colors.white),
            ]),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll
                .disallowIndicator(); // Disable the overscroll glow effect
            return false;
          },
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(
                        "ID: ${session.id}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                        "${DateFormat('EEEE, MMM d, yyyy').format(session.data)} - ${session.evento}",
                        style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Inizio: ${DateFormat('HH:mm:ss').format(session.oraInizio)}",
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        "Fine: ${DateFormat('HH:mm:ss').format(session.oraFine)}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Center(
                      child: Text(
                        "Tracciato",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Nome: ${session.tracciato.nome}",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Lunghezza: ${session.tracciato.lunghezza.toString()}km",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                        "Condizione tracciato: ${session.condizioneTracciato}",
                        style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                        "Temperatura tracciato: ${session.temperaturaTracciato.toString()}°C",
                        style: TextStyle(fontSize: 14)),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Center(
                      child: Text(
                        "Condizioni",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  Center(
                    child: Text("Meteo: ${session.meteo}",
                        style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                        "Pressione atmosferica: ${session.pressioneAtmosferica.toString()} mbar",
                        style: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                        "Temperatura aria: ${session.temperaturaAria.toString()}°C",
                        style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

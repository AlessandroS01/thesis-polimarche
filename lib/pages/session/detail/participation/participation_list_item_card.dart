import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/Comment.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/model/Participation.dart';
import 'package:polimarche/services/session_service.dart';

class ParticipationListItem extends StatefulWidget {
  final Participation participation;
  final SessionService sessionService;
  final VoidCallback updateStateParticipationPage;
  final Member loggedMember;

  const ParticipationListItem(
      {required this.participation,
      required this.sessionService,
      required this.updateStateParticipationPage,
      required this.loggedMember});

  @override
  State<ParticipationListItem> createState() => _ParticipationListItemState();
}

class _ParticipationListItemState extends State<ParticipationListItem> {
  bool isModificaPressed = false;
  bool isCancellaPressed = false;

  late final Participation participation;
  late final SessionService sessionService;
  late final VoidCallback updateStateParticipationPage;
  late final Member loggedMember;

  final backgroundColor = Colors.grey.shade300;

  @override
  void initState() {
    participation = widget.participation;
    sessionService = widget.sessionService;
    updateStateParticipationPage = widget.updateStateParticipationPage;
    loggedMember = widget.loggedMember;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final backgroundColor = Colors.grey.shade300;
    Offset distanceModifica = isModificaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurModifica = isModificaPressed ? 5 : 10;
    Offset distanceCancella = isCancellaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurCancella = isCancellaPressed ? 5 : 10;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
            "Pilota: ${participation.pilota.membro.nome} ${participation.pilota.membro.cognome}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            "Ordine di partecipazione: ${participation.ordine}",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          participation.cambioPilota != "00:00:00.000" ? Text(
            "Cambio con pilota precedente: ${participation.cambioPilota}",
            style: TextStyle(fontSize: 12),
          ) : Container(),
          SizedBox(height: 10),
          /*
          loggedMember.ruolo == "Manager" || loggedMember.ruolo == "Caporeparto"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _modificaButton(
                        distanceModifica,
                        blurModifica),
                    _cancellaButton(
                        distanceCancella,
                        blurCancella),
                  ],
                )
              : Container()

           */
        ],
      ),
    );
  }

  /*
  Listener _cancellaButton(Offset distanceCancella, double blurCancella) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isCancellaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Conferma eliminazione"),
            content: const Text("Sei sicuro di voler eliminare il ?"),
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
                  sessionService.deleteComment(comment);

                  updateStateAgendaPage();

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
        setState(() => isCancellaPressed = false); // Reset the state,

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
            "Rimuovi",
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
            Icons.mode,
            color: Colors.black,
          )
        ]),
      ),
    );
  }


   */
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
}

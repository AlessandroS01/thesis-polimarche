import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/BreakageHappen.dart';
import 'package:polimarche/model/member_model.dart';

class BreakageListItem extends StatefulWidget {
  final BreakageHappen breakageHappened;
  final VoidCallback updateStateBreakagePage;
  final Member loggedMember;

  const BreakageListItem(
      {required this.breakageHappened,
      required this.updateStateBreakagePage,
      required this.loggedMember});

  @override
  State<BreakageListItem> createState() => _BreakageListItemState();
}

class _BreakageListItemState extends State<BreakageListItem> {

  late final BreakageHappen breakageHappened;
  late final VoidCallback updateStateParticipationPage;
  late final Member loggedMember;

  final backgroundColor = Colors.grey.shade300;

  @override
  void initState() {
    breakageHappened = widget.breakageHappened;
    updateStateParticipationPage = widget.updateStateBreakagePage;
    loggedMember = widget.loggedMember;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
            "Descrizione rottura avvenuta:",
            style: TextStyle(fontSize: 16),
          ),Text(
            "${breakageHappened.descrizione}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 15),
          Text(
            "Tipo di rottura: ${breakageHappened.rottura.descrizione}",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          breakageHappened.colpaPilota ? Text(
            "Rottura avvenuta per colpa del pilota",
            style: TextStyle(fontSize: 12),
          ) : Container(),
          SizedBox(height: 5),
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

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/Comment.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/services/session_service.dart';

class CardCommentListItem extends StatefulWidget {
  final Comment comment;
  final SessionService sessionService;
  final VoidCallback updateStateCommentPage;
  final Member loggedMember;

  const CardCommentListItem(
      {required this.comment,
      required this.sessionService,
      required this.updateStateCommentPage,
      required this.loggedMember});

  @override
  State<CardCommentListItem> createState() => _CardCommentListItemState();
}

class _CardCommentListItemState extends State<CardCommentListItem> {
  bool isModificaPressed = false;
  bool isCancellaPressed = false;

  late final Comment comment;
  late final SessionService sessionService;
  late final VoidCallback updateStateCommentPage;
  late final Member loggedMember;

  final backgroundColors = Colors.grey.shade300;

  @override
  void initState() {
    comment = widget.comment;
    sessionService = widget.sessionService;
    updateStateCommentPage = widget.updateStateCommentPage;
    loggedMember = widget.loggedMember;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    TextEditingController _textFieldControllerFlag = TextEditingController();
    _textFieldController.text = comment.descrizione;
    _textFieldControllerFlag.text = comment.flag;

    final backgroundColor = Colors.grey.shade300;
    Offset distanceModifica = isModificaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurModifica = isModificaPressed ? 5 : 10;
    Offset distanceCancella = isCancellaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurCancella = isCancellaPressed ? 5 : 10;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
            "${comment.descrizione}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          loggedMember.ruolo == "Manager" || loggedMember.ruolo == "Caporeparto"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _modificaButton(
                        updateStateCommentPage,
                        sessionService,
                        comment,
                        backgroundColor,
                        distanceModifica,
                        blurModifica,
                        _textFieldController,
                        _textFieldControllerFlag),
                    _cancellaButton(
                        updateStateCommentPage,
                        sessionService,
                        comment,
                        backgroundColor,
                        distanceCancella,
                        blurCancella),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  Listener _cancellaButton(
      VoidCallback updateStateAgendaPage,
      SessionService sessionService,
      Comment comment,
      Color backgroundColor,
      Offset distanceCancella,
      double blurCancella) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isCancellaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation
        setState(() => isCancellaPressed = false); // Reset the state,

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Conferma eliminazione"),
            content: const Text("Sei sicuro di voler eliminare il commento?"),
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

  Listener _modificaButton(
      VoidCallback updateStateCommentPage,
      SessionService sessionService,
      Comment comment,
      Color backgroundColor,
      Offset distanceModifica,
      double blurModifica,
      TextEditingController _textFieldController,
      TextEditingController _textFieldControllerFlag) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isModificaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Nuova descrizione"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text("Descrizione"),
                    Expanded(child: Container()),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _textFieldController,
                      ),
                    )
                  ],
                ),

                SizedBox(
                    height:
                        10), // Add some spacing between the text field and radio buttons

                Row(
                  children: [
                    Text("Flag"),
                    Expanded(child: Container()),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _textFieldControllerFlag,
                      ),
                    )
                  ],
                ),
              ],
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
                  if (_textFieldControllerFlag.text.toLowerCase() ==
                          "Team".toLowerCase() ||
                      _textFieldControllerFlag.text.toLowerCase() ==
                          "Pilota".toLowerCase()) {
                    sessionService.modifyComment(
                        comment,
                        _textFieldController.text,
                        _textFieldControllerFlag.text);

                    updateStateCommentPage();

                    Navigator.pop(context);
                  } else {
                    showToast("Immettere team o pilota come flag.");
                  }
                },
              ),
            ],
          ),
        );

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
}
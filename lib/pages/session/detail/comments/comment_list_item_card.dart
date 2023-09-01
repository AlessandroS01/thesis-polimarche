import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/comment_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/service/comment_service.dart';

class CardCommentListItem extends StatefulWidget {
  final Comment comment;
  final Future<void> Function() updateStateCommentPage;
  final Member loggedMember;

  const CardCommentListItem(
      {required this.comment,
      required this.updateStateCommentPage,
      required this.loggedMember});

  @override
  State<CardCommentListItem> createState() => _CardCommentListItemState();
}

class _CardCommentListItemState extends State<CardCommentListItem> {
  bool isModificaPressed = false;
  bool isCancellaPressed = false;
  final backgroundColor = Colors.grey.shade300;

  TextEditingController _controllerDescription = TextEditingController();

  late final Comment comment;
  late final Future<void> Function() updateStateCommentPage;
  late final Member loggedMember;

  late final CommentService _commentService;

  late bool _flagTeam;
  late bool _flagPilota;

  @override
  void initState() {
    comment = widget.comment;
    updateStateCommentPage = widget.updateStateCommentPage;
    loggedMember = widget.loggedMember;
    _commentService = CommentService();

    if (comment.flag == "Pilota") {
      _flagPilota = true;
      _flagTeam = false;
    } else {
      _flagPilota = false;
      _flagTeam = true;
    }

    _controllerDescription.text = comment.descrizione;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      distanceModifica,
                      blurModifica,
                    ),
                    _cancellaButton(distanceCancella, blurCancella),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  Listener _cancellaButton(Offset distanceCancella, double blurCancella) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isCancellaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation
        setState(() => isCancellaPressed = false); // Reset the state,

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("CONFERMA ELIMINAZIONE"),
            content: const Text("Sei sicuro di voler eliminare il commento?"),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  "INDIETRO",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  "CONFERMA",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  await _commentService.deleteComment(comment.uid);

                  await updateStateCommentPage();

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
    Offset distanceModifica,
    double blurModifica,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isModificaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: const Text("MODIFICA COMMENTO")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
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
                    controller: _controllerDescription,
                  ),

                  SizedBox(
                      height:
                          30), // Add some spacing between the text field and radio buttons

                  Row(
                    children: [
                      Text("Flag"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Team"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _flagTeam,
                            onChanged: (bool? value) {
                              setState(() {
                                _flagTeam = value!;
                                _flagPilota = !value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Pilota"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _flagPilota,
                            onChanged: (bool? value) {
                              setState(() {
                                _flagPilota = value!;
                                _flagTeam = !value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "CONFERMA",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    String newFlag = _flagTeam ? "Team" : "Pilota";

                    await _commentService.modifyComment(
                        comment, _controllerDescription.text, newFlag);

                    await updateStateCommentPage();

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
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
            Icons.mode,
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

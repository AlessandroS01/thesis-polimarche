import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/Driver.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/pages/session/detail/participation/participation_list_item_card.dart';
import 'package:polimarche/pages/session/detail/setups_used/used_setup_list_item_card.dart';
import 'package:polimarche/services/session_service.dart';

import '../../../../model/Participation.dart';
import '../../../../model/Setup.dart';
import '../../../../model/UsedSetup.dart';

class UsedSetupDuringSessionPage extends StatefulWidget {
  final int sessionId;
  final SessionService sessionService;
  final Member loggedMember;

  const UsedSetupDuringSessionPage(
      {super.key,
      required this.sessionId,
      required this.loggedMember,
      required this.sessionService});

  @override
  State<UsedSetupDuringSessionPage> createState() =>
      _UsedSetupDuringSessionPageState();
}

class _UsedSetupDuringSessionPageState
    extends State<UsedSetupDuringSessionPage> {
  final backgroundColor = Colors.grey.shade300;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;

  late final int sessionId;
  late final SessionService sessionService;
  late final Member loggedMember;

  late List<UsedSetup> listUsedSetups;
  late List<Setup> nonUsedSetups;
  late String _newSetupUsedId;

  bool isVisualizzaPressed = false;

  TextEditingController _controllerComment = TextEditingController();

  void updateState() {
    setState(() {
      nonUsedSetups = sessionService.findSetupNotUsedDuringSession(sessionId);
      if (nonUsedSetups.isNotEmpty) {
        _newSetupUsedId = nonUsedSetups.first.id.toString();
      } else {
        _newSetupUsedId = "";
      }
    });
  }

  void _addNewSetupUsed() {
    String newComment =
        _controllerComment.text.isNotEmpty ? _controllerComment.text : "";


    sessionService.addNewUsedSetup(sessionId, _newSetupUsedId, newComment);

    _controllerComment.clear();

    updateState();

    showToast(
        "Il setup è aggiunto alla lista dei setup utilizzati per la sessione corrente");

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    sessionId = widget.sessionId;
    sessionService = widget.sessionService;
    loggedMember = widget.loggedMember;

    nonUsedSetups = sessionService.findSetupNotUsedDuringSession(sessionId);
    if (nonUsedSetups.isNotEmpty) {
      _newSetupUsedId = nonUsedSetups.first.id.toString();
    } else {
      _newSetupUsedId = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    listUsedSetups = sessionService.findUsedSetupsBySessionId(sessionId);

    Offset distanceVisualizza =
        isVisualizzaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurVisualizza = isVisualizzaPressed ? 5 : 10;

    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll
                          .disallowIndicator(); // Disable the overscroll glow effect
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: listUsedSetups.length,
                      itemBuilder: (context, index) {
                        final element = listUsedSetups[index];
                        return UsedSetupListItem(
                            sessionService: sessionService,
                            loggedMember: loggedMember,
                            usedSetup: element,
                            updateStateUsedSetupPage: updateState);
                      },
                    )),
              )),
              loggedMember.ruolo == "Caporeparto" ||
                      loggedMember.ruolo == "Manager"
                  ? _newSetupUsedButton(backgroundColor, distanceAdd, blurAdd,
                      distanceVisualizza, blurVisualizza)
                  : Container()
            ],
          )),
    );
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.close), // Change to the "X" icon
          onPressed: () {
            // Implement your desired action when the "X" icon is pressed
            Navigator.pop(context); // Example action: Navigate back
          },
        )
      ],
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Setup utilizzati",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Align _newSetupUsedButton(Color backgroundColor, Offset distanceAdd,
      double blurAdd, Offset distanceVisualizza, double blurVisualizza) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Listener(
              onPointerDown: (_) async {
                setState(() => isAddPressed = true); // Reset the state
                await Future.delayed(
                    const Duration(milliseconds: 200)); // Wait for animation

                if (nonUsedSetups.isEmpty) {
                  showToast(
                      "Tutti i setup sono stati utilizzati per questa sessione.");
                } else {
                  _addUsedSetupDialog(distanceVisualizza, blurVisualizza);
                }

                setState(() => isAddPressed = false); // Reset the state,
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
            )));
  }

  Future<dynamic> _addUsedSetupDialog(
      Offset distanceVisualizza, double blurVisualizza) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text("Nuova partecipazione"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                padding: EdgeInsets.all(10),
                                borderRadius: BorderRadius.circular(10),
                                dropdownColor: backgroundColor,
                                value: _newSetupUsedId,
                                items: nonUsedSetups
                                    .map<DropdownMenuItem<String>>(
                                        (Setup value) {
                                  return DropdownMenuItem<String>(
                                    value: value.id.toString(),
                                    child: Text(value.id.toString()),
                                  );
                                }).toList(),
                                onChanged: (String? setupId) {
                                  if (setupId != null) {
                                    setState(() {
                                      _newSetupUsedId = setupId;
                                    });
                                  }
                                }),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Listener(
                        onPointerDown: (_) async {
                          setState(() =>
                              isVisualizzaPressed = true); // Reset the state
                          await Future.delayed(const Duration(
                              milliseconds: 200)); // Wait for animation

                          setState(() =>
                              isVisualizzaPressed = false); // Reset the state,
                        },
                        child: AnimatedContainer(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          duration: Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isVisualizzaPressed
                                  ? [
                                      BoxShadow(
                                          offset: distanceVisualizza,
                                          blurRadius: blurVisualizza,
                                          color: Colors.grey.shade300,
                                          inset: true),
                                      BoxShadow(
                                          offset: -distanceVisualizza,
                                          blurRadius: blurVisualizza,
                                          color: Colors.grey.shade100,
                                          inset: true),
                                    ]
                                  : []),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                      ))
                    ],
                  ),
                  SizedBox(
                      height:
                          10), // Add some spacing between the text field and radio buttons

                  Text("Commento"),
                  TextField(
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'aleo',
                        letterSpacing: 1),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: 'Commento',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _controllerComment,
                  )
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
                  onPressed: _addNewSetupUsed,
                ),
              ],
            ),
          );
        });
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

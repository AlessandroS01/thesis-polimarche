import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/BreakageHappen.dart';
import 'package:polimarche/model/driver_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/session/detail/breakages/breakage_list_item_card.dart';

import '../../../../model/Breakage.dart';
import '../../../../model/participation_model.dart';

class BreakagesSessionPage extends StatefulWidget {
  final int sessionId;
  final Member loggedMember;

  const BreakagesSessionPage(
      {super.key,
      required this.sessionId,
      required this.loggedMember});

  @override
  State<BreakagesSessionPage> createState() => _BreakagesSessionPageState();
}

class _BreakagesSessionPageState extends State<BreakagesSessionPage> {
  final backgroundColor = Colors.grey.shade300;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;

  late final int sessionId;
  late final Member loggedMember;

  late List<BreakageHappen> listBreakagesHappened;
  late final List<Breakage> listBreakages;

  late String _newBreakageHappenedBreakageId;
  TextEditingController _controllerDescriptionNewBreakageHappened =
      TextEditingController();
  bool _colpaPilota = false;

  void updateState() {
    setState(() {
     // listBreakagesHappened = sessionService.findBreakagesHappenedDuringSession(sessionId);
    });
  }

  @override
  void initState() {
    super.initState();
    sessionId = widget.sessionId;
    loggedMember = widget.loggedMember;
    //listBreakages = sessionService.listBreakages;

    _newBreakageHappenedBreakageId = listBreakages.first.id.toString();
  }

  void _addNewBreakageHappened() {
    String _description = "";

    if (_controllerDescriptionNewBreakageHappened.text.isNotEmpty) {
      _description = _controllerDescriptionNewBreakageHappened.text;
    }

    //sessionService.addNewBreakageHappened(_newBreakageHappenedBreakageId, _description, _colpaPilota, sessionId);

    updateState();

    Navigator.pop(context);

    _controllerDescriptionNewBreakageHappened.clear();
    _newBreakageHappenedBreakageId = listBreakages.first.id.toString();
    _colpaPilota = false;

    showToast("La nuova rottura verifica è stata aggiunta");
  }

  @override
  Widget build(BuildContext context) {
    //listBreakagesHappened = sessionService.findBreakagesHappenedDuringSession(sessionId);

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
                        itemCount: listBreakagesHappened.length,
                        itemBuilder: (context, index) {
                          final element = listBreakagesHappened[index];
                          return BreakageListItem(
                              breakageHappened: element,
                              updateStateBreakagePage: updateState,
                              loggedMember: loggedMember);
                        })),
              )),
              loggedMember.ruolo == "Caporeparto" ||
                      loggedMember.ruolo == "Manager"
                  ? _newBreakageHappenedButton(
                      backgroundColor, distanceAdd, blurAdd)
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
        "Rotture verificate",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Align _newBreakageHappenedButton(
      Color backgroundColor, Offset distanceAdd, double blurAdd) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Listener(
              onPointerDown: (_) async {
                setState(() => isAddPressed = true); // Reset the state
                await Future.delayed(
                    const Duration(milliseconds: 200)); // Wait for animation
                setState(() => isAddPressed = false); // Reset the state,

                _addBreakageDialog();
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

  Future<dynamic> _addBreakageDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text("Nuova rottura avvenuta"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Tipo di rottura",
                        style: TextStyle(fontSize: 14),
                      )),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              padding: EdgeInsets.all(10),
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: backgroundColor,
                              value: listBreakages.first.id.toString(),
                              items: listBreakages
                                  .map<DropdownMenuItem<String>>(
                                      (Breakage value) {
                                return DropdownMenuItem<String>(
                                  value: value.id.toString(),
                                  child: Text("${value.descrizione}"),
                                );
                              }).toList(),
                              onChanged: (String? breakageId) {
                                setState(() {
                                  _newBreakageHappenedBreakageId = breakageId!;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          10), // Add some spacing between the text field and radio buttons

                  TextField(
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'aleo',
                        letterSpacing: 1),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Descrizione',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _controllerDescriptionNewBreakageHappened,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Colpa pilota"),
                      Checkbox(
                        activeColor: Colors.black,
                        value: _colpaPilota,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _colpaPilota = newValue!;
                          });
                        },
                      ),
                    ],
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
                  onPressed: _addNewBreakageHappened,
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

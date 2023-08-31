import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/driver_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/session/detail/participation/participation_list_item_card.dart';
import 'package:polimarche/services/session_service.dart';

import '../../../../model/Participation.dart';

class ParticipationSessionPage extends StatefulWidget {
  final int sessionId;
  final SessionService sessionService;
  final Member loggedMember;

  const ParticipationSessionPage(
      {super.key,
      required this.sessionId,
      required this.sessionService,
      required this.loggedMember});

  @override
  State<ParticipationSessionPage> createState() =>
      _ParticipationSessionPageState();
}

class _ParticipationSessionPageState extends State<ParticipationSessionPage> {
  final backgroundColor = Colors.grey.shade300;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;

  late final SessionService sessionService;
  late final int sessionId;
  late final Member loggedMember;

  late final List<Driver> listDrivers;
  late List<Participation> listParticipation;
  late List<Driver> nonPartecipatingDrivers;

  late String _newDriverParticipationId;
  TextEditingController _controllerNewDriverParticipationCambioHour =
      TextEditingController();
  TextEditingController _controllerNewDriverParticipationCambioMin =
      TextEditingController();
  TextEditingController _controllerNewDriverParticipationCambioSec =
      TextEditingController();
  TextEditingController _controllerNewDriverParticipationCambioMil =
      TextEditingController();

  void updateState() {
    setState(() {
      nonPartecipatingDrivers =
          sessionService.findDriversNotParticipatingSession(sessionId);
    });
  }

  @override
  void initState() {
    super.initState();
    sessionId = widget.sessionId;
    sessionService = widget.sessionService;
    loggedMember = widget.loggedMember;
    listDrivers = sessionService.listDrivers;

    _controllerNewDriverParticipationCambioHour.text = "00";
    _controllerNewDriverParticipationCambioMin.text = "00";
    _controllerNewDriverParticipationCambioSec.text = "00";
    _controllerNewDriverParticipationCambioMil.text = "000";

    nonPartecipatingDrivers =
        sessionService.findDriversNotParticipatingSession(sessionId);
    if (nonPartecipatingDrivers.isNotEmpty) {
      //_newDriverParticipationId = nonPartecipatingDrivers.first.id.toString();
    } else {
      _newDriverParticipationId = "";
    }
  }

  void _addNewDriverParticipation() {
    if (_newDriverParticipationId != "") {
      if (int.tryParse(_controllerNewDriverParticipationCambioHour.text) !=
              null &&
          int.tryParse(_controllerNewDriverParticipationCambioMin.text) !=
              null &&
          int.tryParse(_controllerNewDriverParticipationCambioSec.text) !=
              null &&
          int.tryParse(_controllerNewDriverParticipationCambioMil.text) !=
              null) {
        sessionService.addNewParticipation(
            _controllerNewDriverParticipationCambioHour.text,
            _controllerNewDriverParticipationCambioMin.text,
            _controllerNewDriverParticipationCambioSec.text,
            _controllerNewDriverParticipationCambioMil.text,
            _newDriverParticipationId,
            sessionId);
      } else {
        showToast("Ricontrollare i valori immessi per il cambio pilota");
      }
    } else {
      showToast("Selezionare il pilota");
    }

    updateState();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    listParticipation = sessionService.findParticipationsBySessionId(sessionId);
    listParticipation.sort((a, b) => a.ordine.compareTo(b.ordine));

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
                        itemCount: listParticipation.length,
                        itemBuilder: (context, index) {
                          final element = listParticipation[index];
                          return ParticipationListItem(
                              participation: element,
                              sessionService: sessionService,
                              updateStateParticipationPage: updateState,
                              loggedMember: loggedMember);
                        })),
              )),
              loggedMember.ruolo == "Caporeparto" ||
                      loggedMember.ruolo == "Manager"
                  ? _newParticipationButton(
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
        "Partecipazioni piloti",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Align _newParticipationButton(
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
                if (nonPartecipatingDrivers.isEmpty) {
                  showToast("Tutti i piloti hanno partecipato alla sessione");
                } else {
                  _addParticipationDialog();
                }
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

  Future<dynamic> _addParticipationDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text("Nuova partecipazione"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        padding: EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: backgroundColor,
                        value: nonPartecipatingDrivers.first.toString(),
                        items: nonPartecipatingDrivers
                            .map<DropdownMenuItem<String>>((Driver value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(
                                "${value.membro.nome} ${value.membro.cognome}"),
                          );
                        }).toList(),
                        onChanged: (String? driverId) {
                          setState(() {
                            _newDriverParticipationId = driverId!;
                          });
                        }),
                  ),
                  SizedBox(
                      height:
                          10), // Add some spacing between the text field and radio buttons

                  Column(
                    children: [
                      Text("Cambio pilota"),
                      Text("(HH:mm:ss.mmm)"),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        maxLength: 2,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'aleo',
                            letterSpacing: 1),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: 'HH',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controllerNewDriverParticipationCambioHour,
                      )),
                      Text(":"),
                      Expanded(
                          child: TextField(
                        maxLength: 2,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'aleo',
                            letterSpacing: 1),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: 'mm',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controllerNewDriverParticipationCambioMin,
                      )),
                      Text(":"),
                      Expanded(
                          child: TextField(
                        maxLength: 2,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'aleo',
                            letterSpacing: 1),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: 'ss',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controllerNewDriverParticipationCambioSec,
                      )),
                      Text("."),
                      Expanded(
                          child: TextField(
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'aleo',
                            letterSpacing: 1),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: 'mmm',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controllerNewDriverParticipationCambioMil,
                      )),
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
                  onPressed: _addNewDriverParticipation,
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

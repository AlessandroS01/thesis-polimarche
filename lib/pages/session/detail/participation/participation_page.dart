import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/driver_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/session/detail/participation/participation_list_item_card.dart';
import 'package:polimarche/service/driver_service.dart';
import 'package:polimarche/service/participation_service.dart';

import '../../../../model/participation_model.dart';

class ParticipationSessionPage extends StatefulWidget {
  final int sessionId;
  final Member loggedMember;

  const ParticipationSessionPage(
      {super.key, required this.sessionId, required this.loggedMember});

  @override
  State<ParticipationSessionPage> createState() =>
      _ParticipationSessionPageState();
}

class _ParticipationSessionPageState extends State<ParticipationSessionPage> {
  final backgroundColor = Colors.grey.shade300;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;

  late final int sessionId;
  late final Member loggedMember;

  late final ParticipationService _participationService;
  late final DriverService _driverService;

  late List<Driver> listDrivers;
  late List<Participation> _listParticipation;
  late List<Driver> nonPartecipatingDrivers;

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  late String _newDriverParticipationMatricola;
  TextEditingController _controllerNewDriverParticipationCambioHour =
      TextEditingController();
  TextEditingController _controllerNewDriverParticipationCambioMin =
      TextEditingController();
  TextEditingController _controllerNewDriverParticipationCambioSec =
      TextEditingController();
  TextEditingController _controllerNewDriverParticipationCambioMil =
      TextEditingController();

  Future<void> _getParticipationsAndDrivers() async {
    _listParticipation =
        await _participationService.getParticipationsBySessionId(sessionId);
    _listParticipation.sort((a, b) => a.ordine.compareTo(b.ordine));

    listDrivers = await _driverService.getDrivers();
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getParticipationsAndDrivers(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
    });
  }

  Future<void> _findNonParticipatingDrivers() async {
    List<int> driversParticipatingMatricole = _listParticipation
        .map((participation) => participation.matricolaPilota)
        .toList();

    setState(() {
      nonPartecipatingDrivers = List.from(listDrivers);

      nonPartecipatingDrivers.removeWhere((driver) =>
          driversParticipatingMatricole.contains(driver.membro.matricola));

      if (nonPartecipatingDrivers.length != 0) {
        _newDriverParticipationMatricola =
            nonPartecipatingDrivers.first.membro.matricola.toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    sessionId = widget.sessionId;
    loggedMember = widget.loggedMember;
    _participationService = ParticipationService();
    _driverService = DriverService();
    _dataLoading = _getParticipationsAndDrivers();

    _controllerNewDriverParticipationCambioHour.text = "00";
    _controllerNewDriverParticipationCambioMin.text = "00";
    _controllerNewDriverParticipationCambioSec.text = "00";
    _controllerNewDriverParticipationCambioMil.text = "000";
  }

  Future<void> _addNewDriverParticipation() async {
    int? cambioHour =
        int.tryParse(_controllerNewDriverParticipationCambioHour.text);
    int? cambioMin =
        int.tryParse(_controllerNewDriverParticipationCambioMin.text);
    int? cambioSec =
        int.tryParse(_controllerNewDriverParticipationCambioSec.text);
    int? cambioMil =
        int.tryParse(_controllerNewDriverParticipationCambioMil.text);

    if (_newDriverParticipationMatricola != "") {
      if (cambioHour != null &&
          cambioMin != null &&
          cambioSec != null &&
          cambioMil != null) {
        if (cambioHour >= 0 && cambioMin >= 0 && cambioSec >= 0 && cambioMil >= 0) {
          String cambioPilota = cambioHour.toString() +
              ":" +
              cambioMin.toString() +
              ":" +
              cambioSec.toString() +
              "." +
              cambioMil.toString();

          await _participationService.addNewParticipation(
              _newDriverParticipationMatricola, sessionId, cambioPilota);

          _controllerNewDriverParticipationCambioHour.text = "00";
          _controllerNewDriverParticipationCambioMin.text = "00";
          _controllerNewDriverParticipationCambioSec.text = "00";
          _controllerNewDriverParticipationCambioMil.text = "000";

          _refreshState();

          Navigator.pop(context);
        } else {
          showToast("I valori devono essere tutti non negativi");
        }
      } else {
        showToast("Ricontrollare i valori immessi per il cambio pilota");
      }
    } else {
      showToast("Selezionare il pilota");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            children: [
              Expanded(
                  child: RefreshIndicator(
                onRefresh: _refreshState,
                child: Container(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll
                            .disallowIndicator(); // Disable the overscroll glow effect
                        return false;
                      },
                      child: FutureBuilder(
                        future: _dataLoading,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              _isDataLoading) {
                            // Return a loading indicator if still waiting for data
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ));
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('${snapshot.error}'),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: _listParticipation.length,
                                itemBuilder: (context, index) {
                                  final element = _listParticipation[index];
                                  return ParticipationListItem(
                                      participation: element,
                                      driver: listDrivers.firstWhere((driver) =>
                                          driver.membro.matricola ==
                                          element.matricolaPilota),
                                      updateStateParticipationPage:
                                          _refreshState,
                                      loggedMember: loggedMember);
                                });
                          }
                        },
                      )),
                ),
              )),
              loggedMember.ruolo == "Caporeparto" ||
                      loggedMember.ruolo == "Manager"
                  ? _newParticipationButton(distanceAdd, blurAdd)
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

  Align _newParticipationButton(Offset distanceAdd, double blurAdd) {
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

                await _findNonParticipatingDrivers();

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
              title: Center(child: const Text("NUOVA PARTECIPAZIONE")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        padding: EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: backgroundColor,
                        value: _newDriverParticipationMatricola,
                        items: nonPartecipatingDrivers
                            .map<DropdownMenuItem<String>>((Driver value) {
                          return DropdownMenuItem<String>(
                            value: value.membro.matricola.toString(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${value.membro.matricola}"),
                                Text(
                                    "${value.membro.nome} ${value.membro.cognome}"),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? driverMatricola) {
                          setState(() {
                            _newDriverParticipationMatricola = driverMatricola!;
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

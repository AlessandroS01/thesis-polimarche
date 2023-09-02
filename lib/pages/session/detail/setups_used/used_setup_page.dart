import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/session/detail/setups_used/used_setup_list_item_card.dart';
import 'package:polimarche/pages/session/detail/setups_used/visualize_setup.dart';
import 'package:polimarche/service/setup_service.dart';
import 'package:polimarche/service/used_setup_service.dart';

import '../../../../model/setup_model.dart';
import '../../../../model/used_setup_model.dart';

class UsedSetupDuringSessionPage extends StatefulWidget {
  final int sessionId;
  final Member loggedMember;

  const UsedSetupDuringSessionPage(
      {super.key, required this.sessionId, required this.loggedMember});

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
  bool isVisualizzaPressed = false;

  late final UsedSetupService _usedSetupService;
  late final SetupService _setupService;

  late final int sessionId;
  late final Member loggedMember;

  late List<Setup> _listSetups;
  late List<UsedSetup> _listUsedSetups;
  late List<Setup> nonUsedSetups;
  late int _newSetupUsedId;

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  TextEditingController _controllerComment = TextEditingController();

  Future<void> _getUsedSetups() async {
    _listUsedSetups =
        await _usedSetupService.getUsedSetupsBySessionId(sessionId);

    _listSetups = await _setupService.getSetups();
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getUsedSetups(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
    });
  }

  Future<void> _findNonUsedSetups() async {
    List<int> setupUsedIds =
        _listUsedSetups.map((usedSetup) => usedSetup.setupId).toList();

    setState(() {
      nonUsedSetups = List.from(_listSetups);

      nonUsedSetups.removeWhere((setup) => setupUsedIds.contains(setup.id));

      if (nonUsedSetups.length != 0) {
        _newSetupUsedId = nonUsedSetups.first.id;
      }
    });
  }

  Future<void> _addNewSetupUsed() async {
    String newComment =
        _controllerComment.text.isNotEmpty ? _controllerComment.text : "";

    await _usedSetupService.addNewUsedSetup(
        sessionId, _newSetupUsedId, newComment);

    _controllerComment.clear();

    _refreshState();

    showToast(
        "Il setup è aggiunto alla lista dei setup utilizzati per la sessione corrente");

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    sessionId = widget.sessionId;
    loggedMember = widget.loggedMember;
    _usedSetupService = UsedSetupService();
    _setupService = SetupService();
    _dataLoading = _getUsedSetups();
  }

  @override
  Widget build(BuildContext context) {
    //listUsedSetups = sessionService.findUsedSetupsBySessionId(sessionId);

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
                                itemCount: _listUsedSetups.length,
                                itemBuilder: (context, index) {
                                  final element = _listUsedSetups[index];
                                  return UsedSetupListItem(
                                      loggedMember: loggedMember,
                                      usedSetup: element,
                                      setup: _listSetups.firstWhere((setup) =>
                                          setup.id == element.setupId),
                                      updateStateUsedSetupPage: _refreshState);
                                },
                              );
                            }
                          })),
                ),
              )),
              loggedMember.ruolo == "Caporeparto" ||
                      loggedMember.ruolo == "Manager"
                  ? _newSetupUsedButton(distanceVisualizza, blurVisualizza)
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

  Align _newSetupUsedButton(Offset distanceVisualizza, double blurVisualizza) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Listener(
              onPointerDown: (_) async {
                setState(() => isAddPressed = true); // Reset the state
                await Future.delayed(
                    const Duration(milliseconds: 200)); // Wait for animation

                await _findNonUsedSetups();

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
              title: const Text("NUOVO UTILIZZO"),
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
                                value: _newSetupUsedId.toString(),
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
                                      _newSetupUsedId = int.parse(setupId);
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

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => VisualizeSetup(
                                  setup: _listSetups.firstWhere(
                                      (setup) => setup.id == _newSetupUsedId)),
                            ),
                          );

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

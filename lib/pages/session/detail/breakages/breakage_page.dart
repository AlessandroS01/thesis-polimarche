import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/breakage_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/session/detail/breakages/breakage_list_item_card.dart';
import 'package:polimarche/service/breakage_service.dart';

class BreakagesSessionPage extends StatefulWidget {
  final int sessionId;
  final Member loggedMember;

  const BreakagesSessionPage(
      {super.key, required this.sessionId, required this.loggedMember});

  @override
  State<BreakagesSessionPage> createState() => _BreakagesSessionPageState();
}

class _BreakagesSessionPageState extends State<BreakagesSessionPage> {
  final backgroundColor = Colors.grey.shade300;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;

  TextEditingController _controllerDescriptionNewBreakageHappened =
      TextEditingController();
  bool _colpaPilota = false;

  late final int sessionId;
  late final Member loggedMember;

  late final BreakageService _breakageService;

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  late List<Breakage> _listBreakages;

  Future<void> _getBreakages() async {
    _listBreakages = await _breakageService.getBreakagesBySessionId(sessionId);
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getBreakages(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    sessionId = widget.sessionId;
    loggedMember = widget.loggedMember;
    _breakageService = BreakageService();
    _dataLoading = _getBreakages();
  }

  Future<void> _addNewBreakageHappened() async {
    String _description = "";

    if (_controllerDescriptionNewBreakageHappened.text.isNotEmpty) {
      _description = _controllerDescriptionNewBreakageHappened.text;
    }

    await _breakageService.addNewBreakage(
        sessionId, _colpaPilota, _description);

    _refreshState();

    Navigator.pop(context);

    _controllerDescriptionNewBreakageHappened.clear();
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
                                itemCount: _listBreakages.length,
                                itemBuilder: (context, index) {
                                  final element = _listBreakages[index];
                                  return BreakageListItem(
                                      breakageHappened: element,
                                      updateStateBreakagePage: _refreshState,
                                      loggedMember: loggedMember);
                                });
                          }
                        },
                      )),
                ),
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
              title: const Text("NUOVA ROTTURA"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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

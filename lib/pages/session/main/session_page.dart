import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/pages/session/main/session_list_item_card.dart';
import 'package:polimarche/services/session_service.dart';

import '../../../model/member_model.dart';

class SessionPage extends StatefulWidget {
  final Member loggedMember;
  final SessionService sessionService;

  const SessionPage({super.key, required this.loggedMember, required this.sessionService});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final backgroundColor = Colors.grey.shade300;
  bool isAccelerationPressed = false;
  bool isSkidpadPressed = false;
  bool isEndurancePressed = false;
  bool isAutocrossPressed = false;

  late final Member loggedMember;
  late final SessionService sessionService;

  final TextEditingController _searchBarController = TextEditingController();

  late List<Session> sessionList;
  // list displayed inside the listView
  List<dynamic> _filteredSessionList = [];

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {
    List<bool> buttonPressed = [
      isAccelerationPressed,
      isSkidpadPressed,
      isEndurancePressed,
      isAutocrossPressed
    ];

    List<String> events = ["Acceleration", "Skidpad", "Endurance", "Autocross"];

    int indexOfTrue = buttonPressed.indexWhere((element) => element);

    if (indexOfTrue != -1 && query.isNotEmpty) {
      // event and query
      setState(() {
        _filteredSessionList = sessionList
            .where((element) =>
                element.id.toString().contains(query.toString()) &&
                element.evento == events[indexOfTrue])
            .toList();
      });
    } else if (indexOfTrue != -1 && query.isEmpty) {
      // event and !query
      setState(() {
        _filteredSessionList = sessionList
            .where((element) => element.evento == events[indexOfTrue])
            .toList();
      });
    } else if (indexOfTrue == -1 && query.isNotEmpty) {
      // !event and query
      setState(() {
        _filteredSessionList = sessionList
            .where(
                (element) => element.id.toString().contains(query.toString()))
            .toList();
      });
    } else {
      // !event and !query
      setState(() {
        _filteredSessionList = sessionList;
      });
    }
  }

  // called whenever a button is clicked
  void changeEventButtonPressed() {
    filterListByQuery(_searchBarController.text);
  }

  @override
  void initState() {
    super.initState();

    sessionService = widget.sessionService;
    loggedMember = widget.loggedMember;
  }

  @override
  Widget build(BuildContext context) {
    sessionList = sessionService.listSessions;

    Offset distanceAcceleration =
        isAccelerationPressed ? Offset(5, 5) : Offset(18, 18);
    double blurAcceleration = isAccelerationPressed ? 5.0 : 30.0;

    Offset distanceSkidpad = isSkidpadPressed ? Offset(5, 5) : Offset(18, 18);
    double blurSkidpad = isSkidpadPressed ? 5.0 : 30.0;

    Offset distanceEndurance =
        isEndurancePressed ? Offset(5, 5) : Offset(18, 18);
    double blurEndurance = isEndurancePressed ? 5.0 : 30.0;

    Offset distanceAutocross =
        isAutocrossPressed ? Offset(5, 5) : Offset(18, 18);
    double blurAutocross = isAutocrossPressed ? 5.0 : 30.0;

    filterListByQuery(_searchBarController.text);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          children: [
            SizedBox(height: 30),
            // SEARCH BAR
            _searchBar(),

            // BUTTONS FOR EVENT TYPE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _accelerationButton(distanceAcceleration, blurAcceleration),
                _enduranceButton(distanceEndurance, blurEndurance),
                _skidpadButton(distanceSkidpad, blurSkidpad),
                _autocrossButton(distanceAutocross, blurAutocross),
              ],
            ),

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
                    itemCount: _filteredSessionList.length,
                    itemBuilder: (context, index) {
                      final element = _filteredSessionList[index];
                      return CardSessionListItem(
                          session: element, loggedMember: loggedMember);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Padding _searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
          decoration: BoxDecoration(
            color: backgroundColor, // Light background color
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10,
                offset: Offset(-5, -5),
              ),
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 10,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _searchBarController,
            onChanged: (query) {
              filterListByQuery(query);
            },
            cursorColor: Colors.black,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Id sessione',
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )),
    );
  }

  Expanded _accelerationButton(Offset distance, double blur) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 18, 5, 10),
        child: Center(
          child: Listener(
            onPointerDown: (_) async {
              setState(() {
                isAccelerationPressed =
                    !isAccelerationPressed; // Toggle the state
                isSkidpadPressed = false;
                isEndurancePressed = false;
                isAutocrossPressed = false;
              });

              changeEventButtonPressed();
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: isAccelerationPressed
                        ? [
                            //
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: distance,
                                blurRadius: blur,
                                inset: isAccelerationPressed),
                            BoxShadow(
                                color: Colors.white,
                                offset: -distance,
                                blurRadius: blur,
                                inset: isAccelerationPressed),
                          ]
                        : []),
                child: Column(
                  children: [
                    Image.asset("assets/icon/acceleration.png"),
                    SizedBox(height: 5),
                    Text(
                      "Acceleration",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Expanded _enduranceButton(Offset distance, double blur) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 18, 5, 10),
        child: Center(
          child: Listener(
            onPointerDown: (_) async {
              setState(() {
                isEndurancePressed = !isEndurancePressed; // Toggle the state
                isSkidpadPressed = false;
                isAccelerationPressed = false;
                isAutocrossPressed = false;
              });

              changeEventButtonPressed();
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: isEndurancePressed
                        ? [
                            //
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: distance,
                                blurRadius: blur,
                                inset: isEndurancePressed),
                            BoxShadow(
                                color: Colors.white,
                                offset: -distance,
                                blurRadius: blur,
                                inset: isEndurancePressed),
                          ]
                        : []),
                child: Column(
                  children: [
                    Image.asset("assets/icon/endurance.png"),
                    SizedBox(height: 5),
                    Text(
                      "Endurance",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Expanded _skidpadButton(Offset distance, double blur) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 18, 5, 10),
        child: Center(
          child: Listener(
            onPointerDown: (_) async {
              setState(() {
                isSkidpadPressed = !isSkidpadPressed; // Toggle the state
                isAccelerationPressed = false;
                isEndurancePressed = false;
                isAutocrossPressed = false;
              });

              changeEventButtonPressed();
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: isSkidpadPressed
                        ? [
                            //
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: distance,
                                blurRadius: blur,
                                inset: isSkidpadPressed),
                            BoxShadow(
                                color: Colors.white,
                                offset: -distance,
                                blurRadius: blur,
                                inset: isSkidpadPressed),
                          ]
                        : []),
                child: Column(
                  children: [
                    Image.asset("assets/icon/skidpad.png"),
                    SizedBox(height: 5),
                    Text(
                      "Skidpad",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Expanded _autocrossButton(Offset distance, double blur) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 18, 5, 10),
        child: Center(
          child: Listener(
            onPointerDown: (_) async {
              setState(() {
                isAutocrossPressed = !isAutocrossPressed; // Toggle the state
                isAccelerationPressed = false;
                isEndurancePressed = false;
                isSkidpadPressed = false;
              });

              changeEventButtonPressed();
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: isAutocrossPressed
                        ? [
                            //
                            BoxShadow(
                                color: Colors.grey.shade500,
                                offset: distance,
                                blurRadius: blur,
                                inset: isAutocrossPressed),
                            BoxShadow(
                                color: Colors.white,
                                offset: -distance,
                                blurRadius: blur,
                                inset: isAutocrossPressed),
                          ]
                        : []),
                child: Column(
                  children: [
                    Image.asset("assets/icon/autocross.png"),
                    SizedBox(height: 5),
                    Text(
                      "Autocross",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

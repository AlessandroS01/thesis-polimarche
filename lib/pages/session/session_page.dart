import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polimarche/inherited_widgets/session_state.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/pages/session/plan/plan_session_page.dart';
import 'package:polimarche/pages/session/session_list_item_card.dart';
import 'package:polimarche/services/session_service.dart';

import '../../model/Member.dart';

class SessionPage extends StatefulWidget {
  final Member loggedMember;

  const SessionPage({super.key, required this.loggedMember});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  bool isAccelerationPressed = false;
  bool isSkidpadPressed = false;
  bool isEndurancePressed = false;
  bool isAutocrossPressed = false;

  bool isPlanPressed = false;
  bool isTrackPressed = false;
  bool isHomePressed = false;

  late Member loggedMember;
  final backgroundColor = Colors.grey.shade300;
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
    setState(() {
      filterListByQuery(_searchBarController.text);
    });
  }

  @override
  void initState() {
    sessionService = SessionService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loggedMember = widget.loggedMember;
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

    Offset distancePlan = isPlanPressed ? Offset(5, 5) : Offset(18, 18);
    double blurPlan = isPlanPressed ? 5.0 : 30.0;

    Offset distanceTrack = isTrackPressed ? Offset(5, 5) : Offset(18, 18);
    double blurTrack = isTrackPressed ? 5.0 : 30.0;

    Offset distanceHome = isHomePressed ? Offset(5, 5) : Offset(18, 18);
    double blurHome = isHomePressed ? 5.0 : 30.0;

    setState(() {
      filterListByQuery(_searchBarController.text);
    });

    return Scaffold(
      appBar: _appBar(),
      drawer: _drawer(distancePlan, blurPlan, distanceTrack, blurTrack,
          distanceHome, blurHome, sessionService),
      body: SessionInheritedState(
        sessionService: sessionService,
        child: Container(
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
      ),
    );
  }

  Drawer _drawer(Offset distancePlan, double blurPlan, Offset distanceTrack,
          double blurTrack, Offset distanceHome, double blurHome, SessionService sessionService) =>
      Drawer(
        backgroundColor: backgroundColor,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Sessioni",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loggedMember.ruolo == "Manager" ||
                                loggedMember.ruolo == "Caporeparto"
                            ? _planSessionButton(
                                backgroundColor, distancePlan, blurPlan, sessionService)
                            : Container(),

                        _tracksButton(backgroundColor, distanceTrack, blurTrack)
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Center(
                  child: _homeButton(backgroundColor, distanceHome, blurHome)
                )),
          ],
        ),
      );

  Listener _planSessionButton(
      Color backgroundColor, Offset distancePlan, double blurPlan, SessionService sessionService) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isPlanPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlanSessionPage(
                      sessionService: sessionService,
                    )));

         setState(() => isPlanPressed = false); // Reset the state,
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isPlanPressed
                ? [
                    BoxShadow(
                        offset: distancePlan,
                        blurRadius: blurPlan,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distancePlan,
                        blurRadius: blurPlan,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.add,
            color: Colors.black,
          ),
          Text(
            "Pianifica sessione",
            style: TextStyle(color: Colors.black),
          ),
        ]),
      ),
    );
  }

  Listener _tracksButton(
      Color backgroundColor, Offset distanceTrack, double blurTrack) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isTrackPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation
        setState(() => isTrackPressed = false); // Reset the state,

        SessionService sessionService =
            SessionInheritedState.of(context)!.sessionService;

        /*
        // PASS THE SESSION TO THE NEXT WIDGET
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => isPlanPressed(
                      loggedMember: loggedMember,
                      session: session,
                      sessionService: sessionService,
                    )));


         */
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isTrackPressed
                ? [
                    BoxShadow(
                        offset: distanceTrack,
                        blurRadius: blurTrack,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distanceTrack,
                        blurRadius: blurTrack,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.track_changes,
            color: Colors.black,
          ),
          Text(
            "Tracciati",
            style: TextStyle(color: Colors.black),
          ),
        ]),
      ),
    );
  }

  Listener _homeButton(
      Color backgroundColor, Offset distanceHome, double blurHome) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isHomePressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation
        Navigator.popUntil(context, ModalRoute.withName('/home'));
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isHomePressed
                ? [
                    BoxShadow(
                        offset: distanceHome,
                        blurRadius: blurHome,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distanceHome,
                        blurRadius: blurHome,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.home,
            color: Colors.black,
          ),
          Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
        ]),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      title: Text(
        "Sessioni",
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
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

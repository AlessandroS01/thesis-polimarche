import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/services/session_service.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:intl/intl.dart';

class ModifySessionPage extends StatefulWidget {
  final Session session;
  final SessionService sessionService;

  const ModifySessionPage(
      {super.key, required this.session, required this.sessionService});

  @override
  State<ModifySessionPage> createState() => _ModifySessionPageState();
}

class _ModifySessionPageState extends State<ModifySessionPage> {
  // GENERAL DATA
  final backgroundColor = Colors.grey.shade300;
  late final Session session;
  int _progress = 1;
  final _totalSteps = 3;
  List<String> _stepsName = ["Informazioni", "Tracciato", "Condizioni"];

  // GENERAL METHODS
  void _nextStep() {
    if (_progress != _totalSteps) {
      setState(() {
        _progress++;
      });
    }
  }

  void _previousStep() {
    if (_progress != 1) {
      setState(() {
        _progress--;
      });
    }
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

  // FIRST STEP DATA
  bool isAccelerationPressed = false;
  bool isSkidpadPressed = false;
  bool isEndurancePressed = false;
  bool isAutocrossPressed = false;
  bool isDateButtonPressed = false;
  bool isTimeButtonPressed = false;

  late DateTime newDate;
  late TimeOfDay newStartingTime;
  late TimeOfDay newEndingTime;

  // FIRST STEP METHODS
  void _setNewDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: widget.session.data,
        firstDate: DateTime(widget.session.data.year),
        lastDate: DateTime(widget.session.data.year + 3));

    if (date != null) {
      setState(() {
        newDate = date;
      });
    }
  }

  void _setNewTime() async {
    TimeOfDay? oraInizio = await showTimePicker(
        context: context, initialTime: newStartingTime
    );
    if (oraInizio != null) {
      TimeOfDay? oraFine = await showTimePicker(
        context: context, initialTime: newEndingTime
      );
      if (oraFine != null && isTimeOfDayEarlier(oraInizio, oraFine)) {
        setState(() {
          newStartingTime = oraInizio;
          newEndingTime = oraFine;
        });
      } else {
        showToast("Ricontrollare i dati immessi.");
      }
    }
  }

  DateTime _fromTimeOfDayToDatetime(TimeOfDay time) {
    DateTime currentDate =
        DateTime.now(); // You can replace this with the desired date

    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      time.hour,
      time.minute,
    );
  }

  bool isTimeOfDayEarlier(TimeOfDay time1, TimeOfDay time2) {
    if (time1.hour < time2.hour) {
      return true;
    } else if (time1.hour == time2.hour) {
      return time1.minute < time2.minute;
    } else {
      return false;
    }
  }



  @override
  void initState() {
    super.initState();
    Session session = widget.session;

    // FIRST STEP
    if (session.evento == "Acceleration") {
      isAccelerationPressed = true;
    } else if (session.evento == "Skidpad") {
      isSkidpadPressed = true;
    } else if (session.evento == "Endurance") {
      isEndurancePressed = true;
    } else {
      isAutocrossPressed = true;
    }

    newDate = session.data;
    newStartingTime = TimeOfDay(
        hour: session.oraInizio.hour, minute: session.oraInizio.minute);
    newEndingTime =
        TimeOfDay(hour: session.oraFine.hour, minute: session.oraFine.minute);
  }

  @override
  Widget build(BuildContext context) {
    // FIRST STEP DATA
    List<bool> buttonPressed = [
      isAccelerationPressed,
      isSkidpadPressed,
      isEndurancePressed,
      isAutocrossPressed
    ];

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

    Offset distanceDate = isDateButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurDate = isDateButtonPressed ? 5.0 : 30.0;

    Offset distanceTime = isTimeButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurTime = isTimeButtonPressed ? 5.0 : 30.0;

    return Scaffold(
      appBar: _appBar(backgroundColor),
      bottomNavigationBar: _bottomNavBar(),
      body: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(20),
                child: StepProgressIndicator(
                  totalSteps: _totalSteps,
                  currentStep: _progress,
                  roundedEdges: Radius.circular(15),
                  size: 13,
                  unselectedColor: Colors.grey.shade500,
                  selectedColor: Colors.black,
                )),
            Center(
              child: Text(
                "${_stepsName[_progress - 1]}",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            _progress == 1
                ? _firstStep(
                    // FIRST STEP
                    distanceAcceleration,
                    blurAcceleration,
                    distanceSkidpad,
                    blurSkidpad,
                    distanceEndurance,
                    blurEndurance,
                    distanceAutocross,
                    blurAutocross,
                    distanceDate,
                    blurDate,
                    distanceTime,
                    blurTime)
                : _progress == 2
                    ? _secondStep()
                    : _thirdStep()
          ],
        ),
      ),
    );
  }

  Expanded _firstStep(
          Offset distanceAcceleration,
          double blurAcceleration,
          Offset distanceSkidpad,
          double blurSkidpad,
          Offset distanceEndurance,
          double blurEndurance,
          Offset distanceAutocross,
          double blurAutocross,
          Offset distanceDate,
          double blurDate,
          Offset distanceTime,
          double blurTime) =>
      Expanded(
        child: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Evento",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _accelerationButton(distanceAcceleration, blurAcceleration),
                    _enduranceButton(distanceEndurance, blurEndurance),
                    _skidpadButton(distanceSkidpad, blurSkidpad),
                    _autocrossButton(distanceAutocross, blurAutocross),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Data",
                  style: TextStyle(fontSize: 16),
                ),
                _dateButton(backgroundColor, distanceDate, blurDate),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ora",
                  style: TextStyle(fontSize: 16),
                ),
                _timeButton(backgroundColor, distanceTime, blurTime),
              ],
            ),
          ),
        ),
      );

  /*
  --------------------FIRST STEP--------------------
   */

  // EVENTS
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

  // DATE
  Listener _dateButton(
    Color backgroundColor,
    Offset distanceDate,
    double blurDate,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isDateButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        _setNewDate();

        setState(() => isDateButtonPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isDateButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceDate,
                        blurRadius: blurDate,
                        inset: isDateButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceDate,
                        blurRadius: blurDate,
                        inset: isDateButtonPressed),
                  ]
                : []),
        child: Text("${DateFormat.yMMMMEEEEd().format(newDate)}"),
      ),
    );
  }

  // TIME
  Listener _timeButton(
    Color backgroundColor,
    Offset distanceTime,
    double blurTime,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isTimeButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        _setNewTime();

        setState(() => isTimeButtonPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isTimeButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceTime,
                        blurRadius: blurTime,
                        inset: isTimeButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceTime,
                        blurRadius: blurTime,
                        inset: isTimeButtonPressed),
                  ]
                : []),
        child: Column(
          children: [
            Text(
                "Ora inizio: ${DateFormat('HH:mm:ss').format(_fromTimeOfDayToDatetime(newStartingTime))}"),
            Text(
                "Ora fine: ${DateFormat('HH:mm:ss').format(_fromTimeOfDayToDatetime(newEndingTime))}"),
          ],
        ),
      ),
    );
  }

  Expanded _secondStep() => Expanded(
        child: Text("Second"),
      );

  Expanded _thirdStep() => Expanded(
        child: Text("Third"),
      );

  Container _bottomNavBar() {
    return Container(
      color: Colors.grey.shade300,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GNav(
          iconSize: 30,
          backgroundColor: Colors.grey.shade300,
          color: Colors.black,
          activeColor: Colors.black,
          padding: const EdgeInsets.all(32),
          gap: 8,
          tabs: [
            _progress > 1
                ? GButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      _previousStep();
                    },
                  )
                : GButton(
                    icon: Icons.flag_outlined,
                    leading: Badge(
                      backgroundColor: backgroundColor,
                    )),
            _progress != 3
                ? GButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      _nextStep();
                    },
                  )
                : GButton(
                    icon: Icons.upload,
                    onPressed: () {
                      _nextStep();
                    },
                  ),
          ],
        ),
      ),
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
        "Modifica sessione",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

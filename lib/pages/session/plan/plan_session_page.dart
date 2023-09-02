import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:polimarche/model/track_model.dart';
import 'package:polimarche/service/session_service.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../service/track_service.dart';

class PlanSessionPage extends StatefulWidget {
  const PlanSessionPage({super.key});

  @override
  State<PlanSessionPage> createState() => _PlanSessionPageState();
}

class _PlanSessionPageState extends State<PlanSessionPage>
    with TickerProviderStateMixin {
  // GENERAL DATA
  late AnimationController _animationController;
  final backgroundColor = Colors.grey.shade300;
  int _progress = 1;
  final _totalSteps = 3;
  List<String> _stepsName = ["Informazioni", "Tracciato", "Condizioni"];
  late final SessionService _sessionService;

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

  void _planSession() async {

    List<bool> buttonPressed = [
      isAccelerationPressed,
      isSkidpadPressed,
      isEndurancePressed,
      isAutocrossPressed
    ];
    List<String> events = [
      "Acceleration",
      "Skidpad",
      "Endurance",
      "Autocross"
    ];


    await _sessionService.addSession(
      events[buttonPressed.indexWhere((element) => element)],
      newDate,
      newStartingTime,
      newEndingTime,
      newTrack,
      _controllerWeather.text,
      _controllerPressure.text,
      _controllerAirTemperature.text,
      _controllerTrackTemperature.text,
      _controllerTrackCondition.text
    );

    showToast("Sessione pianificata con successo");

    resetWidget();
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

  void resetWidget() {
    setState(() {
      _progress = 1;

      isAccelerationPressed = false;
      isSkidpadPressed = false;
      isEndurancePressed = false;
      isAutocrossPressed = false;

      newDate = DateTime.now();

      newStartingTime = TimeOfDay.now();
      newEndingTime = TimeOfDay(
        hour: (newStartingTime.hour + 1) %
            24, // Add 1 hour, consider wrapping to next day
        minute: newStartingTime.minute,
      );

      // SECOND STEP
      //newTrack = sessionService.listTracks.first;
      _controllerTrackCondition.clear();
      _controllerTrackTemperature.clear();

      // THIRD STEP
      _controllerWeather.clear();
      _controllerPressure.clear();
      _controllerAirTemperature.clear();
    });
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
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              fontFamily: "aleo",
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
              colorScheme: ColorScheme.light(
                primary: Colors.black, // Calendar header color
                onPrimary: Colors.white,
                surface: Colors.white, // Dialog background color
                onSurface: Colors.black, // Dialog background color
              ),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: newDate,
        firstDate: DateTime(newDate.year),
        lastDate: DateTime(newDate.year + 3));

    if (date != null) {
      setState(() {
        newDate = date;
      });
    }
  }

  void _setNewTime() async {
    TimeOfDay? oraInizio = await showTimePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              fontFamily: "aleo",
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
              colorScheme: ColorScheme.light(
                primary: Colors.black, // Calendar header color
                onPrimary: Colors.white,
                surface: Colors.white, // Dialog background color
                onSurface: Colors.black, // Dialog background color
              ),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        context: context,
        initialTime: newStartingTime);
    if (oraInizio != null) {
      TimeOfDay? oraFine = await showTimePicker(
          builder: (context, child) {
            return Theme(
              data: ThemeData(
                fontFamily: "aleo",
                textTheme:
                    Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
                colorScheme: ColorScheme.light(
                  primary: Colors.black, // Calendar header color
                  onPrimary: Colors.white,
                  surface: Colors.white, // Dialog background color
                  onSurface: Colors.black, // Dialog background color
                ),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
          context: context,
          initialTime: newEndingTime);
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

  // SECOND STEP DATA
  late Track newTrack;
  TextEditingController _controllerTrackCondition = TextEditingController();
  TextEditingController _controllerTrackTemperature = TextEditingController();

  Future<void>? _dataLoading;
  late List<Track> trackList;
  late final TrackService _trackService;

  // SECOND STEP METHODS
  Future<void> _getTracks() async {
    trackList = await _trackService.getTracks();

    newTrack = trackList.first;
  }

  void _changeTrack(String? trackName) {
    if (trackName != null) {
      setState(() {
        newTrack = trackList.firstWhere((track) => track.nome == trackName);
      });
    }
  }

  // THIRD STEP DATA
  TextEditingController _controllerWeather = TextEditingController();
  TextEditingController _controllerPressure = TextEditingController();
  TextEditingController _controllerAirTemperature = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Adjust duration as needed
    );
    _trackService = TrackService();
    _sessionService = SessionService();
    _dataLoading = _getTracks();

    // FIRST STEP
    newDate = DateTime.now();
    newStartingTime = TimeOfDay.now();
    newEndingTime = TimeOfDay(
      hour: (newStartingTime.hour + 1) %
          24, // Add 1 hour, consider wrapping to next day
      minute: newStartingTime.minute,
    );

    // SECOND STEP
    //newTrack = sessionService.listTracks.first;
  }

  @override
  void dispose() {
    _controllerTrackCondition.dispose();
    _controllerTrackTemperature.dispose();
    _controllerAirTemperature.dispose();
    _controllerWeather.dispose();
    _controllerPressure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIRST STEP DATA

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

  /*
  -------------------- FIRST STEP--------------------
   */

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
                  height: 40,
                ),
                Text(
                  "Data",
                  style: TextStyle(fontSize: 16),
                ),
                _dateButton(backgroundColor, distanceDate, blurDate),
                SizedBox(
                  height: 40,
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

  /*
  -------------------- SECOND STEP--------------------
   */
  Expanded _secondStep() => Expanded(
        child: Container(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll
                  .disallowIndicator(); // Disable the overscroll glow effect
              return false;
            },
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Nome",
                      style: TextStyle(fontSize: 16),
                    ),
                    FutureBuilder(
                      future: _dataLoading,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                padding: EdgeInsets.all(10),
                                borderRadius: BorderRadius.circular(10),
                                dropdownColor: backgroundColor,
                                value: newTrack.nome,
                                items: trackList.map<DropdownMenuItem<String>>(
                                    (Track value) {
                                  return DropdownMenuItem<String>(
                                    value: value.nome,
                                    child: Text(value.nome),
                                  );
                                }).toList(),
                                onChanged: (String? trackName) {
                                  _changeTrack(trackName);
                                }),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Condizioni tracciato",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                          margin: EdgeInsets.all(15),
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
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'aleo',
                                letterSpacing: 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Condizioni',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerTrackCondition,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Temperatura tracciato (°C)",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                          margin: EdgeInsets.all(15),
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
                            maxLength: 5,
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
                              hintText: 'Temperatura',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerTrackTemperature,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  /*
  -------------------- THIRD STEP--------------------
   */
  Expanded _thirdStep() => Expanded(
        child: Container(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll
                  .disallowIndicator(); // Disable the overscroll glow effect
              return false;
            },
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Meteo",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                          margin: EdgeInsets.all(15),
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
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'aleo',
                                letterSpacing: 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Meteo',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerWeather,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Pressione (mBar)",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                          margin: EdgeInsets.all(15),
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
                            maxLength: 10,
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
                              hintText: 'Pressione',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerPressure,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Temperatura aria (°C)",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                          margin: EdgeInsets.all(15),
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
                            maxLength: 5,
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
                              hintText: 'Temperatura',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerAirTemperature,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Container _bottomNavBar() {
    return Container(
      color: Colors.grey.shade300,
      child: Container(
        child: GNav(
          iconSize: 30,
          backgroundColor: Colors.grey.shade300,
          color: Colors.black,
          activeColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
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
                      if (_progress == 1) {
                        List<bool> buttonPressed = [
                          isAccelerationPressed,
                          isSkidpadPressed,
                          isEndurancePressed,
                          isAutocrossPressed
                        ];
                        if (buttonPressed.indexWhere((element) => element) !=
                            -1) {
                          _nextStep();
                        } else {
                          showToast("Specificare la tipologia di evento");
                        }
                      } else if (_progress == 2) {
                        if (double.tryParse(_controllerTrackTemperature.text) !=
                            null) {
                          if (_controllerTrackTemperature.text.isNotEmpty) {
                            _nextStep();
                          } else {
                            showToast(
                                "Specificare la temperature del tracciato");
                          }
                        } else {
                          showToast(
                              "La temperatura deve rappresentare un numero");
                        }
                      }
                    },
                  )
                : GButton(
                    icon: Icons.upload,
                    onPressed: () async {
                      if (_animationController.isAnimating) {
                        return;
                      }
                      await _animationController.forward();

                      if (_controllerWeather.text.isNotEmpty) {
                        if (_controllerPressure.text.isNotEmpty) {
                          if (double.tryParse(_controllerPressure.text) !=
                              null) {
                            if (_controllerAirTemperature.text.isNotEmpty) {
                              if (double.tryParse(
                                      _controllerAirTemperature.text) !=
                                  null) {
                                _planSession();
                              } else {
                                showToast(
                                    "La temperatura dell'aria deve rappresentare un numero");
                              }
                            } else {
                              showToast("Specificare la temperatura dell'aria");
                            }
                          } else {
                            showToast(
                                "La pressione deve rappresentare un numero");
                          }
                        } else {
                          showToast("Specificare la pressione");
                        }
                      } else {
                        showToast("Specificare il meteo");
                      }

                      _animationController.reset();
                    },
                  ),
          ],
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/sensor/current_model.dart';
import 'package:polimarche/model/sensor/load_model.dart';
import 'package:polimarche/model/sensor/temperature_model.dart';
import 'package:polimarche/model/sensor/voltage_model.dart';
import 'package:polimarche/pages/telemetry/sensor_type/hidden_drawer_telemetry.dart';
import 'package:polimarche/pages/telemetry/visualize_session.dart';
import 'package:polimarche/repos/used_setup_repo.dart';
import 'package:polimarche/service/sensor/current_service.dart';
import 'package:polimarche/service/sensor/load_service.dart';
import 'package:polimarche/service/sensor/position_service.dart';
import 'package:polimarche/service/sensor/pressure_service.dart';
import 'package:polimarche/service/sensor/temperature_service.dart';
import 'package:polimarche/service/session_service.dart';
import 'package:polimarche/service/setup_service.dart';
import 'package:polimarche/service/used_setup_service.dart';

import '../../model/sensor/position_model.dart';
import '../../model/sensor/pressure_model.dart';
import '../../model/sensor/speed_model.dart';
import '../../model/session_model.dart';
import '../../model/setup_model.dart';
import '../../model/used_setup_model.dart';
import '../../service/sensor/speed_service.dart';
import '../../service/sensor/voltage_service.dart';
import '../session/detail/setups_used/visualize_setup.dart';

class SelectSessionAndSetupPage extends StatefulWidget {
  const SelectSessionAndSetupPage({super.key});

  @override
  State<SelectSessionAndSetupPage> createState() =>
      _SelectSessionAndSetupPageState();
}

class _SelectSessionAndSetupPageState extends State<SelectSessionAndSetupPage> {
  final backgroundColor = Colors.grey.shade300;

  bool isVisualizzaSetup = false;
  bool isVisualizzaSession = false;

  bool _goodGivenInput = false;

  bool isVisualizzaDati = false;

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  late final UsedSetupService _usedSetupService;
  late final SetupService _setupService;
  late final SessionService _sessionService;

  late final CurrentService _currentService;
  late final LoadService _loadService;
  late final PositionService _positionService;
  late final PressureService _pressureService;
  late final SpeedService _speedService;
  late final TemperatureService _temperatureService;
  late final VoltageService _voltageService;

  late List<UsedSetup> _listAllUsedSetups;
  late List<Setup> _listAllSetups;
  late List<Session> _listAllSessions;

  late List<Setup> _listUsedSetupDuringSession;

  late int sessionId;
  late int setupId;

  Future<void> _fetchData() async {
    _listAllSessions = await _sessionService.getSessions();
    _listAllSetups = await _setupService.getSetups();
    _listAllUsedSetups = await _usedSetupService.getAllUsedSetups();

    sessionId = _listAllSessions.first.uid!;

    List<int> setupIds = _listAllUsedSetups
        .where((usedSetup) => usedSetup.sessionId == sessionId)
        .map((element) => element.setupId)
        .toList();

    _listUsedSetupDuringSession = List.from(_listAllSetups);

    _listUsedSetupDuringSession
        .removeWhere((setup) => !setupIds.contains(setup.id));

    if (_listUsedSetupDuringSession.isEmpty) {
      _goodGivenInput = false;
      showToast("Durante la sessione selezionata non sono stati provati setup");
    } else {
      _goodGivenInput = true;
      setupId = _listUsedSetupDuringSession.first.id;
    }
  }

  void _changedSessionId(int? newSessionId) {
    if (newSessionId != null) {
      setState(() {
        sessionId = newSessionId;
      });

      List<int> setupIds = _listAllUsedSetups
          .where((usedSetup) => usedSetup.sessionId == sessionId)
          .map((element) => element.setupId)
          .toList();

      _listUsedSetupDuringSession = List.from(_listAllSetups);

      setState(() {
        _listUsedSetupDuringSession
            .removeWhere((setup) => !setupIds.contains(setup.id));

        if (_listUsedSetupDuringSession.isEmpty) {
          _goodGivenInput = false;
          showToast(
              "Durante la sessione selezionata non sono stati provati setup");
        } else {
          _goodGivenInput = true;
          setupId = _listUsedSetupDuringSession.first.id;
        }
      });
    }
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _fetchData(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
    });
  }

  Future<List<Current>> _findTelemetryDataCurrent() async {
    return await _currentService.getCurrentDataBySessionAndSetupId(
        sessionId, setupId);
  }
  Future<List<Load>> _findTelemetryDataLoad() async {
    return await _loadService.getLoadDataBySessionAndSetupId(
        sessionId, setupId);
  }
  Future<List<Position>> _findTelemetryDataPosition() async {
    return await _positionService.getPositionDataBySessionAndSetupId(
        sessionId, setupId);
  }
  Future<List<Pressure>> _findTelemetryDataPressure() async {
    return await _pressureService.getPressureDataBySessionAndSetupId(
        sessionId, setupId);
  }
  Future<List<Speed>> _findTelemetryDataSpeed() async {
    return await _speedService.getSpeedDataBySessionAndSetupId(
        sessionId, setupId);
  }
  Future<List<Temperature>> _findTelemetryDataTemperature() async {
    return await _temperatureService.getTemperatureDataBySessionAndSetupId(
        sessionId, setupId);
  }
  Future<List<Voltage>> _findTelemetryDataVoltage() async {
    return await _voltageService.getVoltageDataBySessionAndSetupId(
        sessionId, setupId);
  }

  @override
  void initState() {
    super.initState();

    _usedSetupService = UsedSetupService();
    _setupService = SetupService();
    _sessionService = SessionService();

    _currentService = CurrentService();
    _loadService = LoadService();
    _positionService = PositionService();
    _pressureService = PressureService();
    _speedService = SpeedService();
    _temperatureService = TemperatureService();
    _voltageService = VoltageService();

    _dataLoading = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Offset distanceVisualizzaSetup =
        isVisualizzaSetup ? Offset(5, 5) : Offset(8, 8);
    double blurVisualizzaSetup = isVisualizzaSetup ? 5 : 10;

    Offset distanceVisualizzaSession =
        isVisualizzaSession ? Offset(5, 5) : Offset(8, 8);
    double blurVisualizzaSession = isVisualizzaSession ? 5 : 10;

    return Scaffold(
      backgroundColor: backgroundColor,
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
                            return Column(
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                  flex: 3,
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                "Sessione",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            _session(distanceVisualizzaSession,
                                                blurVisualizzaSession),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Center(
                                              child: Text(
                                                "Setup",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            _setup(
                                                context,
                                                distanceVisualizzaSetup,
                                                blurVisualizzaSetup),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _goodGivenInput
                                            ? _visualizeTelemetry(context)
                                            : Container(),
                                      ],
                                    )),
                              ],
                            );
                          }
                        },
                      )),
                ),
              )),
            ],
          )),
    );
  }

  Listener _visualizeTelemetry(BuildContext context) {
    return Listener(
      onPointerDown: (_) async {
        setState(() {
          isVisualizzaDati = true;
        });

        await Future.delayed(Duration(milliseconds: 200));

        List<Current> currentList = await _findTelemetryDataCurrent();
        List<Load> loadList = await _findTelemetryDataLoad();
        List<Position> positionList = await _findTelemetryDataPosition();
        List<Pressure> pressureList = await _findTelemetryDataPressure();
        List<Speed> speedList = await _findTelemetryDataSpeed();
        List<Temperature> temperatureList = await _findTelemetryDataTemperature();
        List<Voltage> voltageList = await _findTelemetryDataVoltage();

        if (temperatureList.isEmpty) {
          showToast(
              "Non sono stati raccolti dati durante la sessione con il setup selezionato");
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  HiddenDrawerTelemetry(
                      currentList: currentList,
                      loadList: loadList,
                      positionList: positionList,
                      pressureList: pressureList,
                      speedList: speedList,
                      temperatureList: temperatureList,
                      voltageList: voltageList,
                  ),
            ),
          );
        }

        setState(() => isVisualizzaDati = false); // Reset the state
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 60),
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isVisualizzaDati
                ? []
                : [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(18, 18),
                        blurRadius: 30),
                    BoxShadow(
                      color: Colors.white,
                      offset: -const Offset(18, 18),
                      blurRadius: 30,
                    ),
                  ]),
        child: const Center(child: Text("Visualizzazione dati")),
      ),
    );
  }

  Container _setup(BuildContext context, Offset distanceVisualizzaSetup,
      double blurVisualizzaSetup) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                    padding: EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: backgroundColor,
                    value: setupId,
                    items: _listUsedSetupDuringSession
                        .map((setup) => setup.id)
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("Id: ${value.toString()}"),
                      );
                    }).toList(),
                    onChanged: (int? newSetupId) {
                      if (newSetupId != null) {
                        setState(() {
                          setupId = newSetupId;
                        });
                      }
                    }),
              ),
            ),
          ),
          Expanded(
              child: Listener(
            onPointerDown: (_) async {
              setState(() => isVisualizzaSetup = true); // Reset the state
              await Future.delayed(
                  const Duration(milliseconds: 200)); // Wait for animation

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => VisualizeSetup(
                      setup: _listAllSetups
                          .firstWhere((setup) => setup.id == setupId)),
                ),
              );

              setState(() => isVisualizzaSetup = false); // Reset the state,
            },
            child: AnimatedContainer(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              duration: Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isVisualizzaSetup
                      ? [
                          BoxShadow(
                              offset: distanceVisualizzaSetup,
                              blurRadius: blurVisualizzaSetup,
                              color: Colors.grey.shade500,
                              inset: true),
                          BoxShadow(
                              offset: -distanceVisualizzaSetup,
                              blurRadius: blurVisualizzaSetup,
                              color: Colors.grey.shade100,
                              inset: true),
                        ]
                      : []),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    );
  }

  Container _session(
      Offset distanceVisualizzaSession, double blurVisualizzaSession) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                    padding: EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: backgroundColor,
                    value: sessionId,
                    items: _listAllSessions
                        .map((session) => session.uid!)
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("Id: ${value.toString()}"),
                      );
                    }).toList(),
                    onChanged: _changedSessionId),
              ),
            ),
          ),
          Expanded(
              child: Listener(
            onPointerDown: (_) async {
              setState(() => isVisualizzaSession = true); // Reset the state
              await Future.delayed(
                  const Duration(milliseconds: 200)); // Wait for animation

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => VisualizeSession(
                      session: _listAllSessions
                          .firstWhere((session) => session.uid == sessionId)),
                ),
              );

              setState(() => isVisualizzaSession = false); // Reset the state,
            },
            child: AnimatedContainer(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              duration: Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isVisualizzaSession
                      ? [
                          BoxShadow(
                              offset: distanceVisualizzaSession,
                              blurRadius: blurVisualizzaSession,
                              color: Colors.grey.shade500,
                              inset: true),
                          BoxShadow(
                              offset: -distanceVisualizzaSession,
                              blurRadius: blurVisualizzaSession,
                              color: Colors.grey.shade100,
                              inset: true),
                        ]
                      : []),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        "Telemetria",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
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

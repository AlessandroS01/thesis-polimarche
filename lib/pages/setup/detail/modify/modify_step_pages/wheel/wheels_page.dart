import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/wheel/wheel_provider.dart';
import 'package:polimarche/services/setup_service.dart';
import 'package:provider/provider.dart';

import '../../../../../../model/Wheel.dart';

class WheelsPage extends StatefulWidget {
  final void Function(List<Wheel> wheels) sendDataToParent;
  final SetupService setupService;

  const WheelsPage(
      {super.key, required this.sendDataToParent, required this.setupService});

  static List<Wheel?> wheelsOf(BuildContext context) {
    final wheelProvider = Provider.of<WheelProvider>(context, listen: false);

    final List<Wheel?> wheels = [
      wheelProvider.frontRight,
      wheelProvider.frontLeft,
      wheelProvider.rearRight,
      wheelProvider.rearLeft,
    ];

    return wheels;
  }

  @override
  State<WheelsPage> createState() => _WheelsPageState();
}

class _WheelsPageState extends State<WheelsPage> {
  final Color backgroundColor = Colors.grey.shade300;
  late final sendDataToParent;
  late final SetupService setupService;

  late WheelProvider wheelProvider;
  bool _isDataInitialized = false;

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

  // FRONT RIGHT DATA
  late bool _useExistingParamsFrontRight;
  late Wheel frontRightWheel;
  late List<Wheel> frontRightWheelParams;
  late List<int> frontRightWheelIds;
  TextEditingController _controllerFrontRightCodifica = TextEditingController();
  TextEditingController _controllerFrontRightPressure = TextEditingController();
  TextEditingController _controllerFrontRightCamber = TextEditingController();
  TextEditingController _controllerFrontRightToe = TextEditingController();

  // FRONT RIGHT METHOD
  _changeDropdownItemFrontRight(int? wheelId) {
    Wheel frontRightNewWheel =
        frontRightWheelParams.where((element) => element.id == wheelId!).first;

    setState(() {
      frontRightWheel = frontRightNewWheel;

      wheelProvider.frontRight = frontRightWheel;
      wheelProvider.existingFrontRight = true;

      _controllerFrontRightCodifica.text = frontRightNewWheel.codifica;
      _controllerFrontRightPressure.text =
          frontRightNewWheel.pressione.toString();
      _controllerFrontRightCamber.text = frontRightNewWheel.frontale;
      _controllerFrontRightToe.text = frontRightNewWheel.superiore;
    });
  }

  _changeStateFrontRightCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsFrontRight = newValue!;
      if (_useExistingParamsFrontRight) {
        frontRightWheel = setupService.findFrontRightWheelParams().first;

        _controllerFrontRightCodifica.text = frontRightWheel.codifica;
        _controllerFrontRightPressure.text =
            frontRightWheel.pressione.toString();
        _controllerFrontRightCamber.text = frontRightWheel.frontale;
        _controllerFrontRightToe.text = frontRightWheel.superiore;

        wheelProvider.frontRight = frontRightWheel;
        wheelProvider.existingFrontRight = true;
      } else {
        wheelProvider.frontRight = null;

        _controllerFrontRightCodifica.clear();
        _controllerFrontRightPressure.clear();
        _controllerFrontRightCamber.clear();
        _controllerFrontRightToe.clear();
        wheelProvider.existingFrontRight = false;
      }
    });
  }

  _checkNewValuesUsedFrontRight(String? text) {
    bool allInputFieldsFilled = true;

    List<String> controllersTexts = [
      _controllerFrontRightCodifica.text,
      _controllerFrontRightPressure.text,
      _controllerFrontRightCamber.text,
      _controllerFrontRightToe.text
    ];

    final Iterator<String> iterator = controllersTexts.iterator;

    while (iterator.moveNext()) {
      if (iterator.current.isEmpty) {
        allInputFieldsFilled = false;
      }
    }

    if (allInputFieldsFilled) {
      if (double.tryParse(_controllerFrontRightPressure.text) != null) {
        var result = setupService.findFrontRightFromExistingParams(
            _controllerFrontRightCodifica.text,
            _controllerFrontRightPressure.text,
            _controllerFrontRightCamber.text,
            _controllerFrontRightToe.text);

        Wheel wheel;

        if (result != false) {
          wheel = result;
        } else {
          wheel = Wheel(
              id: setupService.listWheels.fold<int>(
                      0,
                      (maxValue, item) =>
                          maxValue > item.id ? maxValue : item.id) +
                  1,
              codifica: _controllerFrontRightCodifica.text,
              posizione: "Ant dx",
              frontale: _controllerFrontRightCamber.text,
              superiore: _controllerFrontRightToe.text,
              pressione: double.parse(_controllerFrontRightPressure.text));
        }
        wheelProvider.frontRight = wheel;
        wheelProvider.existingFrontRight = false;
      } else {
        showToast("La pressione deve rappresentare un numero");
      }
    }
  }

  // FRONT LEFT DATA
  bool _useExistingParamsFrontLeft = true;
  late Wheel frontLeftWheel;
  late List<Wheel> frontLeftWheelParams;
  late List<int> frontLeftWheelIds;
  TextEditingController _controllerFrontLeftCodifica = TextEditingController();
  TextEditingController _controllerFrontLeftPressure = TextEditingController();
  TextEditingController _controllerFrontLeftCamber = TextEditingController();
  TextEditingController _controllerFrontLeftToe = TextEditingController();

  // FRONT LEFT METHOD
  _changeDropdownItemFrontLeft(int? wheelId) {
    Wheel frontLeftNewWheel =
        frontLeftWheelParams.where((element) => element.id == wheelId!).first;

    setState(() {
      frontLeftWheel = frontLeftNewWheel;
      wheelProvider.frontLeft = frontLeftWheel;

      _controllerFrontLeftCodifica.text = frontLeftNewWheel.codifica;
      _controllerFrontLeftPressure.text =
          frontLeftNewWheel.pressione.toString();
      _controllerFrontLeftCamber.text = frontLeftNewWheel.frontale;
      _controllerFrontLeftToe.text = frontLeftNewWheel.superiore;
    });
  }

  _changeStateFrontLeftCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsFrontLeft = newValue!;
      if (_useExistingParamsFrontLeft) {
        _controllerFrontLeftCodifica.text = frontLeftWheel.codifica;
        _controllerFrontLeftPressure.text = frontLeftWheel.pressione.toString();
        _controllerFrontLeftCamber.text = frontLeftWheel.frontale;
        _controllerFrontLeftToe.text = frontLeftWheel.superiore;
      } else {
        _controllerFrontLeftCodifica.clear();
        _controllerFrontLeftPressure.clear();
        _controllerFrontLeftCamber.clear();
        _controllerFrontLeftToe.clear();
      }
    });
  }

  // REAR RIGHT DATA
  bool _useExistingParamsRearRight = true;
  late Wheel rearRightWheel;
  late List<Wheel> rearRightWheelParams;
  late List<int> rearRightWheelIds;
  TextEditingController _controllerRearRightCodifica = TextEditingController();
  TextEditingController _controllerRearRightPressure = TextEditingController();
  TextEditingController _controllerRearRightCamber = TextEditingController();
  TextEditingController _controllerRearRightToe = TextEditingController();

  // REAR RIGHT METHOD
  _changeDropdownItemRearRight(int? wheelId) {
    Wheel rearRightNewWheel =
        rearRightWheelParams.where((element) => element.id == wheelId!).first;

    setState(() {
      rearRightWheel = rearRightNewWheel;
      wheelProvider.rearRight = rearRightWheel;

      _controllerRearRightCodifica.text = rearRightNewWheel.codifica;
      _controllerRearRightPressure.text =
          rearRightNewWheel.pressione.toString();
      _controllerRearRightCamber.text = rearRightNewWheel.frontale;
      _controllerRearRightToe.text = rearRightNewWheel.superiore;
    });
  }

  _changeStateRearRightCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsRearRight = newValue!;
      if (_useExistingParamsRearRight) {
        _controllerRearRightCodifica.text = rearRightWheel.codifica;
        _controllerRearRightPressure.text = rearRightWheel.pressione.toString();
        _controllerRearRightCamber.text = rearRightWheel.frontale;
        _controllerRearRightToe.text = rearRightWheel.superiore;
      } else {
        _controllerRearRightCodifica.clear();
        _controllerRearRightPressure.clear();
        _controllerRearRightCamber.clear();
        _controllerRearRightToe.clear();
      }
    });
  }

  // REAR LEFT DATA
  bool _useExistingParamsRearLeft = true;
  late Wheel rearLeftWheel;
  late List<Wheel> rearLeftWheelParams;
  late List<int> rearLeftWheelIds;
  TextEditingController _controllerRearLeftCodifica = TextEditingController();
  TextEditingController _controllerRearLeftPressure = TextEditingController();
  TextEditingController _controllerRearLeftCamber = TextEditingController();
  TextEditingController _controllerRearLeftToe = TextEditingController();

  // REAR LEFT METHOD
  _changeDropdownItemRearLeft(int? wheelId) {
    Wheel rearLeftNewWheel =
        rearLeftWheelParams.where((element) => element.id == wheelId!).first;

    setState(() {
      rearLeftWheel = rearLeftNewWheel;
      wheelProvider.rearLeft = rearLeftWheel;

      _controllerRearLeftCodifica.text = rearLeftNewWheel.codifica;
      _controllerRearLeftPressure.text = rearLeftNewWheel.pressione.toString();
      _controllerRearLeftCamber.text = rearLeftNewWheel.frontale;
      _controllerRearLeftToe.text = rearLeftNewWheel.superiore;
    });
  }

  _changeStateRearLeftCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsRearLeft = newValue!;
      if (_useExistingParamsRearLeft) {
        _controllerRearLeftCodifica.text = rearLeftWheel.codifica;
        _controllerRearLeftPressure.text = rearLeftWheel.pressione.toString();
        _controllerRearLeftCamber.text = rearLeftWheel.frontale;
        _controllerRearLeftToe.text = rearLeftWheel.superiore;
      } else {
        _controllerRearLeftCodifica.clear();
        _controllerRearLeftPressure.clear();
        _controllerRearLeftCamber.clear();
        _controllerRearLeftToe.clear();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sendDataToParent = widget.sendDataToParent;
    setupService = widget.setupService;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      wheelProvider = Provider.of<WheelProvider>(context, listen: false);

      // FRONT RIGHT WHEEL DATA
      _useExistingParamsFrontRight = wheelProvider.existingFrontRight;
      frontRightWheel = wheelProvider.frontRight!;
      frontRightWheelParams = setupService.findFrontRightWheelParams();
      frontRightWheelIds =
          frontRightWheelParams.map((param) => param.id).toList();
      _controllerFrontRightCodifica.text = frontRightWheel.codifica;
      _controllerFrontRightPressure.text = frontRightWheel.pressione.toString();
      _controllerFrontRightCamber.text = frontRightWheel.frontale;
      _controllerFrontRightToe.text = frontRightWheel.superiore;

      // FRONT LEFT WHEEL DATA
      frontLeftWheel = wheelProvider.frontLeft;
      frontLeftWheelParams = setupService.findFrontLeftWheelParams();
      frontLeftWheelIds =
          frontLeftWheelParams.map((param) => param.id).toList();
      _controllerFrontLeftCodifica.text = frontLeftWheel.codifica;
      _controllerFrontLeftPressure.text = frontLeftWheel.pressione.toString();
      _controllerFrontLeftCamber.text = frontLeftWheel.frontale;
      _controllerFrontLeftToe.text = frontLeftWheel.superiore;

      // REAR RIGHT WHEEL DATA
      rearRightWheel = wheelProvider.rearRight;
      rearRightWheelParams = setupService.findRearRightWheelParams();
      rearRightWheelIds =
          rearRightWheelParams.map((param) => param.id).toList();
      _controllerRearRightCodifica.text = rearRightWheel.codifica;
      _controllerRearRightPressure.text = rearRightWheel.pressione.toString();
      _controllerRearRightCamber.text = rearRightWheel.frontale;
      _controllerRearRightToe.text = rearRightWheel.superiore;

      // REAR LEFT WHEEL DATA
      rearLeftWheel = wheelProvider.rearLeft;
      rearLeftWheelParams = setupService.findRearLeftWheelParams();
      rearLeftWheelIds = rearLeftWheelParams.map((param) => param.id).toList();
      _controllerRearLeftCodifica.text = rearLeftWheel.codifica;
      _controllerRearLeftPressure.text = rearLeftWheel.pressione.toString();
      _controllerRearLeftCamber.text = rearLeftWheel.frontale;
      _controllerRearLeftToe.text = rearLeftWheel.superiore;

      setState(() {
        _isDataInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isDataInitialized
        ? Expanded(
            child: Container(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll
                    .disallowIndicator(); // Disable the overscroll glow effect
                return false;
              },
              child: ListView(children: [
                // FRONT RIGHT
                _frontRightColumn(),

                SizedBox(
                  height: 100,
                ),
                // FRONT LEFT
                _frontLeftColumn(),

                SizedBox(
                  height: 100,
                ),
                // REAR RIGHT
                _rearRightColumn(),

                SizedBox(
                  height: 100,
                ),
                // REAR LEFT
                _rearLeftColumn(),

                SizedBox(
                  height: 50,
                ),
              ]),
            ),
          ))
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Column _frontRightColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Anteriore destra",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Utilizzare parametri esistenti"),
            Checkbox(
              activeColor: Colors.black,
              value: _useExistingParamsFrontRight,
              onChanged: _changeStateFrontRightCheckbox,
            ),
          ],
        ),
      ),
      _useExistingParamsFrontRight
          ? _frontRightExistingParams()
          : _frontRightNewParams()
    ]);
  }

  Column _frontRightExistingParams() {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(10),
              dropdownColor: backgroundColor,
              value: frontRightWheel.id,
              items: frontRightWheelIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemFrontRight),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CODIFICA
                  Text("Codifica"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Codifica',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontRightCodifica,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // CAMBER
                  Text("Camber"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Camber',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontRightCamber,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // PRESSIONE
                  Text("Pressione (mbar)"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pressione',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontRightPressure,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // TOE
                  Text("Toe"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Toe',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontRightToe,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _frontRightNewParams() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CODIFICA
                    Text("Codifica"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Codifica',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontRightCodifica,
                            onChanged: _checkNewValuesUsedFrontRight,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // CAMBER
                    Text("Camber"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Camber',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontRightCamber,
                            onChanged: _checkNewValuesUsedFrontRight,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // PRESSIONE
                    Text("Pressione (mbar)"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'aleo',
                                letterSpacing: 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Pressione',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontRightPressure,
                            onChanged: _checkNewValuesUsedFrontRight,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // TOE
                    Text("Toe"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Toe',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontRightToe,
                            onChanged: _checkNewValuesUsedFrontRight,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _frontLeftColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Anteriore sinistra",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Utilizzare parametri esistenti"),
            Checkbox(
              activeColor: Colors.black,
              value: _useExistingParamsFrontLeft,
              onChanged: _changeStateFrontLeftCheckbox,
            ),
          ],
        ),
      ),
      _useExistingParamsFrontLeft
          ? _frontLeftExistingParams()
          : _frontLeftNewParams()
    ]);
  }

  Column _frontLeftExistingParams() {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(10),
              dropdownColor: backgroundColor,
              value: frontLeftWheel.id,
              items: frontLeftWheelIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemFrontLeft),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CODIFICA
                  Text("Codifica"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Codifica',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontLeftCodifica,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // CAMBER
                  Text("Camber"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Camber',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontLeftCamber,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // PRESSIONE
                  Text("Pressione (mbar)"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pressione',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontLeftPressure,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // TOE
                  Text("Toe"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Toe',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontLeftToe,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _frontLeftNewParams() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CODIFICA
                    Text("Codifica"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Codifica',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontLeftCodifica,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // CAMBER
                    Text("Camber"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Camber',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontLeftCamber,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // PRESSIONE
                    Text("Pressione (mbar)"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'aleo',
                                letterSpacing: 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Pressione',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontLeftPressure,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // TOE
                    Text("Toe"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Toe',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontLeftToe,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _rearRightColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Posteriore destra",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Utilizzare parametri esistenti"),
            Checkbox(
              activeColor: Colors.black,
              value: _useExistingParamsRearRight,
              onChanged: _changeStateRearRightCheckbox,
            ),
          ],
        ),
      ),
      _useExistingParamsRearRight
          ? _rearRightExistingParams()
          : _rearRightNewParams()
    ]);
  }

  Column _rearRightExistingParams() {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(10),
              dropdownColor: backgroundColor,
              value: rearRightWheel.id,
              items: rearRightWheelIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemRearRight),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CODIFICA
                  Text("Codifica"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Codifica',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearRightCodifica,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // CAMBER
                  Text("Camber"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Camber',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearRightCamber,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // PRESSIONE
                  Text("Pressione (mbar)"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pressione',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearRightPressure,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // TOE
                  Text("Toe"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Toe',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearRightToe,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _rearRightNewParams() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CODIFICA
                    Text("Codifica"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Codifica',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearRightCodifica,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // CAMBER
                    Text("Camber"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Camber',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearRightCamber,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // PRESSIONE
                    Text("Pressione (mbar)"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'aleo',
                                letterSpacing: 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Pressione',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearRightPressure,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // TOE
                    Text("Toe"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Toe',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearRightToe,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _rearLeftColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Posteriore sinistra",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Utilizzare parametri esistenti"),
            Checkbox(
              activeColor: Colors.black,
              value: _useExistingParamsRearLeft,
              onChanged: _changeStateRearLeftCheckbox,
            ),
          ],
        ),
      ),
      _useExistingParamsRearLeft
          ? _rearLeftExistingParams()
          : _rearLeftNewParams()
    ]);
  }

  Column _rearLeftExistingParams() {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(10),
              dropdownColor: backgroundColor,
              value: rearLeftWheel.id,
              items: rearLeftWheelIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemRearLeft),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CODIFICA
                  Text("Codifica"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Codifica',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearLeftCodifica,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // CAMBER
                  Text("Camber"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Camber',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearLeftCamber,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // PRESSIONE
                  Text("Pressione (mbar)"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pressione',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearLeftPressure,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // TOE
                  Text("Toe"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                          readOnly: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Toe',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearLeftToe,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _rearLeftNewParams() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CODIFICA
                    Text("Codifica"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Codifica',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearLeftCodifica,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // CAMBER
                    Text("Camber"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Camber',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearLeftCamber,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // PRESSIONE
                    Text("Pressione (mbar)"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'aleo',
                                letterSpacing: 1),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Pressione',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearLeftPressure,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // TOE
                    Text("Toe"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                              hintText: 'Toe',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearLeftToe,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

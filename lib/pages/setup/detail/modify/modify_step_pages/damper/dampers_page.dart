import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/Wheel.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/damper/damper_provider.dart';
import 'package:polimarche/services/setup_service.dart';
import 'package:provider/provider.dart';

import '../../../../../../model/Damper.dart';

class DampersPage extends StatefulWidget {
  final SetupService setupService;

  const DampersPage({super.key, required this.setupService});

  static List<Damper?> damperOf(BuildContext context) {
    final damperProvider = Provider.of<DamperProvider>(context, listen: false);

    final List<Damper?> dampers = [damperProvider.front, damperProvider.rear];

    return dampers;
  }

  @override
  State<DampersPage> createState() => _DampersPageState();
}

class _DampersPageState extends State<DampersPage> {
  final Color backgroundColor = Colors.grey.shade300;
  late final SetupService setupService;

  late DamperProvider damperProvider;
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

  // FRONT DATA
  late bool _useExistingParamsFront;
  late Damper frontDamper;
  late List<Damper> frontDamperParams;
  late List<int> frontDamperIds;
  TextEditingController _controllerFrontLsr = TextEditingController();
  TextEditingController _controllerFrontLsc = TextEditingController();
  TextEditingController _controllerFrontHsc = TextEditingController();
  TextEditingController _controllerFrontHsr = TextEditingController();

  // FRONT METHOD
  _changeDropdownItemFront(int? DamperId) {
    Damper frontNewDamper =
        frontDamperParams.where((element) => element.id == DamperId!).first;

    setState(() {
      frontDamper = frontNewDamper;

      damperProvider.front = frontDamper;
      damperProvider.existingFront = true;

      _controllerFrontLsr.text = frontNewDamper.lsr.toString();
      _controllerFrontHsr.text = frontNewDamper.hsr.toString();
      _controllerFrontLsc.text = frontNewDamper.lsc.toString();
      _controllerFrontHsc.text = frontNewDamper.hsc.toString();
    });
  }

  _changeStateFrontCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsFront = newValue!;
      if (_useExistingParamsFront) {
        frontDamper = setupService.findFrontDamperParams().first;

        _controllerFrontLsr.text = frontDamper.lsr.toString();
      _controllerFrontHsr.text = frontDamper.hsr.toString();
      _controllerFrontLsc.text = frontDamper.lsc.toString();
      _controllerFrontHsc.text = frontDamper.hsc.toString();

        damperProvider.front = frontDamper;
        damperProvider.existingFront = true;
      } else {
        damperProvider.front = null;

        _controllerFrontLsr.clear();
        _controllerFrontHsr.clear();
        _controllerFrontHsc.clear();
        _controllerFrontLsc.clear();
        damperProvider.existingFront = false;
      }
    });
  }

  _checkNewValuesUsedFront(String? text) {
    bool allInputFieldsFilled = true;

    List<String> controllersTexts = [
      _controllerFrontLsr.text,
      _controllerFrontHsr.text
    ];

    final Iterator<String> iterator = controllersTexts.iterator;

    while (iterator.moveNext()) {
      if (iterator.current.isEmpty) {
        allInputFieldsFilled = false;
      }
    }
    if (allInputFieldsFilled) {
      if (double.tryParse(_controllerFrontHsr.text) != null) {
        var result = setupService.findFrontDamperFromExistingParams(
            _controllerFrontLsr.text, _controllerFrontHsr.text,
            _controllerFrontHsc.text, _controllerFrontLsc.text);

        Damper damper;

        if (result != false) {
          damper = result;
        } else {
          damper = Damper(
              id: setupService.listDampers.fold<int>(
                      0,
                      (maxValue, item) =>
                          maxValue > item.id ? maxValue : item.id) +
                  1,
              posizione: "Ant",
              hsr: double.parse(_controllerFrontHsr.text),
              lsr: double.parse(_controllerFrontLsr.text),
              lsc: double.parse(_controllerFrontLsc.text),
              hsc: double.parse(_controllerFrontHsc.text));
        }
        damperProvider.front = damper;
        damperProvider.existingFront = false;
      } else {
        showToast(
            "Hsr degli ammortizzatori anteriore deve rappresentare un numero");
      }
    }
  }


  // REAR DATA
  late bool _useExistingParamsRear;
  late Damper rearDamper;
  late List<Damper> rearDamperParams;
  late List<int> rearDamperIds;
  TextEditingController _controllerRearLsr = TextEditingController();
  TextEditingController _controllerRearLsc = TextEditingController();
  TextEditingController _controllerRearHsc = TextEditingController();
  TextEditingController _controllerRearHsr = TextEditingController();

  // REAR METHOD
  _changeDropdownItemRear(int? DamperId) {
    Damper rearNewDamper =
        rearDamperParams.where((element) => element.id == DamperId!).first;

    setState(() {
      rearDamper = rearNewDamper;

      damperProvider.rear = rearDamper;
      damperProvider.existingRear = true;

      _controllerRearLsr.text = rearNewDamper.lsr.toString();
      _controllerRearHsr.text = rearNewDamper.hsr.toString();
      _controllerRearLsc.text = rearNewDamper.lsc.toString();
      _controllerRearHsc.text = rearNewDamper.hsc.toString();
    });
  }

  _changeStateRearCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsRear = newValue!;
      if (_useExistingParamsRear) {
        rearDamper = setupService.findRearDamperParams().first;

        _controllerRearLsr.text = rearDamper.lsr.toString();
      _controllerRearHsr.text = rearDamper.hsr.toString();
      _controllerRearLsc.text = rearDamper.lsc.toString();
      _controllerRearHsc.text = rearDamper.hsc.toString();

        damperProvider.rear = rearDamper;
        damperProvider.existingRear = true;
      } else {
        damperProvider.rear = null;

        _controllerRearLsr.clear();
        _controllerRearHsr.clear();
        _controllerRearHsc.clear();
        _controllerRearLsc.clear();
        damperProvider.existingRear = false;
      }
    });
  }

  _checkNewValuesUsedRear(String? text) {
    bool allInputFieldsFilled = true;

    List<String> controllersTexts = [
      _controllerRearLsr.text,
      _controllerRearHsr.text
    ];

    final Iterator<String> iterator = controllersTexts.iterator;

    while (iterator.moveNext()) {
      if (iterator.current.isEmpty) {
        allInputFieldsFilled = false;
      }
    }
    if (allInputFieldsFilled) {
      if (double.tryParse(_controllerRearHsr.text) != null) {
        var result = setupService.findRearDamperFromExistingParams(
            _controllerRearLsr.text, _controllerRearHsr.text,
            _controllerRearHsc.text, _controllerRearLsc.text);

        Damper damper;

        if (result != false) {
          damper = result;
        } else {
          damper = Damper(
              id: setupService.listDampers.fold<int>(
                      0,
                      (maxValue, item) =>
                          maxValue > item.id ? maxValue : item.id) +
                  1,
              posizione: "Post",
              hsr: double.parse(_controllerRearHsr.text),
              lsr: double.parse(_controllerRearLsr.text),
              lsc: double.parse(_controllerRearLsc.text),
              hsc: double.parse(_controllerRearHsc.text));
        }
        damperProvider.rear = damper;
        damperProvider.existingRear = false;
      } else {
        showToast(
            "Hsr degli ammortizzatori posteriori deve rappresentare un numero");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupService = widget.setupService;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      damperProvider = Provider.of<DamperProvider>(context, listen: false);

      // FRONT Damper DATA
      _useExistingParamsFront = damperProvider.existingFront;
      frontDamper = damperProvider.front!;
      frontDamperParams = setupService.findFrontDamperParams();
      frontDamperIds = frontDamperParams.map((param) => param.id).toList();
      _controllerFrontLsr.text = frontDamper.lsr.toString();
      _controllerFrontHsr.text = frontDamper.hsr.toString();
      _controllerFrontLsc.text = frontDamper.lsc.toString();
      _controllerFrontHsc.text = frontDamper.hsc.toString();



      // REAR Damper DATA
      _useExistingParamsRear = damperProvider.existingRear;
      rearDamper = damperProvider.rear!;
      rearDamperParams = setupService.findRearDamperParams();
      rearDamperIds = rearDamperParams.map((param) => param.id).toList();
      _controllerRearLsr.text = rearDamper.lsr.toString();
      _controllerRearHsr.text = rearDamper.hsr.toString();
      _controllerRearLsc.text = rearDamper.lsc.toString();
      _controllerRearHsc.text = rearDamper.hsc.toString();

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
                // FRONT
                _frontColumn(),

                SizedBox(
                  height: 100,
                ),

                // REAR
                _rearColumn(),

                SizedBox(
                  height: 50,
                ),
              ]),
            ),
          ))
        : Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Column _frontColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Anteriore",
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
              value: _useExistingParamsFront,
              onChanged: _changeStateFrontCheckbox,
            ),
          ],
        ),
      ),
      _useExistingParamsFront ? _frontExistingParams() : _frontNewParams()
    ]);
  }

  Column _frontExistingParams() {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(10),
              dropdownColor: backgroundColor,
              value: frontDamper.id,
              items: frontDamperIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemFront),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lsr
                  Text("Lsr"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Lsr',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontLsr,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // Lsc
                  Text("Lsc"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Lsc',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontLsc,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Hsr
                  Text("Hsr"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Hsr',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontHsr,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // Hsc
                  Text("Hsc"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Hsc',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontHsc,
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

  Container _frontNewParams() {
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
                    // Lsr
                    Text("Lsr"),
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
                              hintText: 'Lsr',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontLsr,
                            onChanged: _checkNewValuesUsedFront,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Lsc
                    Text("Lsc"),
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
                              hintText: 'Lsc',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontLsc,
                            onChanged: _checkNewValuesUsedFront,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // Hsr
                    Text("Hsr"),
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
                              hintText: 'Hsr',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontHsr,
                            onChanged: _checkNewValuesUsedFront,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Hsc
                    Text("Hsc"),
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
                              hintText: 'Hsc',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontHsc,
                            onChanged: _checkNewValuesUsedFront,
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



  Column _rearColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Posteriore",
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
              value: _useExistingParamsRear,
              onChanged: _changeStateRearCheckbox,
            ),
          ],
        ),
      ),
      _useExistingParamsRear ? _rearExistingParams() : _rearNewParams()
    ]);
  }

  Column _rearExistingParams() {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(10),
              dropdownColor: backgroundColor,
              value: rearDamper.id,
              items: rearDamperIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemRear),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lsr
                  Text("Lsr"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Lsr',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearLsr,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // Lsc
                  Text("Lsc"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Lsc',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearLsc,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Hsr
                  Text("Hsr"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Hsr',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearHsr,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // Hsc
                  Text("Hsc"),
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'aleo',
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Hsc',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearHsc,
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

  Container _rearNewParams() {
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
                    // Lsr
                    Text("Lsr"),
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
                              hintText: 'Lsr',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearLsr,
                            onChanged: _checkNewValuesUsedRear,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Lsc
                    Text("Lsc"),
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
                              hintText: 'Lsc',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearLsc,
                            onChanged: _checkNewValuesUsedRear,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // Hsr
                    Text("Hsr"),
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
                              hintText: 'Hsr',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearHsr,
                            onChanged: _checkNewValuesUsedRear,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Hsc
                    Text("Hsc"),
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
                              hintText: 'Hsc',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearHsc,
                            onChanged: _checkNewValuesUsedRear,
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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/spring/spring_provider.dart';
import 'package:polimarche/service/spring_service.dart';
import 'package:provider/provider.dart';

import '../../../../../../model/spring_model.dart';

class SpringsPage extends StatefulWidget {
  const SpringsPage({super.key});

  static List<Spring?> springOf(BuildContext context) {
    final springProvider = Provider.of<SpringProvider>(context, listen: false);

    final List<Spring?> spring = [springProvider.front, springProvider.rear];

    return spring;
  }

  @override
  State<SpringsPage> createState() => _SpringsPageState();
}

class _SpringsPageState extends State<SpringsPage> {
  final Color backgroundColor = Colors.grey.shade300;
  late final SpringService _springService;

  Future<void>? _dataLoading;

  late List<Spring> _springList;

  Future<void> _getSpringParams() async {
    _springList = await _springService.getSprings();

    _initializeData();
  }

  void _initializeData() {
    springProvider = Provider.of<SpringProvider>(context, listen: false);

    // FRONT SPRING DATA
    _useExistingParamsFront = springProvider.existingFront;
    frontSpring = springProvider.front!;
    frontSpringParams =
        _springList.where((spring) => spring.posizione == "Ant").toList();
    frontSpringIds = frontSpringParams.map((param) => param.id).toList();
    _controllerFrontCodifica.text = frontSpring.codifica;
    _controllerFrontAltezza.text = frontSpring.altezza.toString();
    _controllerFrontPosArb.text = frontSpring.posizioneArb;
    _controllerFrontRigArb.text = frontSpring.rigidezzaArb;

    // REAR SPRING DATA
    _useExistingParamsRear = springProvider.existingRear;
    rearSpring = springProvider.rear!;
    rearSpringParams =
        _springList.where((spring) => spring.posizione == "Post").toList();
    rearSpringIds = rearSpringParams.map((param) => param.id).toList();
    _controllerRearCodifica.text = rearSpring.codifica;
    _controllerRearAltezza.text = rearSpring.altezza.toString();
    _controllerRearPosArb.text = rearSpring.posizioneArb;
    _controllerRearRigArb.text = rearSpring.rigidezzaArb;
  }

  late SpringProvider springProvider;

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
  late Spring frontSpring;
  late List<Spring> frontSpringParams;
  late List<int> frontSpringIds;
  TextEditingController _controllerFrontCodifica = TextEditingController();
  TextEditingController _controllerFrontPosArb = TextEditingController();
  TextEditingController _controllerFrontRigArb = TextEditingController();
  TextEditingController _controllerFrontAltezza = TextEditingController();

  // FRONT METHOD
  _changeDropdownItemFront(int? SpringId) {
    Spring frontNewSpring =
        frontSpringParams.where((element) => element.id == SpringId!).first;

    setState(() {
      frontSpring = frontNewSpring;

      springProvider.front = frontSpring;
      springProvider.existingFront = true;

      _controllerFrontCodifica.text = frontNewSpring.codifica.toString();
      _controllerFrontAltezza.text = frontNewSpring.altezza.toString();
      _controllerFrontPosArb.text = frontNewSpring.posizioneArb;
      _controllerFrontRigArb.text = frontNewSpring.rigidezzaArb;
    });
  }

  _changeStateFrontCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsFront = newValue!;
      if (_useExistingParamsFront) {
        frontSpring = frontSpringParams.first;

        _controllerFrontCodifica.text = frontSpring.codifica;
        _controllerFrontAltezza.text = frontSpring.altezza.toString();
        _controllerFrontPosArb.text = frontSpring.posizioneArb;
        _controllerFrontRigArb.text = frontSpring.rigidezzaArb;

        springProvider.front = frontSpring;
        springProvider.existingFront = true;
      } else {
        springProvider.front = null;

        _controllerFrontCodifica.clear();
        _controllerFrontAltezza.clear();
        _controllerFrontRigArb.clear();
        _controllerFrontPosArb.clear();
        springProvider.existingFront = false;
      }
    });
  }

  _checkNewValuesUsedFront(String? text) {
    bool allInputFieldsFilled = true;

    List<String> controllersTexts = [
      _controllerFrontCodifica.text,
      _controllerFrontAltezza.text
    ];

    final Iterator<String> iterator = controllersTexts.iterator;

    while (iterator.moveNext()) {
      if (iterator.current.isEmpty) {
        allInputFieldsFilled = false;
      }
    }
    if (allInputFieldsFilled) {
      if (double.tryParse(_controllerFrontAltezza.text) != null) {
        var result = findFrontSpringFromExistingParams(
            _controllerFrontCodifica.text,
            _controllerFrontAltezza.text,
            _controllerFrontRigArb.text,
            _controllerFrontPosArb.text);

        Spring spring;

        if (result != null) {
          spring = result;
        } else {
          spring = Spring(
              id: 0,
              posizione: "Ant",
              altezza: double.parse(_controllerFrontAltezza.text),
              codifica: _controllerFrontCodifica.text,
              posizioneArb: _controllerFrontPosArb.text,
              rigidezzaArb: _controllerFrontRigArb.text);
        }
        springProvider.front = spring;
        springProvider.existingFront = false;
      } else {
        showToast(
            "L'altezza della molla anteriore deve rappresentare un numero");
        springProvider.front = null;
      }
    } else {
      springProvider.front = null;
    }
  }

  // REAR DATA
  late bool _useExistingParamsRear;
  late Spring rearSpring;
  late List<Spring> rearSpringParams;
  late List<int> rearSpringIds;
  TextEditingController _controllerRearCodifica = TextEditingController();
  TextEditingController _controllerRearPosArb = TextEditingController();
  TextEditingController _controllerRearRigArb = TextEditingController();
  TextEditingController _controllerRearAltezza = TextEditingController();

  // REAR METHOD
  _changeDropdownItemRear(int? SpringId) {
    Spring rearNewSpring =
        rearSpringParams.where((element) => element.id == SpringId!).first;

    setState(() {
      rearSpring = rearNewSpring;

      springProvider.rear = rearSpring;
      springProvider.existingRear = true;

      _controllerRearCodifica.text = rearNewSpring.codifica.toString();
      _controllerRearAltezza.text = rearNewSpring.altezza.toString();
      _controllerRearPosArb.text = rearNewSpring.posizioneArb;
      _controllerRearRigArb.text = rearNewSpring.rigidezzaArb;
    });
  }

  _changeStateRearCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsRear = newValue!;
      if (_useExistingParamsRear) {
        rearSpring = rearSpringParams.first;

        _controllerRearCodifica.text = rearSpring.codifica;
        _controllerRearAltezza.text = rearSpring.altezza.toString();
        _controllerRearPosArb.text = rearSpring.posizioneArb;
        _controllerRearRigArb.text = rearSpring.rigidezzaArb;

        springProvider.rear = rearSpring;
        springProvider.existingRear = true;
      } else {
        springProvider.rear = null;

        _controllerRearCodifica.clear();
        _controllerRearAltezza.clear();
        _controllerRearRigArb.clear();
        _controllerRearPosArb.clear();
        springProvider.existingRear = false;
      }
    });
  }

  _checkNewValuesUsedRear(String? text) {
    bool allInputFieldsFilled = true;

    List<String> controllersTexts = [
      _controllerRearCodifica.text,
      _controllerRearAltezza.text
    ];

    final Iterator<String> iterator = controllersTexts.iterator;

    while (iterator.moveNext()) {
      if (iterator.current.isEmpty) {
        allInputFieldsFilled = false;
      }
    }
    if (allInputFieldsFilled) {
      if (double.tryParse(_controllerRearAltezza.text) != null) {
        var result = findRearSpringFromExistingParams(
            _controllerRearCodifica.text, _controllerRearAltezza.text,
            _controllerRearRigArb.text, _controllerRearPosArb.text);

        Spring spring;

        if (result != null) {
          spring = result;
        } else {
          spring = Spring(
              id: 0,
              posizione: "Post",
              altezza: double.parse(_controllerRearAltezza.text),
              codifica: _controllerRearCodifica.text,
              posizioneArb: _controllerRearPosArb.text,
              rigidezzaArb: _controllerRearRigArb.text);
        }
        springProvider.rear = spring;
        springProvider.existingRear = false;
      } else {
        showToast(
            "L'altezza della molla posteriori deve rappresentare un numero");
        springProvider.rear = null;
      }
    } else {
      springProvider.rear = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _springService = SpringService();

    _dataLoading = _getSpringParams();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataLoading,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
            return Expanded(
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
            ));
          }
        }
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
              value: frontSpring.id,
              items: frontSpringIds.map<DropdownMenuItem<int>>((int value) {
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
                          controller: _controllerFrontCodifica,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // POSIZIONE ARB
                  Text("Posizione arb"),
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
                            hintText: 'Posizione arb',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontPosArb,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // ALTEZZA
                  Text("Altezza"),
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
                            hintText: 'Altezza',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontAltezza,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // RIGIDEZZA ARB
                  Text("Rigidezza arb"),
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
                            hintText: 'Rigidezza arb',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerFrontRigArb,
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
                            controller: _controllerFrontCodifica,
                            onChanged: _checkNewValuesUsedFront,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // POSIZIONE ARB
                    Text("Posizione arb"),
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
                              hintText: 'Posizione arb',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontPosArb,
                            onChanged: _checkNewValuesUsedFront,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // ALTEZZA
                    Text("Altezza"),
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
                              hintText: 'Altezza',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontAltezza,
                            onChanged: _checkNewValuesUsedFront,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // RIGIDEZZA ARB
                    Text("Rigidezza arb"),
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
                              hintText: 'Rigidezza arb',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontRigArb,
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
              value: rearSpring.id,
              items: rearSpringIds.map<DropdownMenuItem<int>>((int value) {
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
                          controller: _controllerRearCodifica,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // POSIZIONE ARB
                  Text("Posizione arb"),
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
                            hintText: 'Posizione arb',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearPosArb,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // ALTEZZA
                  Text("Altezza"),
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
                            hintText: 'Altezza',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearAltezza,
                        )),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // RIGIDEZZA ARB
                  Text("Rigidezza arb"),
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
                            hintText: 'Rigidezza arb',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _controllerRearRigArb,
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
                            controller: _controllerRearCodifica,
                            onChanged: _checkNewValuesUsedRear,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // POSIZIONE ARB
                    Text("Posizione arb"),
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
                              hintText: 'Posizione arb',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearPosArb,
                            onChanged: _checkNewValuesUsedRear,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // ALTEZZA
                    Text("Altezza"),
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
                              hintText: 'Altezza',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearAltezza,
                            onChanged: _checkNewValuesUsedRear,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // RIGIDEZZA ARB
                    Text("Rigidezza arb"),
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
                              hintText: 'Rigidezza arb',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearRigArb,
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

  Spring? findExistingParams(String posizione, String codifica, String altezza,
      String rigArb, String posArb) {
    if (_springList
        .where((spring) =>
            spring.posizione == posizione &&
            spring.codifica == codifica &&
            spring.altezza == double.parse(altezza) &&
            spring.rigidezzaArb == rigArb &&
            spring.posizioneArb == posArb
        )
        .isNotEmpty) {
      return _springList
        .where((spring) =>
            spring.posizione == posizione &&
            spring.codifica == codifica &&
            spring.altezza == double.parse(altezza) &&
            spring.rigidezzaArb == rigArb &&
            spring.posizioneArb == posArb
        )
        .first;
    }
    return null;
  }

  Spring? findFrontSpringFromExistingParams(
      String codifica, String altezza, String rigArb, String posArb) {
    return findExistingParams("Ant", codifica, altezza, rigArb, posArb);
  }

  Spring? findRearSpringFromExistingParams(String codifica, String altezza, String rigArb, String posArb) {
    return findExistingParams("Post", codifica, altezza, rigArb, posArb);
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/balance/balance_provider.dart';
import 'package:polimarche/services/setup_service.dart';
import 'package:provider/provider.dart';

import '../../../../../../model/Balance.dart';

class BalancePage extends StatefulWidget {
  final SetupService setupService;

  const BalancePage(
      {super.key, required this.setupService});

  static List<Balance?> balanceOf(BuildContext context) {
    final balanceProvider =
        Provider.of<BalanceProvider>(context, listen: false);

    final List<Balance?> balance = [
      balanceProvider.front,
      balanceProvider.rear
    ];

    return balance;
  }

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final Color backgroundColor = Colors.grey.shade300;
  late final SetupService setupService;

  late BalanceProvider balanceProvider;
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
  late Balance frontBalance;
  late List<Balance> frontBalanceParams;
  late List<int> frontBalanceIds;
  TextEditingController _controllerFrontPeso = TextEditingController();
  TextEditingController _controllerFrontFrenata = TextEditingController();

  // FRONT METHOD
  _changeDropdownItemFront(int? BalanceId) {
    Balance frontNewBalance =
        frontBalanceParams.where((element) => element.id == BalanceId!).first;

    setState(() {
      frontBalance = frontNewBalance;

      balanceProvider.front = frontBalance;
      balanceProvider.existingFront = true;

      _controllerFrontPeso.text = frontNewBalance.peso.toString();
      _controllerFrontFrenata.text = frontNewBalance.frenata.toString();
    });
  }

  _changeStateFrontCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsFront = newValue!;
      if (_useExistingParamsFront) {
        frontBalance = setupService.findFrontBalanceParams().first;

        _controllerFrontPeso.text = frontBalance.peso.toString();
        _controllerFrontFrenata.text = frontBalance.frenata.toString();

        balanceProvider.front = frontBalance;
        balanceProvider.existingFront = true;
      } else {
        balanceProvider.front = null;

        _controllerFrontPeso.clear();
        _controllerFrontFrenata.clear();
        balanceProvider.existingFront = false;
      }
    });
  }

  _checkNewValuesUsedFront(String? text) {
    bool allInputFieldsFilled = true;

    List<String> controllersTexts = [
      _controllerFrontPeso.text,
      _controllerFrontFrenata.text
    ];

    final Iterator<String> iterator = controllersTexts.iterator;

    while (iterator.moveNext()) {
      if (iterator.current.isEmpty) {
        allInputFieldsFilled = false;
      }
    }
    if (allInputFieldsFilled) {
      if (double.tryParse(_controllerFrontFrenata.text) != null) {
        if (double.tryParse(_controllerFrontPeso.text) != null) {
          var result = setupService.findFrontBalanceFromExistingParams(
              _controllerFrontPeso.text, _controllerFrontFrenata.text);

          Balance balance;

          if (result != false) {
            balance = result;
          } else {
            balance = Balance(
                id: setupService.listBalance.fold<int>(
                        0,
                        (maxValue, item) =>
                            maxValue > item.id ? maxValue : item.id) +
                    1,
                posizione: "Ant",
                peso: double.parse(_controllerFrontPeso.text),
                frenata: double.parse(_controllerFrontFrenata.text));
          }
          balanceProvider.front = balance;
          balanceProvider.existingFront = false;
        } else {
          showToast("Il peso anteriore deve rappresentare un numero");
        }
      } else {
        showToast("La frenata anteriore deve rappresentare un numero");
      }
    }
  }

  // REAR DATA
  late bool _useExistingParamsRear;
  late Balance rearBalance;
  late List<Balance> rearBalanceParams;
  late List<int> rearBalanceIds;
  TextEditingController _controllerRearPeso = TextEditingController();
  TextEditingController _controllerRearFrenata = TextEditingController();

  // REAR METHOD
  _changeDropdownItemRear(int? BalanceId) {
    Balance rearNewBalance =
        rearBalanceParams.where((element) => element.id == BalanceId!).first;

    setState(() {
      rearBalance = rearNewBalance;

      balanceProvider.rear = rearBalance;
      balanceProvider.existingRear = true;

      _controllerRearPeso.text = rearNewBalance.peso.toString();
      _controllerRearFrenata.text = rearNewBalance.frenata.toString();
    });
  }

  _changeStateRearCheckbox(bool? newValue) {
    setState(() {
      _useExistingParamsRear = newValue!;
      if (_useExistingParamsRear) {
        rearBalance = setupService.findRearBalanceParams().first;

        _controllerRearPeso.text = rearBalance.peso.toString();
        _controllerRearFrenata.text = rearBalance.frenata.toString();

        balanceProvider.rear = rearBalance;
        balanceProvider.existingRear = true;
      } else {
        balanceProvider.rear = null;

        _controllerRearPeso.clear();
        _controllerRearFrenata.clear();
        balanceProvider.existingRear = false;
      }
    });
  }

  _checkNewValuesUsedRear(String? text) {
    bool allInputFieldsFilled = true;

    List<String> controllersTexts = [
      _controllerRearPeso.text,
      _controllerRearFrenata.text
    ];

    final Iterator<String> iterator = controllersTexts.iterator;

    while (iterator.moveNext()) {
      if (iterator.current.isEmpty) {
        allInputFieldsFilled = false;
      }
    }

    if (allInputFieldsFilled) {
      if (double.tryParse(_controllerRearFrenata.text) != null) {
        if (double.tryParse(_controllerRearPeso.text) != null) {
          var result = setupService.findRearBalanceFromExistingParams(
              _controllerRearPeso.text, _controllerRearFrenata.text);

          Balance balance;
          if (result != false) {
            balance = result;
          } else {
            balance = Balance(
                id: setupService.listBalance.fold<int>(
                        0,
                        (maxValue, item) =>
                            maxValue > item.id ? maxValue : item.id) +
                    1,
                posizione: "Post",
                peso: double.parse(_controllerRearPeso.text),
                frenata: double.parse(_controllerRearFrenata.text));
          }
          balanceProvider.rear = balance;
          balanceProvider.existingRear = false;
        } else {
          showToast("Il peso posteriore deve rappresentare un numero");
        }
      } else {
        showToast("La frenata posteriore deve rappresentare un numero");
      }
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setupService = widget.setupService;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      balanceProvider = Provider.of<BalanceProvider>(context, listen: false);

      // FRONT BALANCE DATA
      _useExistingParamsFront = balanceProvider.existingFront;
      frontBalance = balanceProvider.front!;
      frontBalanceParams = setupService.findFrontBalanceParams();
      frontBalanceIds = frontBalanceParams.map((param) => param.id).toList();
      _controllerFrontPeso.text = frontBalance.peso.toString();
      _controllerFrontFrenata.text = frontBalance.frenata.toString();

      // REAR BALANCE DATA
      _useExistingParamsRear = balanceProvider.existingRear;
      rearBalance = balanceProvider.rear!;
      rearBalanceParams = setupService.findRearBalanceParams();
      rearBalanceIds = rearBalanceParams.map((param) => param.id).toList();
      _controllerRearPeso.text = rearBalance.peso.toString();
      _controllerRearFrenata.text = rearBalance.frenata.toString();

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
              value: frontBalance.id,
              items: frontBalanceIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemFront),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PESO
            Text("Peso (%)"),
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
                      hintText: 'Peso',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _controllerFrontPeso,
                  )),
            ),
            SizedBox(
              height: 20,
            ),

            // FRENATA
            Text("Frenata (%)"),
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
                      hintText: 'Frenata',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _controllerFrontFrenata,
                  )),
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
                    // PESO
                    Text("Peso (%)"),
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
                              hintText: 'Peso',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontPeso,
                            onSubmitted: _checkNewValuesUsedFront,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Frenata
                    Text("Frenata (%)"),
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
                              hintText: 'Frenata',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerFrontFrenata,
                            onSubmitted: _checkNewValuesUsedFront,
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
              value: rearBalance.id,
              items: rearBalanceIds.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Id: ${value}"),
                );
              }).toList(),
              onChanged: _changeDropdownItemRear),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PESO
            Text("Peso (%)"),
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
                      hintText: 'Peso',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _controllerRearPeso,
                  )),
            ),
            SizedBox(
              height: 20,
            ),

            // FRENATA
            Text("Frenata (%)"),
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
                      hintText: 'Frenata',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _controllerRearFrenata,
                  )),
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
                    // PESO
                    Text("Peso (%)"),
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
                              hintText: 'Peso',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearPeso,
                            onSubmitted: _checkNewValuesUsedRear,
                          )),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Frenata
                    Text("Frenata (%)"),
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
                              hintText: 'Frenata',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: _controllerRearFrenata,
                            onSubmitted: _checkNewValuesUsedRear,
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

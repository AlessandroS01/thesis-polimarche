import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:polimarche/auth/auth.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/service/member_service.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;

class NewMemberPage extends StatefulWidget {
  const NewMemberPage({
    super.key,
  });

  @override
  State<NewMemberPage> createState() => _NewMemberPageState();
}

class _NewMemberPageState extends State<NewMemberPage>
    with TickerProviderStateMixin {
  // GENERAL DATA
  late AnimationController _animationController;
  final backgroundColor = Colors.grey.shade300;
  late final MemberService _memberService;

  int _progress = 1;
  final _totalSteps = 2;
  List<String> _stepsName = ["Dati personali", "Reparto"];
  bool _isDataLoading = false;

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

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  Future<void> sendEmail(
      String email, String matricola, String password) async {
    final serviceId = 'service_kqs9c68';
    final templateId = 'template_uyzffet';
    final userId = 'Kg7SD8WXoj92jdPcG';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    await http.post(url,
        headers: {
          'origin': 'http//localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_email': email,
            'user_matricola': matricola,
            'user_password': password
          }
        }));
  }

  Future<void> _addMember() async {
    String email = "s" + _controllerMatricola.text + "@studenti.univpm.it";
    String password = getRandomString(20);

    Auth _auth = Auth();
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String role = "";
      String reparto = "";

      if (_membroSelected) {
        role = "Membro";
        reparto = areaSelected;
      }
      if (_managerSelected) role = "Manager";
      if (_caporepartoSelected) {
        role = "Caporeparto";
        reparto = areaSelected;
      }

      Member newMember = Member(
          matricola: int.parse(_controllerMatricola.text),
          nome: _controllerNome.text,
          cognome: _controllerCognome.text,
          dob: newDate,
          email: email,
          telefono: int.parse(_controllerTelefono.text),
          ruolo: role,
          reparto: reparto,
          uid: user.user?.uid);

      await _memberService.createNewMember(newMember);

      await sendEmail(email, _controllerMatricola.text, password);

      _controllerMatricola.clear();
      _controllerNome.clear();
      _controllerCognome.clear();
      _controllerTelefono.clear();
      newDate = DateTime(2000);

      setState(() {
        _progress = 1;
      });

      showToast(
          "Il componente del team è stato creato con successo. Le credenziali sono state inviate sulla sua email.");
    } catch (e) {
      showToast("Un membro con la matricola inserita è già presente");
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
  TextEditingController _controllerMatricola = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerCognome = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();

  bool isDateButtonPressed = false;
  DateTime newDate = DateTime(2000);

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
        initialDate: DateTime(2000),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());

    if (date != null) {
      setState(() {
        newDate = date;
      });
    }
  }

  // SECOND STEP DATA
  bool _managerSelected = false;
  bool _caporepartoSelected = false;
  bool _membroSelected = true;

  String areaSelected = "Telaio";

  List<String> _workshopAreas = [
    "Telaio",
    "Aereodinamica",
    "Dinamica",
    "Battery pack",
    "Elettronica",
    "Controlli",
    "Statica"
  ];

  @override
  void initState() {
    super.initState();
    _memberService = MemberService();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Adjust duration as needed
    );
  }

  @override
  void dispose() {
    _controllerMatricola.dispose();
    _controllerNome.dispose();
    _controllerCognome.dispose();
    _controllerTelefono.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIRST STEP DATA
    Offset distanceDate = isDateButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurDate = isDateButtonPressed ? 5.0 : 30.0;

    return Scaffold(
      appBar: _appBar(backgroundColor),
      backgroundColor: backgroundColor,
      bottomNavigationBar: _bottomNavBar(),
      body: _isDataLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                SizedBox(height: 40),
                _progress == 1 // FIRST STEP
                    ? _firstStep(distanceDate, blurDate)
                    : _secondStep(),
              ],
            ),
    );
  }

  /*
  -------------------- FIRST STEP--------------------
   */

  Expanded _firstStep(Offset distanceDate, double blurDate) => Expanded(
        child: Container(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll
                  .disallowIndicator(); // Disable the overscroll glow effect
              return false;
            },
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "Matricola",
                    style: TextStyle(fontSize: 16),
                  ),
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
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'aleo',
                            letterSpacing: 1),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Matricola',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controllerMatricola,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Nome e cognome",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
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
                                hintText: 'Nome',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              controller: _controllerNome,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
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
                                hintText: 'Cognome',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              controller: _controllerCognome,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Telefono",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                          hintText: 'Telefono',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controllerTelefono,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Data di nascita",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                _dateButton(distanceDate, blurDate),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      );

  // DATE
  Listener _dateButton(
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
        margin: EdgeInsets.symmetric(horizontal: 30),
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
        child:
            Center(child: Text("${DateFormat.yMMMMEEEEd().format(newDate)}")),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Posizione nel team",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Membro"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _membroSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                _membroSelected = value!;
                                _caporepartoSelected = false;
                                _managerSelected = false;
                              });
                            },
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Caporeparto"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _caporepartoSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                _caporepartoSelected = value!;
                                _membroSelected = false;
                                _managerSelected = false;
                              });
                            },
                          ),
                        ],
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Manager"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _managerSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                _managerSelected = value!;
                                _caporepartoSelected = false;
                                _membroSelected = false;
                              });
                            },
                          ),
                        ],
                      )),
                    ],
                  ),
                  if (!_managerSelected)
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          padding: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor: backgroundColor,
                          value: areaSelected,
                          items: _workshopAreas
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? workshopArea) {
                            setState(() {
                              areaSelected = workshopArea!;
                            });
                          }),
                    ),
                ],
              ),
            ),
          ),
        ),
      );

  Container _bottomNavBar() {
    return Container(
      color: backgroundColor,
      child: Container(
        child: GNav(
          iconSize: 30,
          backgroundColor: Colors.grey.shade300,
          color: Colors.black,
          activeColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
          gap: 8,
          tabs: [
            _progress > 1 && !_isDataLoading
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
            _progress != 2
                ? GButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      if (_controllerMatricola.text.isNotEmpty &&
                          int.tryParse(_controllerMatricola.text) != null &&
                          int.parse(_controllerMatricola.text) > 0) {
                        if (_controllerNome.text.isNotEmpty &&
                            _controllerCognome.text.isNotEmpty) {
                          if (_controllerTelefono.text.isNotEmpty &&
                              int.tryParse(_controllerTelefono.text) != null &&
                              int.parse(_controllerTelefono.text) > 0) {
                            _nextStep();
                          } else {
                            showToast("Specificare il telefono");
                          }
                        } else {
                          showToast("Specificare il nome e/o cognome");
                        }
                      } else {
                        showToast("Specificare la matricola");
                      }
                    },
                  )
                : !_isDataLoading
                    ? GButton(
                        icon: Icons.save_alt,
                        onPressed: () async {
                          if (_animationController.isAnimating) {
                            return;
                          }
                          await _animationController.forward();

                          if (_membroSelected ||
                              _caporepartoSelected ||
                              _managerSelected) {
                            setState(() {
                              _isDataLoading = true;
                            });
                            await _addMember();
                            setState(() {
                              _isDataLoading = false;
                            });
                          } else {
                            showToast("Speficare il ruolo");
                          }

                          _animationController.reset();
                        },
                      )
                    : GButton(
                        icon: Icons.flag_outlined,
                        leading: Badge(
                          backgroundColor: backgroundColor,
                        )),
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
        "Nuovo membro",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

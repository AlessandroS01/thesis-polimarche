import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/home/team/member_card.dart';

import '../../../model/driver_model.dart';
import '../../../service/driver_service.dart';

class DetailMember extends StatefulWidget {
  final Member member;
  final Driver? driver;
  final Member loggedMember;

  const DetailMember({
    required this.member,
    required this.driver,
    required this.loggedMember,
  });

  @override
  State<DetailMember> createState() => _DetailMemberState();
}

class _DetailMemberState extends State<DetailMember> {
  final backgroundColor = Colors.grey.shade300;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  bool setDriverPressed = false;
  bool isConfirmPressed = false;

  final Offset distanceDriver = Offset(5, 5);
  final double blurDriver = 10;
  DriverService driverService = DriverService();
  late final Member loggedMember;

  late final member;
  late final driver;
  late final memberCard;

  @override
  void initState() {
    super.initState();

    loggedMember = widget.loggedMember;
    member = widget.member;
    driver = widget.driver;

    memberCard = CardMember(driver: driver, member: member);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context)
              .size
              .height, // Set a finite height constraint
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // MEMBER CARD
              memberCard,

              driver == null && loggedMember.ruolo == "Manager"
                  ? Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification:
                              (OverscrollIndicatorNotification overscroll) {
                            overscroll
                                .disallowIndicator(); // Disable the overscroll glow effect
                            return false;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _addDriverButton(),
                                  setDriverPressed
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                            children: [
                                              // SET HEIGHT AND WEIGHT OF THE DRIVER
                                              _inputBioValuesDriver(),
                                              // ADD THE DRIVER
                                              _addDriverConfirm()
                                            ],
                                          ),
                                        )
                                      : SizedBox(height: 0)
                                ]),
                          ),
                        ),
                      ))
                  : Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Dettagli membro",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Container _addDriverConfirm() {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100),
      child: Center(
        child: Listener(
                onPointerDown: (_) async {
                  setState(() => isConfirmPressed = true);

                  await Future.delayed(
                      const Duration(milliseconds: 200)); // Wait for animation

                  String heightText = _heightController.text;
                  String weightText = _weightController.text;

                  double weight = 0.0;
                  int height = 0;

                  if (checkInputText(heightText) &&
                      checkInputText(weightText)) {
                    //check num values
                    if (convertHeight(heightText)) {
                      // check if height is an int
                      height = int.parse(heightText);
                      if (convertWeight(weightText)) {
                        // check if weight is a double
                        weight = double.parse(weightText);
                        if (height > 0 && height < 250) {  // check height boundaries

                          if (weight > 40.0 && weight < 150.0) { // check weight boundaries

                            try {
                              await driverService.addNewDriver(height, weight, member);
                              showToast("Pilota aggiunto");
                              Navigator.pop(context); // Navigate back
                            } catch (e) {
                              showToast("Errore durante l'aggiunta del pilota");
                            }

                          } else {
                            showToast(
                                "Il peso deve essere compreso tra 40 e 150");
                          }
                        } else {
                          showToast("Altezza deve essere compreso tra 0 e 250");
                        }
                      } else if (int.tryParse(weightText) != null) {
                        // check if weight is an int
                        weight = int.parse(weightText).toDouble();
                        if (height > 0 && height < 250) {
                          // check height boundaries
                          if (weight > 40.0 && weight < 150.0) {

                            try {
                              await driverService.addNewDriver(height, weight, member);
                              showToast("Pilota aggiunto");
                              Navigator.pop(context); // Navigate back
                            } catch (e) {
                              showToast("Errore durante l'aggiunta del pilota");
                            }

                          } else {
                            showToast(
                                "Il peso deve essere compreso tra 40 e 150");
                          }
                        } else {
                          showToast("Altezza deve essere compreso tra 0 e 250");
                        }
                      } else {
                        showToast(
                            "Il campo relativo al peso deve contenere un intero o un decimale.");
                      }
                    } else {
                      showToast(
                          "Il campo relativo all'altezza deve contenere un intero.");
                    }
                  } else {
                    showToast("I campi devono essere numerici.");
                  }

                  setState(() => isConfirmPressed = false); // Reset the state,
                },
                child: AnimatedContainer(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                  duration: Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: isConfirmPressed
                          ? [
                              BoxShadow(
                                  offset: Offset(5, 5),
                                  blurRadius: 15,
                                  color: Colors.grey.shade500,
                                  inset: true),
                              BoxShadow(
                                  offset: -Offset(5, 5),
                                  blurRadius: 15,
                                  color: Colors.white,
                                  inset: true),
                            ]
                          : []),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Aggiungi",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Icon(
                          Icons.add_circle_outline_sharp,
                          color: Colors.black,
                        )
                      ]),
                ),
              ),
      ),
    );
  }

  Row _inputBioValuesDriver() {
    return Row(
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              margin: EdgeInsets.symmetric(horizontal: 30),
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
                inputFormatters: [LengthLimitingTextInputFormatter(3)],
                controller: _heightController,
                cursorColor: Colors.black,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Altezza (cm)',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              )),
        ),
        Expanded(
          child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              margin: EdgeInsets.symmetric(horizontal: 30),
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
                controller: _weightController,
                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                cursorColor: Colors.black,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Peso (kg)',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              )),
        ),
      ],
    );
  }

  Align _addDriverButton() {
    return Align(
      alignment: Alignment.topCenter,
      child: Listener(
        onPointerDown: (_) async {
          setState(
              () => setDriverPressed = !setDriverPressed); // Toggle the state
          await Future.delayed(Duration(milliseconds: 200));
        },
        child: AnimatedContainer(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          duration: Duration(milliseconds: 150),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: setDriverPressed
                  ? [
                      //
                      BoxShadow(
                          color: Colors.grey.shade500,
                          offset: distanceDriver,
                          blurRadius: blurDriver,
                          inset: setDriverPressed),
                      BoxShadow(
                          color: Colors.white,
                          offset: -distanceDriver,
                          blurRadius: blurDriver,
                          inset: setDriverPressed),
                    ]
                  : []),
          child: SvgPicture.asset("assets/icon/driver.svg"),
        ),
      ),
    );
  }

  // used to check height input text
  bool checkInputText(String inputText) {
    return num.tryParse(inputText) != null;
  }

  bool convertHeight(String heightText) {
    return int.tryParse(heightText) != null;
  }

  bool convertWeight(String weightText) {
    return double.tryParse(weightText) != null;
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

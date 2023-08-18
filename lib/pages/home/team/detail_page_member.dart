import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optional/optional.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/pages/home/cards/member_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../inherited_widgets/authorization_provider.dart';
import '../../../model/Driver.dart';


class DetailMember extends StatefulWidget {
  final Optional<Driver> driver;
  final Member member;
  final Member loggedMember;

  const DetailMember({super.key,
    required this.driver,
    required this.member,
    required this.loggedMember
  });

  @override
  State<DetailMember> createState() => _DetailMemberState();
}

class _DetailMemberState extends State<DetailMember> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool isBackButtonPressed = false;

  bool setDriverPressed = false;
  bool isConfirmPressed = false;


  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loggedMember = widget.loggedMember;

    final driver = widget.driver;
    final member = widget.member;

    final backgroundColor = Colors.grey.shade300;
    final Offset distance = Offset(5, 5);
    final double blur = 20;

    Offset distanceDriver = Offset(5, 5);
    double blurDriver = 10;

    CardMember memberCard = CardMember(driver: driver, member: member);

    return Scaffold(

      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height, // Set a finite height constraint
            decoration: BoxDecoration(
              color: backgroundColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // BACK BUTTON
                _backButton(context, backgroundColor, distance, blur),

                // MEMBER CARD
                memberCard,

                !driver.isPresent && loggedMember.ruolo == "Manager"
                    ? _addDriverButton(backgroundColor, distanceDriver, blurDriver)
                    : SizedBox(height: 0),

                setDriverPressed ? Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        // SET HEIGHT AND WEIGHT OF THE DRIVER
                        _inputBioValuesDriver(backgroundColor),
                        // ADD THE DRIVER
                        _addDriverConfirm(backgroundColor)
                      ],
                    ),
                  ),
                )
                    : SizedBox(height: 0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _addDriverConfirm(Color backgroundColor) {
    return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 100),
                          child: Center(
                            child: Listener(
                              onPointerDown: (_) async {
                                setState(() => isConfirmPressed = true); // Reset the state
                                await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation

                                String heightText = _heightController.text;
                                String weightText = _weightController.text;

                                double weight = 0.0 ;
                                int height = 0;

                                if (checkInputText(heightText) && checkInputText(weightText)) { //check num values
                                  if (convertHeight(heightText)) { // check if height is an int
                                    height = int.parse(heightText);
                                    if (convertWeight(weightText)) { // check if weight is a double
                                      weight = double.parse(weightText);
                                      if (height > 0 && height < 250) { // check height boundaries
                                        if (weight > 40.0 && weight < 150.0) { // check weight boundaries
                                          showToast("Pilota aggiunto");
                                          Navigator.pop(context);
                                        } else {
                                          showToast("Il peso deve essere compreso tra 40 e 150");
                                        }
                                      } else {
                                        showToast("Altezza deve essere compreso tra 0 e 250");
                                      }
                                    } else if (int.tryParse(weightText) != null) { // check if weight is an int
                                      weight = int.parse(weightText).toDouble();
                                      if (height > 0 && height < 250) { // check height boundaries
                                        if (weight > 40.0 && weight < 150.0) { // check weight boundaries
                                          showToast("Pilota aggiunto");
                                          Navigator.pop(context);
                                        } else {
                                          showToast("Il peso deve essere compreso tra 40 e 150");
                                        }
                                      } else {
                                        showToast("Altezza deve essere compreso tra 0 e 250");
                                      }
                                    } else {
                                      showToast("Il campo relativo al peso deve contenere un intero o un decimale.");
                                    }
                                  } else {
                                    showToast("Il campo relativo all'altezza deve contenere un intero.");
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
                                    boxShadow: isConfirmPressed ? [
                                      BoxShadow(
                                        offset: Offset(5, 5),
                                        blurRadius: 15,
                                        color: Colors.grey.shade500,
                                        inset: true
                                      ),
                                      BoxShadow(
                                        offset: -Offset(5, 5),
                                        blurRadius: 15,
                                        color: Colors.white,
                                        inset: true
                                      ),
                                    ] : []
                                  ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Aggiungi",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black
                                        ),
                                    ),
                                    Icon(
                                        Icons.add_circle_outline_sharp,
                                        color: Colors.black,
                                    )
                                  ]
                              ),
                            ),
                           ),
                          ),
                        ),
    );
  }

  Row _inputBioValuesDriver(Color backgroundColor) {
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3)
                                ],
                                controller: _heightController,
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'aleo',
                                      letterSpacing: 1
                                  ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Altezza (cm)',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              )
                            ),
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
                                keyboardType: TextInputType.number,
                                controller: _weightController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4)
                                ],
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'aleo',
                                      letterSpacing: 1
                                  ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Peso (kg)',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              )
                            ),
                          ),
                        ],
                      );
  }

  Align _addDriverButton(Color backgroundColor, Offset distanceDriver, double blurDriver) {
    return Align(
                alignment: Alignment.topCenter,
                child: Listener(
                  onPointerDown: (_) async {
                    setState(() => setDriverPressed = !setDriverPressed); // Toggle the state
                    await Future.delayed(Duration(milliseconds: 200));

                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: setDriverPressed ? [
                          //
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: distanceDriver,
                              blurRadius: blurDriver,
                              inset: setDriverPressed
                          ),
                          BoxShadow(
                              color: Colors.white,
                              offset: -distanceDriver,
                              blurRadius: blurDriver,
                              inset: setDriverPressed
                          ),
                        ] : []
                    ),
                    child: SvgPicture.asset("assets/icon/driver.svg"),
                  ),
                ),
              );
  }

  Listener _backButton(BuildContext context, Color backgroundColor, Offset distance, double blur) {
    return Listener(
                onPointerDown: (_) async {
                  setState(() {isBackButtonPressed = true;});
                  await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation
                  Navigator.pop(context);
                },

                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    margin: EdgeInsets.fromLTRB(20, 40, 0, 40),
                    padding: EdgeInsets.all(15),
                    duration: Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        shape: BoxShape.circle,
                        boxShadow: isBackButtonPressed
                            ? []
                            : [
                              BoxShadow(
                                  offset: distance,
                                  blurRadius: blur,
                                  color: Colors.grey.shade500
                              ),
                              BoxShadow(
                                  offset: -distance,
                                  blurRadius: blur,
                                  color: Colors.white
                              ),
                            ]
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )
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
      toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
      backgroundColor: Colors.grey[600], // Background color of the toast
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }


}


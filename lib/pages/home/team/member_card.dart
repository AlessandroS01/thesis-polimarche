import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../../model/driver_model.dart';
import '../../../model/member_model.dart';

class CardMember extends StatelessWidget {
  final Member member;
  final Driver? driver;
  CardMember({super.key, required this.driver, required this.member});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade300;

    return driver != null
        // DRIVER
        ? Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(8, 8),
                        blurRadius: 15,
                        color: Colors.grey.shade500),
                    BoxShadow(
                        offset: -Offset(8, 8),
                        blurRadius: 15,
                        color: Colors.white),
                  ]),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll
                      .disallowIndicator(); // Disable the overscroll glow effect
                  return false;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.all(40),
                          child: Icon(
                            Icons.person_3,
                            size: 80,
                            color: Colors.black,
                          )),
                      Center(
                        child: Text(
                          "S${member.matricola} - ${member.nome}, ${member.cognome}",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          member.ruolo == "Manager"
                              ? "${member.ruolo}"
                              : "${member.ruolo} in ${member.reparto}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${member.dob.year}-${member.dob.month}-${member.dob.day}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Column(children: [
                            Text(
                              "Pilota",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Text(
                              "Altezza ${driver!.altezza} cm",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              "Peso ${driver!.peso} kg",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors
                                      .transparent; // Remove the overlay color
                                },
                              ),
                            ),
                            onPressed: () {},
                            child: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                          ),
                          Text("${member.email}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors
                                      .transparent; // Remove the overlay color
                                },
                              ),
                            ),
                            onPressed: () {},
                            child: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                          ),
                          Text("${member.telefono}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        // MEMBER
        : Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(8, 8),
                        blurRadius: 15,
                        color: Colors.grey.shade500),
                    BoxShadow(
                        offset: -Offset(8, 8),
                        blurRadius: 15,
                        color: Colors.white),
                  ]),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll
                      .disallowIndicator(); // Disable the overscroll glow effect
                  return false;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.all(40),
                          child: Icon(
                            Icons.person_3,
                            size: 80,
                            color: Colors.black,
                          )),
                      Center(
                        child: Text(
                          "S${member.matricola} - ${member.nome}, ${member.cognome}",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          member.ruolo == "Manager"
                              ? "${member.ruolo}"
                              : "${member.ruolo} in ${member.reparto}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${member.dob.year}-${member.dob.month}-${member.dob.day}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Container(),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors
                                      .transparent; // Remove the overlay color
                                },
                              ),
                            ),
                            onPressed: () {},
                            child: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                          ),
                          Text("${member.email}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors
                                      .transparent; // Remove the overlay color
                                },
                              ),
                            ),
                            onPressed: () {},
                            child: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                          ),
                          Text("${member.telefono}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

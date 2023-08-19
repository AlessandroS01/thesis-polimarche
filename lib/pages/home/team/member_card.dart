import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:optional/optional_internal.dart';

import '../../../model/Driver.dart';
import '../../../model/Member.dart';

class CardMember extends StatelessWidget {
  final Optional<Driver> driver;
  final Member member;
  CardMember({super.key, required this.driver, required this.member});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade300;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(8, 8),
                blurRadius: 15,
                color: Colors.grey.shade500
            ),
            BoxShadow(
                offset: -Offset(8, 8),
                blurRadius: 15,
                color: Colors.white
            ),
          ]
      ),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(40),
              padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
              child: Icon(
                Icons.person_3,
                size: 80,
                color: Colors.black,
              )
          ),
          Center(
            child: Text(
              "S${member.matricola} - ${member.nome}, ${member.cognome}",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
              ),
            ),
          ),
          Center(
            child: Text(
              member.ruolo=="Manager"
                  ? "${member.ruolo}"
                  : "${member.ruolo} in ${member.reparto.reparto}" ,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black
              ),
            ),
          ),
          Center(
            child: Text(
              "${member.dob.year}-${member.dob.month}-${member.dob.day}",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black
              ),
            ),
          ),
          driver.isPresent ? Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Column(
                children: [
                  Text(
                  "Pilota",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
                  ),
                  Text(
                  "Altezza ${driver.value.altezza} cm",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),
                  ),
                  Text(
                  "Peso ${driver.value.peso} kg",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),
                  ),
                ]
              ),
            ),
          )
          : Container(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.transparent; // Remove the overlay color
                        },
                  ),
                ),
                onPressed: () {},
                child: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
              ),
              Text(
                  "${member.email}"
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.transparent; // Remove the overlay color
                        },
                  ),
                ),
                onPressed: () {},
                child: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
              Text(
                  "${member.telefono}"
              ),
            ],
          ),
        ],
      ),
    );
  }
}


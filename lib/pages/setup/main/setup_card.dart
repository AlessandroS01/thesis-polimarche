import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';
import 'package:polimarche/model/Balance.dart';
import 'package:polimarche/services/setup_service.dart';
import '../../../model/Damper.dart';
import '../../../model/session_model.dart';
import '../../../model/Setup.dart';
import '../../../model/Spring.dart';
import '../../../model/Wheel.dart';

class CardSetup extends StatelessWidget {
  final Setup setup;
  final SetupService setupService;

  CardSetup({super.key, required this.setup, required this.setupService});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade300;

    final List<Wheel> wheels = [
      setup.wheelAntSx,
      setup.wheelAntDx,
      setup.wheelPostSx,
      setup.wheelPostDx
    ];

    final List<Balance> balances = [
      setup.balanceAnt,
      setup.balancePost,
    ];

    final List<Spring> springs = [
      setup.springAnt,
      setup.springPost
    ];

    final List<Damper> dampers = [
      setup.damperAnt,
      setup.damperPost
    ];



    return Expanded(
      flex: 6,
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(8, 8),
                  blurRadius: 15,
                  color: Colors.grey.shade500),
              BoxShadow(
                  offset: -Offset(8, 8), blurRadius: 15, color: Colors.white),
            ]),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll
                .disallowIndicator(); // Disable the overscroll glow effect
            return false;
          },
          child: ListView(scrollDirection: Axis.vertical, children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  "ID: ${setup.id}",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),

            // WHEEL
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: Text(
                  "Gomme",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.6 // width / height
                    ),
                itemCount:
                    wheels.length, // Change this to the desired number of cells
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${wheels[index].posizione}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Codifica",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${wheels[index].codifica}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Pressione",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${wheels[index].pressione} mbar",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Camber",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${wheels[index].frontale}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Toe",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${wheels[index].superiore}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  );
                },
              ),
            ),

            // BALANCE
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Center(
                child: Text(
                  "Bilanciamento",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.75 // width / height
                    ),
                itemCount: balances
                    .length, // Change this to the desired number of cells
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${balances[index].posizione}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Frenata",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${balances[index].frenata}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Peso",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${balances[index].peso}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // SPRING
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Center(
                child: Text(
                  "Molle",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.75 // width / height
                    ),
                itemCount: springs
                    .length, // Change this to the desired number of cells
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${springs[index].posizione}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Codifica",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${springs[index].codifica}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Altezza",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${springs[index].altezza}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Posizione Arb",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${springs[index].posizioneArb}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Rigidezza Arb",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${springs[index].rigidezzaArb}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // DAMPER
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Center(
                child: Text(
                  "Ammortizzatori",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.75 // width / height
                    ),
                itemCount: dampers
                    .length, // Change this to the desired number of cells
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${dampers[index].posizione}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Lsr",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${dampers[index].lsr}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Lsc",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${dampers[index].lsc}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Hsr",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${dampers[index].hsr}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Hsc",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${dampers[index].hsc}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),


            // ALA
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Center(
                child: Text(
                  "Front wing",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(child: Text("${setup.ala}", style: TextStyle(fontSize: 16),)),

            // NOTE
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Center(
                child: Text(
                  "Note",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(child: Text("${setup.note}", style: TextStyle(fontSize: 16),)),


          ]),
        ),
      ),
    );
  }
}

/*
Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Ant sx"),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Post sx")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Ant dx"),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Post dx")
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
 */

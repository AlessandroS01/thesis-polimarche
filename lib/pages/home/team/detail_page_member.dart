import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:optional/optional.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/pages/home/cards/member_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/Driver.dart';


class DetailMember extends StatefulWidget {
  final Optional<Driver> driver;
  final Member member;
  const DetailMember({super.key, required this.driver, required this.member});

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
  Widget build(BuildContext context) {
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
          physics: ClampingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height, // Set a finite height constraint
            decoration: BoxDecoration(
              color: backgroundColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Listener(
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
                    ),
                ]),
                memberCard,
                !driver.isPresent ? Align(
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
                )
                    : SizedBox(height: 0),

                setDriverPressed ? Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Row(
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
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 100),
                            child: Center(
                              child: Listener(
                              onPointerDown: (_) async {
                                setState(() => isConfirmPressed = true); // Reset the state
                                await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation
                                setState(() => isConfirmPressed = false); // Reset the state,
                              },
                                child: AnimatedContainer(
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
                        )
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
}


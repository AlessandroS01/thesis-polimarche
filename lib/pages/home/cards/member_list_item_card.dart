import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:optional/optional_internal.dart';
import 'package:polimarche/pages/home/team/detail_page_member.dart';

import '../../../model/Driver.dart';
import '../../../model/Member.dart';

class CardMemberListItem extends StatefulWidget {
  final Member member;
  final Optional<Driver> driver;
  const CardMemberListItem({Key? key, required this.member, required this.driver}) : super(key: key);

  @override
  State<CardMemberListItem> createState() => _CardMemberListItemState();
}

class _CardMemberListItemState extends State<CardMemberListItem> {
  bool isVisualizzaPressed = false;

  @override
  Widget build(BuildContext context) {

    final backgroundColor = Colors.grey.shade300;
    Offset distance = Offset(5, 5);
    double blur = 10;

    final member = widget.member;
    final driver = widget.driver;


    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(12),
        ),
        color: backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(5, 5),
            blurRadius: 15,
            inset: false
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 10,
            inset: false
          ),
        ],
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${member.nome} ${member.cognome}",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Matricola",
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                          Text(
                            "${member.matricola}"
                          )
                        ],
                      ),
                      _visualizeMemberButton(context, driver, member, backgroundColor, distance, blur)
                    ]
                  ),
                ),
              ),
            ]
          )
      ),
    );
  }

  Listener _visualizeMemberButton(BuildContext context, Optional<Driver> driver, Member member, Color backgroundColor, Offset distance, double blur) {
    return Listener(
                      onPointerDown: (_) async {
                        setState(() => isVisualizzaPressed = true); // Reset the state
                        await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation

                        // PASS THE DRIVER TO THE NEXT WIDGET
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMember(
                                  driver: driver,
                                  member: member,
                                )
                            )
                        );
                        setState(() => isVisualizzaPressed = false); // Reset the state,
                      },
                      child: AnimatedContainer(
                            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                            duration: Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isVisualizzaPressed ? [
                                BoxShadow(
                                  offset: distance,
                                  blurRadius: blur,
                                  color: Colors.grey.shade500,
                                  inset: true
                                ),
                                BoxShadow(
                                  offset: -distance,
                                  blurRadius: blur,
                                  color: Colors.white,
                                  inset: true
                                ),
                              ] : []
                            ),
                        child: Row(
                            children: [
                              Text(
                                  "Visualizza",
                                  style: TextStyle(
                                    color: Colors.black
                                  ),
                              ),
                              Icon(
                                  Icons.person_2,
                                  color: Colors.black,
                              )
                            ]
                        ),
                      ),
                    );
  }
}




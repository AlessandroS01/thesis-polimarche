
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../../model/Member.dart';

class CardMember extends StatefulWidget {
  final Member member;
  const CardMember({Key? key, required this.member}) : super(key: key);

  @override
  State<CardMember> createState() => _CardMemberState();
}

class _CardMemberState extends State<CardMember> {

  bool isVisualizzaPressed = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade300;

    Offset distance = isVisualizzaPressed ? Offset(5, 5) : Offset(8, 8);
    double blur = 5;
    final member = widget.member;


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
            offset: Offset(10, 10),
            blurRadius: 10,
            inset: true
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 10,
            inset: true
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
                      Listener(
                        onPointerDown: (_) async {
                        await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation
                          setState(() => isVisualizzaPressed = true); // Reset the state
                        },
                        child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: isVisualizzaPressed ? [] : [
                                  BoxShadow(
                                    offset: distance,
                                    blurRadius: blur,
                                    color: Colors.grey.shade500,
                                    inset: isVisualizzaPressed
                                  ),
                                  BoxShadow(
                                    offset: -distance,
                                    blurRadius: blur,
                                    color: Colors.white,
                                    inset: isVisualizzaPressed
                                  ),
                                ]
                              ),
                          child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) { {
                                    return Colors.transparent;
                                  }},
                                ),
                              ),
                              onPressed: () { },
                              child: Container(
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
                              )
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ]
          )
      ),
    );
  }
}




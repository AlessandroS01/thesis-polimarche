import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/pages/home/team/detail_page_member.dart';

import '../../../inherited_widgets/authorization_provider.dart';
import '../../../model/driver_model.dart';
import '../../../model/member_model.dart';

class CardMemberListItem extends StatefulWidget {
  final Member member;
  final Driver? driver;

  CardMemberListItem(
      {required this.member,
      required this.driver,});

  @override
  State<CardMemberListItem> createState() => _CardMemberListItemState();
}

class _CardMemberListItemState extends State<CardMemberListItem> {
  final backgroundColor = Colors.grey.shade300;
  bool isVisualizzaPressed = false;
  late final member;
  late final Driver? driver;

  Offset distance = Offset(5, 5);
  double blur = 10;

  @override
  void initState() {
    super.initState();

    member = widget.member;
    driver = widget.driver;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 0, 50, 25),
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
              inset: false),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 10,
              inset: false),
        ],
      ),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            member is Member
                ? Text(
                    "${member.nome} ${member.cognome}",
                    style: TextStyle(fontSize: 16),
                  )
                : Text(
                    "${member.matricola.nome} ${member.matricola.cognome}",
                    style: TextStyle(fontSize: 16),
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
                            style: TextStyle(fontSize: 15),
                          ),
                          member is Member
                              ? Text("${member.matricola}")
                              : Text("${member.matricola.matricola}")
                        ],
                      ),
                      _visualizeMemberButton()
                    ]),
              ),
            ),
          ])),
    );
  }

  Listener _visualizeMemberButton() {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isVisualizzaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation
        final loggedMember = AuthorizationProvider.of(context)!.loggedMember;

        // PASS THE DRIVER TO THE NEXT WIDGET
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          if (driver == null) {
            return DetailMember(
              member: member,
              loggedMember: loggedMember,
              driver: null,
            );
          } else {
            return DetailMember(
              member: member,
              loggedMember: loggedMember,
              driver: driver,
            );
          }
        }));
        setState(() => isVisualizzaPressed = false); // Reset the state,
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isVisualizzaPressed
                ? [
                    BoxShadow(
                        offset: distance,
                        blurRadius: blur,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distance,
                        blurRadius: blur,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(children: [
          Text(
            "Visualizza",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.person_2,
            color: Colors.black,
          )
        ]),
      ),
    );
  }
}

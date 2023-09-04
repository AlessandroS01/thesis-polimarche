import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/problem/manage/manage_problem_page.dart';

import '../../../model/problem_model.dart';

class CardProblemListItem extends StatefulWidget {
  final Problem problem;
  final Member loggedMember;

  const CardProblemListItem({
    Key? key,
    required this.problem,
    required this.loggedMember,
  }) : super(key: key);

  @override
  State<CardProblemListItem> createState() => _CardProblemListItemState();
}

class _CardProblemListItemState extends State<CardProblemListItem> {
  bool isVisualizzaPressed = false;

  final backgroundColor = Colors.grey.shade300;
  final Offset distance = Offset(5, 5);
  final double blur = 10;

  late Problem problem;
  late Member loggedMember;

  @override
  void initState() {
    super.initState();
    problem = widget.problem;
    loggedMember = widget.loggedMember;
  }

  @override
  void didUpdateWidget(covariant CardProblemListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.problem.id != oldWidget.problem.id) {
      problem = widget.problem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
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
            Text(
              "Id problema: ${problem.id}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Descrizione: ${problem.descrizione}",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            if (loggedMember.ruolo == "Manager" ||
                loggedMember.ruolo == "Caporeparto")
                _manageProblemButton(),
          ])),
    );
  }

  Listener _manageProblemButton() {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isVisualizzaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        // PASS THE SETUP TO THE NEXT WIDGET
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ManageProblemPage(
                    problem: problem,)));


        setState(() => isVisualizzaPressed = false); // Reset the state,
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Gestione",
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.settings_suggest,
                color: Colors.black,
              )
            ]),
      ),
    );
  }
}

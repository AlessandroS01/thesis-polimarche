import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/comment_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/model/Participation.dart';
import 'package:polimarche/model/UsedSetup.dart';

class UsedSetupListItem extends StatefulWidget {
  final UsedSetup usedSetup;
  final VoidCallback updateStateUsedSetupPage;
  final Member loggedMember;

  const UsedSetupListItem(
      {required this.usedSetup,
      required this.updateStateUsedSetupPage,
      required this.loggedMember});

  @override
  State<UsedSetupListItem> createState() => _UsedSetupListItemState();
}

class _UsedSetupListItemState extends State<UsedSetupListItem> {
  late final UsedSetup usedSetup;
  late final VoidCallback updateStateUsedSetupPage;
  late final Member loggedMember;

  final backgroundColor = Colors.grey.shade300;
  bool isVisualizzaPressed = false;

  @override
  void initState() {
    usedSetup = widget.usedSetup;
    updateStateUsedSetupPage = widget.updateStateUsedSetupPage;
    loggedMember = widget.loggedMember;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset distanceVisualizza =
        isVisualizzaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurVisualizza = isVisualizzaPressed ? 5 : 10;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Setup: ${usedSetup.setup.id}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                  child: _visualizzaButton(distanceVisualizza, blurVisualizza))
            ],
          ),
          SizedBox(height: 10),
          if (usedSetup.commento != "")
            Text(
              "Commento: ${usedSetup.commento}",
              style: TextStyle(fontSize: 14),
            ),
        ],
      ),
    );
  }

  Listener _visualizzaButton(Offset distanceVisualizza, double blurVisualizza) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isVisualizzaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        setState(() => isVisualizzaPressed = false); // Reset the state,
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isVisualizzaPressed
                ? [
                    BoxShadow(
                        offset: distanceVisualizza,
                        blurRadius: blurVisualizza,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distanceVisualizza,
                        blurRadius: blurVisualizza,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Visualizza",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.visibility,
            color: Colors.black,
          )
        ]),
      ),
    );
  }
}

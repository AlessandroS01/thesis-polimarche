import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/setup/detail/detail_page_setup.dart';

import '../../../model/setup_model.dart';

class CardSetupListItem extends StatefulWidget {
  final Setup setup;
  final Member loggedMember;

  const CardSetupListItem({
    Key? key,
    required this.setup,
    required this.loggedMember,
  }) : super(key: key);

  @override
  State<CardSetupListItem> createState() => _CardSetupListItemState();
}

class _CardSetupListItemState extends State<CardSetupListItem> {
  bool isVisualizzaPressed = false;

  final backgroundColor = Colors.grey.shade300;
  final Offset distance = Offset(5, 5);
  final double blur = 10;

  late Setup setup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup = widget.setup;
  }

  @override
  void didUpdateWidget(covariant CardSetupListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.setup.id != oldWidget.setup.id) {
      setup = widget.setup;
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
              "Setup id: ${setup.id}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            _visualizeSetupButton(),
          ])),
    );
  }

  Listener _visualizeSetupButton() {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isVisualizzaPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        // PASS THE SETUP TO THE NEXT WIDGET
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailSetup(
                      loggedMember: widget.loggedMember,
                      setup: setup
                    )));

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

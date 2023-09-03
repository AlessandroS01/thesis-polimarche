import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/member_model.dart';

import '../../../model/setup_model.dart';
import '../../../service/setup_service.dart';
import 'modify/modify_setup_page.dart';
import 'setup_card.dart';

class DetailSetup extends StatefulWidget {
  final Setup setup;
  final Member loggedMember;
  final Future<void> Function() updateStateSetupPage;

  const DetailSetup({
    super.key,
    required this.setup,
    required this.loggedMember,
    required this.updateStateSetupPage,
  });

  @override
  State<DetailSetup> createState() => _DetailSetupState();
}

class _DetailSetupState extends State<DetailSetup> {
  final backgroundColor = Colors.grey.shade300;
  late final Member loggedMember;
  late Setup setup;
  late final SetupService _setupService;

  bool isModifyButtonPressed = false;

  Future<void> _refreshState() async {
    // update the card
    Setup newSetup = await _setupService.getSetupById(setup.id);

    setState(() {
      setup = newSetup;
    });

    // update the main page
    await widget.updateStateSetupPage();
  }

  @override
  void initState() {
    super.initState();
    _setupService = SetupService();
    loggedMember = widget.loggedMember;
    setup = widget.setup;
  }

  @override
  Widget build(BuildContext context) {
    Offset distanceModify =
        isModifyButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurModify = isModifyButtonPressed ? 5.0 : 30.0;

    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set a finite height constraint
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SETUP CARD
            CardSetup(setup: setup),

            loggedMember.ruolo == "Manager" ||
                    loggedMember.ruolo == "Caporeparto"
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _modifyButton(distanceModify, blurModify),
                      ],
                    ),
                  )
                : Expanded(child: Container())
          ],
        ),
      ),
    );
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Dettagli setup",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength:
          Toast.LENGTH_SHORT, // Duration for which the toast will be displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
      backgroundColor: Colors.grey[600], // Background color of the toast
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }

  Listener _modifyButton(
    Offset distanceComment,
    double blurComment,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isModifyButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ModifySetupPage(
              setup: setup,
              updateStateSetupPage: _refreshState,
            ),
          ),
        );

        setState(() => isModifyButtonPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isModifyButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceComment,
                        blurRadius: blurComment,
                        inset: isModifyButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceComment,
                        blurRadius: blurComment,
                        inset: isModifyButtonPressed),
                  ]
                : []),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Modifica setup"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }
}

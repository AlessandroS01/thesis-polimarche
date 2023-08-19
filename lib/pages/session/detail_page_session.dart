import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optional/optional.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/pages/home/team/member_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polimarche/pages/session/session_card.dart';
import 'package:polimarche/services/session_service.dart';
import 'package:polimarche/services/team_service.dart';

import '../../../inherited_widgets/authorization_provider.dart';
import '../../../model/Driver.dart';


class DetailSession extends StatefulWidget {
  final Session session;
  final Member loggedMember;
  final VoidCallback updateState;
  final SessionService sessionService;

  const DetailSession({
    super.key,
    required this.session,
    required this.loggedMember,
    required this.updateState,
    required this.sessionService,
  });

  @override
  State<DetailSession> createState() => _DetailSessionState();
}

class _DetailSessionState extends State<DetailSession> {

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool isBackButtonPressed = false;

  bool setDriverPressed = false;
  bool isConfirmPressed = false;


  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loggedMember = widget.loggedMember;
    final session = widget.session;


    VoidCallback updateState = widget.updateState;


    final backgroundColor = Colors.grey.shade300;
    final Offset distance = Offset(5, 5);
    final double blur = 20;

    Offset distanceDriver = Offset(5, 5);
    double blurDriver = 10;

    CardSession cardSession = CardSession(session: session);

    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set a finite height constraint
          decoration: BoxDecoration(
            color: backgroundColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // BACK BUTTON
              //_backButton(context, backgroundColor, distance, blur),

              // SESSION CARD
              cardSession,


              loggedMember.ruolo == "Manager"
                  ? Expanded(child: Container())
                  : loggedMember.ruolo == "Caporeparto"
                    ? Expanded(child: Container())
                    : Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      title: Text(
        "Dettagli sessione",
        style: TextStyle(
          color: Colors.black
        ),
      ),
      centerTitle: true,
    );
  }



  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
      backgroundColor: Colors.grey[600], // Background color of the toast
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }


}


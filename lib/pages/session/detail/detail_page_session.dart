import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/pages/session/detail/comments/comments_page.dart';
import 'package:polimarche/pages/session/detail/modify/modify_session_page.dart';
import 'package:polimarche/pages/session/detail/participation/participation_page.dart';
import 'package:polimarche/pages/session/detail/session_card.dart';
import 'package:polimarche/services/session_service.dart';

class DetailSession extends StatefulWidget {
  final Session session;
  final Member loggedMember;
  final SessionService sessionService;

  const DetailSession({
    super.key,
    required this.session,
    required this.loggedMember,
    required this.sessionService,
  });

  @override
  State<DetailSession> createState() => _DetailSessionState();
}

class _DetailSessionState extends State<DetailSession> {
  late final Member loggedMember;
  late final Session session;
  late final SessionService sessionService;

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  bool isCommentButtonPressed = false;
  bool isModifyButtonPressed = false;
  bool isParticipationButtonPressed = false;
  bool isBreakagesButtonPressed = false;
  bool isSetupButtonPressed = false;

  void updateDetailSessionState() {
    setState(() {
      return;
    });
  }

  @override
  void initState() {
    loggedMember = widget.loggedMember;
    session = widget.session;
    sessionService = widget.sessionService;

    super.initState();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset distanceComment =
        isCommentButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurComment = isCommentButtonPressed ? 5.0 : 30.0;

    Offset distanceModify =
        isModifyButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurModify = isModifyButtonPressed ? 5.0 : 30.0;

    Offset distanceBreakages =
        isBreakagesButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurBreakages = isBreakagesButtonPressed ? 5.0 : 30.0;

    Offset distanceSetup = isSetupButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurSetup = isSetupButtonPressed ? 5.0 : 30.0;

    Offset distanceParticipation =
        isParticipationButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurParticipation = isParticipationButtonPressed ? 5.0 : 30.0;

    final backgroundColor = Colors.grey.shade300;

    CardSession cardSession =
        CardSession(session: session, sessionService: sessionService);

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
            // SESSION CARD
            cardSession,

            loggedMember.ruolo == "Manager" ||
                    loggedMember.ruolo == "Caporeparto"
                ? Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(40),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: _commentsButton(
                                  loggedMember,
                                  backgroundColor,
                                  distanceComment,
                                  blurComment,
                                  sessionService,
                                  session),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _modifyButton(backgroundColor, distanceModify,
                                    blurModify, sessionService),
                                _brekageButton(
                                    backgroundColor,
                                    distanceBreakages,
                                    blurBreakages,
                                    sessionService),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _setupButton(backgroundColor, distanceSetup,
                                    blurSetup, sessionService),
                                _participationButton(
                                    backgroundColor,
                                    distanceParticipation,
                                    blurParticipation,
                                    sessionService),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
                : Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(40),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _commentsButton(
                                    loggedMember,
                                    backgroundColor,
                                    distanceComment,
                                    blurComment,
                                    sessionService,
                                    session),
                                _brekageButton(
                                    backgroundColor,
                                    distanceBreakages,
                                    blurBreakages,
                                    sessionService),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _setupButton(backgroundColor, distanceSetup,
                                    blurSetup, sessionService),
                                _participationButton(
                                    backgroundColor,
                                    distanceParticipation,
                                    blurParticipation,
                                    sessionService),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
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
        "Dettagli sessione",
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

  Listener _commentsButton(
      Member loggedMember,
      Color backgroundColor,
      Offset distanceComment,
      double blurComment,
      SessionService sessionService,
      Session session) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isCommentButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CommentSessionPage(
                sessionService: sessionService,
                session: session,
                loggedMember: loggedMember),
          ),
        );

        setState(() => isCommentButtonPressed = false);
      },
      child: AnimatedContainer(
        width: 130,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isCommentButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceComment,
                        blurRadius: blurComment,
                        inset: isCommentButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceComment,
                        blurRadius: blurComment,
                        inset: isCommentButtonPressed),
                  ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Commenti")],
        ),
      ),
    );
  }

  Listener _modifyButton(
    Color backgroundColor,
    Offset distanceComment,
    double blurComment,
    SessionService sessionService,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isModifyButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ModifySessionPage(
                session: session,
                sessionService: sessionService,
                updateState: updateDetailSessionState),
          ),
        );

        setState(() => isModifyButtonPressed = false);
      },
      child: AnimatedContainer(
        width: 130,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Modifica"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Listener _brekageButton(
    Color backgroundColor,
    Offset distanceComment,
    double blurComment,
    SessionService sessionService,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isBreakagesButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        /*
                      Navigator.pushNamed(
                          context,
                          '/session',
                          arguments: loggedMember
                      );

                       */
        setState(() => isBreakagesButtonPressed = false);
      },
      child: AnimatedContainer(
        width: 130,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isBreakagesButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceComment,
                        blurRadius: blurComment,
                        inset: isBreakagesButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceComment,
                        blurRadius: blurComment,
                        inset: isBreakagesButtonPressed),
                  ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Rotture"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Listener _setupButton(
    Color backgroundColor,
    Offset distanceComment,
    double blurComment,
    SessionService sessionService,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isSetupButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        /*
                      Navigator.pushNamed(
                          context,
                          '/session',
                          arguments: loggedMember
                      );

                       */
        setState(() => isSetupButtonPressed = false);
      },
      child: AnimatedContainer(
        width: 130,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isSetupButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceComment,
                        blurRadius: blurComment,
                        inset: isSetupButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceComment,
                        blurRadius: blurComment,
                        inset: isSetupButtonPressed),
                  ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Setup"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Listener _participationButton(
    Color backgroundColor,
    Offset distanceComment,
    double blurComment,
    SessionService sessionService,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isParticipationButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ParticipationSessionPage(
                  sessionId: session.id,
                  sessionService: sessionService,
                  loggedMember: loggedMember),
            ));

        setState(() => isParticipationButtonPressed = false);
      },
      child: AnimatedContainer(
        width: 130,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isParticipationButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceComment,
                        blurRadius: blurComment,
                        inset: isParticipationButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceComment,
                        blurRadius: blurComment,
                        inset: isParticipationButtonPressed),
                  ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Partecipazioni"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }
}

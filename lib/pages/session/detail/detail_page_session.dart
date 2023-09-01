import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/model/session_model.dart';
import 'package:polimarche/pages/session/detail/breakages/breakage_page.dart';
import 'package:polimarche/pages/session/detail/comments/comments_page.dart';
import 'package:polimarche/pages/session/detail/modify/modify_session_page.dart';
import 'package:polimarche/pages/session/detail/participation/participation_page.dart';
import 'package:polimarche/pages/session/detail/session_card.dart';
import 'package:polimarche/pages/session/detail/setups_used/used_setup_page.dart';
import 'package:polimarche/service/session_service.dart';

class DetailSession extends StatefulWidget {
  final Session session;
  final Member loggedMember;
  final Future<void> Function() updateSessionPage;

  const DetailSession({
    super.key,
    required this.session,
    required this.loggedMember,
    required this.updateSessionPage,
  });

  @override
  State<DetailSession> createState() => _DetailSessionState();
}

class _DetailSessionState extends State<DetailSession> {
  final backgroundColor = Colors.grey.shade300;
  late final Member loggedMember;
  late Session session;

  final SessionService _sessionService = SessionService();

  bool isCommentButtonPressed = false;
  bool isModifyButtonPressed = false;
  bool isParticipationButtonPressed = false;
  bool isBreakagesButtonPressed = false;
  bool isSetupButtonPressed = false;

  Future<void> _refreshState() async {
    // update the card
    Session newSession = await _sessionService.getSessionById(session.uid);

    setState(() {
      session = newSession;
    });

    // update the main page
    await widget.updateSessionPage();
  }

  @override
  void initState() {
    super.initState();

    loggedMember = widget.loggedMember;
    session = widget.session;
  }

  @override
  void dispose() {
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
            CardSession(session: session),

            loggedMember.ruolo == "Manager" ||
                    loggedMember.ruolo == "Caporeparto"
                ? Expanded(
                    flex: 2,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                  flex: 3,
                                  child: _commentsButton(
                                      distanceComment, blurComment),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child:
                                      _modifyButton(distanceModify, blurModify),
                                ),
                                Expanded(
                                  child: _brekageButton(
                                      distanceBreakages, blurBreakages),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: _setupButton(distanceSetup, blurSetup),
                                ),
                                Expanded(
                                  child: _participationButton(
                                      distanceParticipation, blurParticipation),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
                : Expanded(
                    flex: 2,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: _commentsButton(
                                      distanceComment, blurComment),
                                ),
                                Expanded(
                                  child: _brekageButton(
                                      distanceBreakages, blurBreakages),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: _setupButton(distanceSetup, blurSetup),
                                ),
                                Expanded(
                                  child: _participationButton(
                                      distanceParticipation, blurParticipation),
                                ),
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

  Listener _commentsButton(Offset distanceComment, double blurComment) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isCommentButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CommentSessionPage(
                session: session, loggedMember: loggedMember),
          ),
        );

        setState(() => isCommentButtonPressed = false);
      },
      child: AnimatedContainer(
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
          children: [Text("Commenti sessione")],
        ),
      ),
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
            builder: (BuildContext context) => ModifySessionPage(
                session: session, updateState: _refreshState),
          ),
        );

        setState(() => isModifyButtonPressed = false);
      },
      child: AnimatedContainer(
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
            Text("Modifica sessione"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Listener _brekageButton(
    Offset distanceComment,
    double blurComment,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isBreakagesButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BreakagesSessionPage(
                sessionId: session.uid!, loggedMember: loggedMember),
          ),
        );
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
            Text("Rotture verificate"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Listener _setupButton(Offset distanceComment, double blurComment) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isSetupButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => UsedSetupDuringSessionPage(
              sessionId: session.uid!,
              loggedMember: loggedMember,
            ),
          ),
        );
        setState(() => isSetupButtonPressed = false);
      },
      child: AnimatedContainer(
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
            Text("Setup utilizzati"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Listener _participationButton(Offset distanceComment, double blurComment) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isParticipationButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ParticipationSessionPage(
                  sessionId: session.uid!, loggedMember: loggedMember),
            ));

        setState(() => isParticipationButtonPressed = false);
      },
      child: AnimatedContainer(
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
            Text("Partecipazioni piloti"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }
}

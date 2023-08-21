import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:polimarche/pages/home/home_page.dart';
import 'package:polimarche/pages/session/plan/plan_session_page.dart';
import 'package:polimarche/pages/session/session_page.dart';

import '../../../inherited_widgets/session_state.dart';
import '../../../model/Member.dart';
import '../../../services/session_service.dart';

class HiddenDrawerSession extends StatefulWidget {
  final Member loggedMember;

  const HiddenDrawerSession({super.key, required this.loggedMember});

  @override
  State<HiddenDrawerSession> createState() => _HiddenDrawerSessionState();
}

class _HiddenDrawerSessionState extends State<HiddenDrawerSession> {
  final backgroundColorMenu = Colors.grey.shade700;
  final backgroundColor = Colors.grey.shade300;
  late final SessionService sessionService;

  final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionService = SessionService();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Sessioni',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          SessionPage(
            loggedMember: widget.loggedMember,
            sessionService: sessionService,
          )),
      if (widget.loggedMember.ruolo == "Manager" ||
          widget.loggedMember.ruolo == "Caporeparto")
        ScreenHiddenDrawer(
            ItemHiddenMenu(
                name: 'Pianificazione sessione',
                baseStyle: textStyle,
                selectedStyle: textStyle,
                colorLineSelected: Colors.white),
            PlanSessionPage(
              sessionService: sessionService,

            )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SessionInheritedState(
      sessionService: sessionService,
      child: HiddenDrawerMenu(
        actionsAppBar: [
          Listener(
            onPointerDown: (_) => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          )
        ],
        leadingAppBar: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        slidePercent: 70,
        isTitleCentered: true,
        styleAutoTittleName: TextStyle(color: Colors.black),
        backgroundColorAppBar: Colors.grey.shade300,
        elevationAppBar: 0,
        screens: _pages,
        backgroundColorMenu: backgroundColorMenu,
        initPositionSelected: 0,
      ),
    );
  }
}

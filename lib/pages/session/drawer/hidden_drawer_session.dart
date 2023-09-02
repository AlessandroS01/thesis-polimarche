import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:polimarche/pages/session/main/session_page.dart';
import 'package:polimarche/pages/session/plan/plan_session_page.dart';

import '../../../model/member_model.dart';
import '../tracks/track_page.dart';

class HiddenDrawerSession extends StatefulWidget {
  final Member loggedMember;

  const HiddenDrawerSession({super.key, required this.loggedMember});

  @override
  State<HiddenDrawerSession> createState() => _HiddenDrawerSessionState();
}

class _HiddenDrawerSessionState extends State<HiddenDrawerSession> {
  final backgroundColorMenu = Colors.grey.shade700;
  final backgroundColor = Colors.grey.shade300;

  final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Sessioni',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          SessionPage(
            loggedMember: widget.loggedMember
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
            )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Tracciati',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          TrackPage(
            loggedMember: widget.loggedMember,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
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
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.5),
          offset: Offset(-5, -5),
          blurRadius: 40
        )
      ],
    );
  }
}

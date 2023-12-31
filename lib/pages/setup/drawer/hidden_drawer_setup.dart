import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:polimarche/pages/setup/main/setup_page.dart';

import '../../../model/member_model.dart';
import '../plan/create_step_pages/create_setup_page.dart';

class HiddenDrawerSetup extends StatefulWidget {
  final Member loggedMember;

  const HiddenDrawerSetup({super.key, required this.loggedMember});

  @override
  State<HiddenDrawerSetup> createState() => _HiddenDrawerSetupState();
}

class _HiddenDrawerSetupState extends State<HiddenDrawerSetup> {
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
              name: 'Setup',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          SetupPage(
            loggedMember: widget.loggedMember
          )),
      if (widget.loggedMember.ruolo == "Manager" ||
          widget.loggedMember.ruolo == "Caporeparto")
        ScreenHiddenDrawer(
            ItemHiddenMenu(
                name: 'Creazione setup',
                baseStyle: textStyle,
                selectedStyle: textStyle,
                colorLineSelected: Colors.white),
            PlanSetupPage(
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

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polimarche/inherited_widgets/authorization_provider.dart';
import 'package:polimarche/pages/home/team/team_page.dart';

import '../../auth/auth.dart';
import '../../model/member_model.dart';
import 'agenda/agenda_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final Member loggedMember;

  MainPage({super.key, required this.loggedMember});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late Member loggedMember;

  late List pages;
  late List<String> pagesName;

  @override
  initState() {
    super.initState();

    loggedMember = widget.loggedMember;

      pagesName = [
        "Benvenuto",
        "Team",
        "Agenda"
      ];

      pages = [
        HomePage(),
        TeamPage(),
        AgendaPage(loggedMember: widget.loggedMember)
      ];
  }

  @override
  Widget build(BuildContext context) {
    return AuthorizationProvider(
      loggedMember: widget.loggedMember,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: _appBar(),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  Container _bottomNavBar() {
    return Container(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GNav(
          textStyle: const TextStyle(color: Colors.black),
          backgroundColor: Colors.grey.shade300,
          color: Colors.black,
          activeColor: Colors.black,
          tabBackgroundColor: Colors.white,
          padding: const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.groups_2,
              text: "Team",
            ),
            GButton(
              icon: Icons.calendar_today_outlined,
              text: "Agenda",
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
              pagesName[_currentIndex],
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () {
              _showLogoutDialog();
            },
            icon: Icon(Icons.logout, color: Colors.black,)
        )
      ],
      backgroundColor: Colors.grey.shade300,
      elevation: 0,
    );
  }

  Future<dynamic> _showLogoutDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: const Text("LOGOUT")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add some spacing between the text field and radio buttons

                  Center(
                    child: Text(
                      "Sei sicuro di voler uscire?"
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "CANCELLA",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "LOGOUT",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: _logoutPressed,
                ),
              ],
            ),
          );
        });
  }

  Future<void> _logoutPressed() async {
    await Auth().signOut();
    Navigator.popAndPushNamed(context, '/login');
  }
}

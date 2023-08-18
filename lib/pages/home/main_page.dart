import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polimarche/inherited_widgets/authorization_provider.dart';
import 'package:polimarche/pages/home/team/team_page.dart';

import '../../model/Member.dart';
import 'agenda/agenda_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final Member member;

  MainPage({
    super.key,
    required this.member
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  int _currentIndex = 0;

  List pages = [
    HomePage(),
    TeamPage(),
    AgendaPage()
  ];

  @override
  Widget build(BuildContext context) {
    return AuthorizationProvider(
      loggedMember: widget.member,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300
          ),
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GNav(
              textStyle: const TextStyle(
                color: Colors.black
              ),
              backgroundColor: Colors.grey.shade300,
              color: Colors.black,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              gap: 8,

              onTabChange: (index){
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: const [
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
        ),
      ),
    );
  }
}

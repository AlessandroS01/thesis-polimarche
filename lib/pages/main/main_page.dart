import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polimarche/pages/main/agenda_item_page.dart';
import 'package:polimarche/pages/main/home_item_page.dart';
import 'package:polimarche/pages/main/team_item_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300
          /*
          image: DecorationImage(
            image: AssetImage(
              'assets/backgrounds/login.jpg'
            ),
            fit: BoxFit.fill
          )

           */
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
    );
  }
}

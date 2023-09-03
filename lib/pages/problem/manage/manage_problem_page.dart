import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polimarche/pages/problem/manage/occurring/occurring_problem_page.dart';
import 'package:polimarche/pages/problem/manage/solved/solved_problem_page.dart';

import '../../../model/problem_model.dart';

class ManageProblemPage extends StatefulWidget {
  final Problem problem;

  ManageProblemPage({
    super.key,
    required this.problem,
  });

  @override
  State<ManageProblemPage> createState() => _ManageProblemPageState();
}

class _ManageProblemPageState extends State<ManageProblemPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late List pages;

  @override
  initState() {
    super.initState();
    pages = [
      OccurringProblemPage(problemId: widget.problem.id),
      SolvedProblemPage(problemId: widget.problem.id),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll
                      .disallowIndicator(); // Disable the overscroll glow effect
                  return false;
                },
                child: Center(
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          "Id problema: ${widget.problem.id}",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Descrizione: ${widget.problem.descrizione}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: pages[_currentIndex],
          )
        ],
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Container _bottomNavBar() {
    return Container(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
          tabs: const [
            GButton(
              icon: Icons.warning_amber,
              text: "Presente",
            ),
            GButton(
              icon: Icons.check_circle_outline,
              text: "Risolto",
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: _currentIndex == 0
          ? Text(
              "Problema riscontrato",
              style: TextStyle(color: Colors.black),
            )
          : Text(
              "Problema risolto",
              style: TextStyle(color: Colors.black),
            ),
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
      backgroundColor: Colors.grey.shade300,
      elevation: 0,
    );
  }
}

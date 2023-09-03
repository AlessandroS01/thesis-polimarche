import 'package:flutter/material.dart';
import 'package:polimarche/pages/home/main_page.dart';
import 'package:polimarche/pages/problem/main/problem_page.dart';
import 'package:polimarche/pages/session/drawer/hidden_drawer_session.dart';
import 'package:polimarche/pages/setup/drawer/hidden_drawer_setup.dart';

import '../model/member_model.dart';
import 'loading.dart';
import 'login/login.dart';

class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "aleo",
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Loading(),
        '/login': (context) => LoginScreen(),
        '/home': (context) {
          final Member loggedMember =
              ModalRoute.of(context)?.settings.arguments as Member;
          return MainPage(loggedMember: loggedMember);
        },
        '/session': (context) {
          final Member loggedMember =
              ModalRoute.of(context)?.settings.arguments as Member;
          return HiddenDrawerSession(loggedMember: loggedMember);
        },
        '/setup': (context) {
          final Member loggedMember =
              ModalRoute.of(context)?.settings.arguments as Member;
          return HiddenDrawerSetup(loggedMember: loggedMember);
        },
        '/problem': (context) {
          final Member loggedMember =
              ModalRoute.of(context)?.settings.arguments as Member;
          return ProblemPage(loggedMember: loggedMember);
        },
      },
    );
  }
}
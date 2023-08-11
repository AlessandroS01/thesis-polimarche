import 'package:flutter/material.dart';
import 'package:polimarche/pages/main/main_page.dart';
import 'package:polimarche/pages/loading.dart';
import 'package:polimarche/pages/login.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: "aleo",
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/login': (context) => const Login(),
      '/home': (context) => const MainPage(),
    },
  ));
}

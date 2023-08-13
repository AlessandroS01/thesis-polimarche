import 'package:flutter/material.dart';
import 'package:polimarche/pages/home/main_page.dart';
import 'package:polimarche/pages/loading.dart';
import 'package:polimarche/pages/login.dart';

void main() {
  runApp(MyApp()); // Replace with the name of your app's root widget
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "aleo",
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'aleo'),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Loading(),
        '/login': (context) => const Login(),
        '/home': (context) => const MainPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:polimarche/pages/loading.dart';
import 'package:polimarche/pages/login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/login': (context) => const Login(),
    },
  ));
}

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:polimarche/pages/session/detail/session_card.dart';

import '../../model/session_model.dart';

class VisualizeSession extends StatelessWidget {
  VisualizeSession({super.key, required this.session});

  final Session session;

  final backgroundColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(backgroundColor),
      body: Container(
        margin: EdgeInsets.only(bottom: 100),
        height: MediaQuery.of(context)
            .size
            .height, // Set a finite height constraint
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SETUP CARD
            CardSession(session: session),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Visualizzazione sessione",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

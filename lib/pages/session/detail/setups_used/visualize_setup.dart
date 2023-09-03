import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:polimarche/model/setup_model.dart';

import '../../../setup/detail/setup_card.dart';

class VisualizeSetup extends StatelessWidget {
  VisualizeSetup({super.key, required this.setup});

  final Setup setup;

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
            CardSetup(setup: setup),
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
        "Visualizzazione setup",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

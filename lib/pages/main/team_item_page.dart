import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Team",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:optional/optional_internal.dart';

import '../../../model/Driver.dart';
import '../../../model/Member.dart';
import '../../model/Session.dart';

class CardSession extends StatelessWidget {
  final Session session;

  CardSession({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade300;
    
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.fromLTRB(40, 30, 40, 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(8, 8),
                  blurRadius: 15,
                  color: Colors.grey.shade500
              ),
              BoxShadow(
                  offset: -Offset(8, 8),
                  blurRadius: 15,
                  color: Colors.white
              ),
            ]
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator(); // Disable the overscroll glow effect
            return false;
          },
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                        margin: EdgeInsets.all(40),
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
                        child: Icon(
                          Icons.person_3,
                          size: 80,
                          color: Colors.black,
                        )
                    ),
                    Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),Center(
                      child: Text(
                        "S${session.data}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}


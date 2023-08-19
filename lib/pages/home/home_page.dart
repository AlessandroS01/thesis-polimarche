import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/pages/session/session_page.dart';

import '../../inherited_widgets/authorization_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool isSessionPressed = false;
  bool isProblemPressed = false;
  bool isSetupPressed = false;
  bool isTelemetryPressed = false;

  @override
  Widget build(BuildContext context) {
    final loggedMember = AuthorizationProvider.of(context)!.loggedMember;

    final backgroundColor = Colors.grey.shade300;

    Offset distanceSession = isSessionPressed ? Offset(5, 5) : Offset(18, 18);
    Offset distanceProblem = isProblemPressed ? Offset(5, 5) : Offset(18, 18);
    Offset distanceSetup = isSetupPressed ? Offset(5, 5) : Offset(18, 18);
    Offset distanceTelemetry = isTelemetryPressed ? Offset(5, 5) : Offset(18, 18);

    double blurSession = isSessionPressed ? 5.0 : 30.0;
    double blurProblem = isProblemPressed ? 5.0 : 30.0;
    double blurSetup = isSetupPressed ? 5.0 : 30.0;
    double blurTelemetry = isTelemetryPressed ? 5.0 : 30.0;

    return AuthorizationProvider(
      loggedMember: loggedMember,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "${loggedMember.nome} ${loggedMember.cognome} ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${loggedMember.ruolo}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                    ),
                  ),
                ]
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _sessionButton(loggedMember, backgroundColor, distanceSession, blurSession),

                      _problemButton(backgroundColor, distanceProblem, blurProblem),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _telemetryButton(backgroundColor, distanceTelemetry, blurTelemetry),

                      _setupButton(backgroundColor, distanceSetup, blurSetup),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Listener _setupButton(Color backgroundColor, Offset distanceSetup, double blurSetup) {
    return Listener(
                    onPointerUp: (_) async {
                      await Future.delayed(const Duration(milliseconds: 150)); // Wait for animation
                        setState(() => isSetupPressed = false); // Reset the state
                    },
                    onPointerDown: (_) => setState(() => isSetupPressed = true),
                    child: AnimatedContainer(
                      width: 130,
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          //
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: distanceSetup,
                            blurRadius: blurSetup,
                            inset: isSetupPressed
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: -distanceSetup,
                            blurRadius: blurSetup,
                            inset: isSetupPressed
                          ),


                        ]
                      ),
                      child: const Center(child: Text("Setup")),
                    ),
                  );
  }

  Listener _telemetryButton(Color backgroundColor, Offset distanceTelemetry, double blurTelemetry) {
    return Listener(
                    onPointerUp: (_) async {
                      await Future.delayed(const Duration(milliseconds: 150)); // Wait for animation
                        setState(() => isTelemetryPressed = false); // Reset the state
                    },
                    onPointerDown: (_) => setState(() => isTelemetryPressed = true),
                    child: AnimatedContainer(
                      width: 130,
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          //
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: distanceTelemetry,
                            blurRadius: blurTelemetry,
                            inset: isTelemetryPressed
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: -distanceTelemetry,
                            blurRadius: blurTelemetry,
                            inset: isTelemetryPressed
                          ),


                        ]
                      ),
                      child: const Center(child: Text("Telemetria")),
                    ),
                  );
  }

  Listener _problemButton(Color backgroundColor, Offset distanceProblem, double blurProblem) {
    return Listener(
                    onPointerUp: (_) async {
                      await Future.delayed(const Duration(milliseconds: 150)); // Wait for animation
                        setState(() => isProblemPressed = false); // Reset the state
                    },
                    onPointerDown: (_) => setState(() => isProblemPressed = true),
                    child: AnimatedContainer(
                      width: 130,
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          //
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: distanceProblem,
                            blurRadius: blurProblem,
                            inset: isProblemPressed
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: -distanceProblem,
                            blurRadius: blurProblem,
                            inset: isProblemPressed
                          ),
                        ]
                      ),
                      child: const Center(child: Text("Problemi")),
                    ),
                  );
  }

  Listener _sessionButton(
      Member loggedMember,
      Color backgroundColor,
      Offset distanceSession,
      double blurSession) {
    return Listener(
                    onPointerDown: (_) async {
                      setState(() => isSessionPressed = true);

                      await Future.delayed(const Duration(milliseconds: 170)); // Wait for animation

                      Navigator.pushNamed(
                          context,
                          '/session',
                          arguments: loggedMember
                      );
                      setState(() => isSessionPressed = false);
                    },
                    child: AnimatedContainer(
                      width: 130,
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          //
                          BoxShadow(
                          color: Colors.grey.shade500,
                          offset: distanceSession,
                          blurRadius: blurSession,
                          inset: isSessionPressed
                          ),
                          BoxShadow(
                          color: Colors.white,
                          offset: -distanceSession,
                          blurRadius: blurSession,
                          inset: isSessionPressed
                          ),
                        ]
                      ),
                        child: const Center(child: Text("Sessioni")),
                    ),
                  );
  }
}




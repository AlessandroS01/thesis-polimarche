import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

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
    final backgroundColor = Colors.grey.shade300;

    Offset distanceSession = isSessionPressed ? Offset(5, 5) : Offset(18, 18);
    Offset distanceProblem = isProblemPressed ? Offset(5, 5) : Offset(18, 18);
    Offset distanceSetup = isSetupPressed ? Offset(5, 5) : Offset(18, 18);
    Offset distanceTelemetry = isTelemetryPressed ? Offset(5, 5) : Offset(18, 18);

    double blurSession = isSessionPressed ? 5.0 : 30.0;
    double blurProblem = isProblemPressed ? 5.0 : 30.0;
    double blurSetup = isSetupPressed ? 5.0 : 30.0;
    double blurTelemetry = isTelemetryPressed ? 5.0 : 30.0;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Benvenuto",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                    ),
                  ),
                  Text(
                    "Nome & Cognome",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                    ),
                  ),
                  Text(
                    "Ruolo",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                    ),
                  ),
                ]
              ),
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
                    Listener(
                      onPointerUp: (_) async {
                        await Future.delayed(const Duration(milliseconds: 150)); // Wait for animation
                          setState(() => isSessionPressed = false); // Reset the state
                      },
                      onPointerDown: (_) => setState(() => isSessionPressed = true),
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
                    ),
                    Listener(
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
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Listener(
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
                    ),
                    Listener(
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
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}




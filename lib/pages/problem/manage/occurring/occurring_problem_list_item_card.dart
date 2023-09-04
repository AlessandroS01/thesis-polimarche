import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/occurring_problem_model.dart';
import 'package:polimarche/service/occurring_problem_service.dart';
import 'package:polimarche/service/solved_problem_service.dart';

import '../../../../model/setup_model.dart';
import '../../../session/detail/setups_used/visualize_setup.dart';

class OccurringProblemListItem extends StatefulWidget {
  final OccurringProblem occurringProblem;
  final Setup setup;
  final Future<void> Function() updateStateOccurringProblemPage;

  const OccurringProblemListItem({
    required this.occurringProblem,
    required this.setup,
    required this.updateStateOccurringProblemPage,
  });

  @override
  State<OccurringProblemListItem> createState() =>
      _OccurringProblemListItemState();
}

class _OccurringProblemListItemState extends State<OccurringProblemListItem> {
  bool isSolvedProblemPressed = false;

  bool isVisualizzaSetupPressed = false;

  late final OccurringProblemService _occurringProblemService;
  late final SolvedProblemService _solvedProblemService;

  late final OccurringProblem occurringProblem;
  late final Future<void> Function() updateStateOccurringProblemPage;
  late final Setup _setup;

  final backgroundColor = Colors.grey.shade300;

  TextEditingController _controllerDescription = TextEditingController();

  Future<void> _removeOccurringProblem() async {
    await _occurringProblemService.removeOccurringProblem(occurringProblem.id);

    await _solvedProblemService.addNewSolvedProblem(_controllerDescription.text,
        occurringProblem.problemId, occurringProblem.setupId);

    updateStateOccurringProblemPage();

    showToast("Il problema risolto è stato salvato");

    Navigator.pop(context);
  }

  @override
  void initState() {
    updateStateOccurringProblemPage = widget.updateStateOccurringProblemPage;
    _setup = widget.setup;
    occurringProblem = widget.occurringProblem;

    _occurringProblemService = OccurringProblemService();
    _solvedProblemService = SolvedProblemService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset distanceVisualizza =
        isVisualizzaSetupPressed ? Offset(5, 5) : Offset(8, 8);
    double blurVisualizza = isVisualizzaSetupPressed ? 5 : 10;

    Offset distanceSolvedProblem =
        isSolvedProblemPressed ? Offset(5, 5) : Offset(8, 8);
    double blurSolvedProblem = isSolvedProblemPressed ? 5 : 10;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(12),
        ),
        color: backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(5, 5),
              blurRadius: 15,
              inset: false),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 10,
              inset: false),
        ],
      ),
      child: Column(
        children: [
          Center(
              child: Text(
            "Descrizione: ${occurringProblem.descrizione}",
            style: TextStyle(fontSize: 16),
          )),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                "Id setup: ${occurringProblem.setupId}",
                style: TextStyle(fontSize: 15),
              ))),
              Expanded(
                  child: Listener(
                onPointerDown: (_) async {
                  setState(
                      () => isVisualizzaSetupPressed = true); // Reset the state
                  await Future.delayed(
                      const Duration(milliseconds: 200)); // Wait for animation

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          VisualizeSetup(setup: _setup),
                    ),
                  );

                  setState(() =>
                      isVisualizzaSetupPressed = false); // Reset the state,
                },
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  duration: Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: isVisualizzaSetupPressed
                          ? [
                              BoxShadow(
                                  offset: distanceVisualizza,
                                  blurRadius: blurVisualizza,
                                  color: Colors.grey.shade500,
                                  inset: true),
                              BoxShadow(
                                  offset: -distanceVisualizza,
                                  blurRadius: blurVisualizza,
                                  color: Colors.grey.shade100,
                                  inset: true),
                            ]
                          : []),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Visualizza",
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.visibility,
                          color: Colors.black,
                        )
                      ]),
                ),
              ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _problemSolvedButton(distanceSolvedProblem, blurSolvedProblem),
        ],
      ),
    );
  }

  Listener _problemSolvedButton(
      Offset distanceSolvedProblem, double blurSolvedProblem) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isSolvedProblemPressed = true); // Reset the state
        await Future.delayed(
            const Duration(milliseconds: 200)); // Wait for animation

        _showProblemSolvedDialog();

        setState(() => isSolvedProblemPressed = false); // Reset the state,
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSolvedProblemPressed
                ? [
                    BoxShadow(
                        offset: distanceSolvedProblem,
                        blurRadius: blurSolvedProblem,
                        color: Colors.grey.shade500,
                        inset: true),
                    BoxShadow(
                        offset: -distanceSolvedProblem,
                        blurRadius: blurSolvedProblem,
                        color: Colors.white,
                        inset: true),
                  ]
                : []),
        child: Center(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Problema risolto",
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.safety_check,
              color: Colors.black,
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> _showProblemSolvedDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: const Text("PROBLEMA RISOLTO")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'aleo',
                        letterSpacing: 1),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: 'Descrizione problema risolto',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _controllerDescription,
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "CANCELLA",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "CONFERMA",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: _removeOccurringProblem,
                )
              ],
            ),
          );
        });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength:
          Toast.LENGTH_SHORT, // Duration for which the toast will be displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
      backgroundColor: Colors.grey[600], // Background color of the toast
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }
}

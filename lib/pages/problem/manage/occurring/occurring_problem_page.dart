import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/driver_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/model/occurring_problem_model.dart';
import 'package:polimarche/model/setup_model.dart';
import 'package:polimarche/model/solved_problem_model.dart';
import 'package:polimarche/pages/problem/manage/occurring/occurring_problem_list_item_card.dart';
import 'package:polimarche/pages/session/detail/participation/participation_list_item_card.dart';
import 'package:polimarche/service/driver_service.dart';
import 'package:polimarche/service/occurring_problem_service.dart';
import 'package:polimarche/service/participation_service.dart';
import 'package:polimarche/service/setup_service.dart';
import 'package:polimarche/service/solved_problem_service.dart';

import '../../../../model/participation_model.dart';
import '../../../session/detail/setups_used/visualize_setup.dart';

class OccurringProblemPage extends StatefulWidget {
  final int problemId;

  const OccurringProblemPage({super.key, required this.problemId});

  @override
  State<OccurringProblemPage> createState() => _OccurringProblemPageState();
}

class _OccurringProblemPageState extends State<OccurringProblemPage> {
  final backgroundColor = Colors.grey.shade300;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;
  bool isVisualizzaSetupPressed = false;

  late final OccurringProblemService _occurringProblemService;
  late final SolvedProblemService _solvedProblemService;
  late final SetupService _setupService;

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  late List<OccurringProblem> _occurringProblemList;
  late List<SolvedProblem> _solvedProblemList;
  late List<Setup> _setupList;

  late List<Setup> _listSetupsNotFacingProblem;
  late int _newSetupIdWithProblem;

  TextEditingController _controllerDescription = TextEditingController();

  Future<void> _getOccurringProblems() async {
    _occurringProblemList = await _occurringProblemService
        .getOccurringProblemsByProblemId(widget.problemId);

    _solvedProblemList = await _solvedProblemService
        .getSolvedProblemsByProblemId(widget.problemId);

    _setupList = await _setupService.getSetups();
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getOccurringProblems(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
    });
  }

  Future<void> _findSetupsNotFacingProblem() async {
    List<int> occurringProblemSetupIds = _occurringProblemList
        .map((occurringProblem) => occurringProblem.setupId)
        .toList();
    List<int> solvedProblemSetupIds = _solvedProblemList
        .map((solvedProblem) => solvedProblem.setupId)
        .toList();

    setState(() {
      _listSetupsNotFacingProblem = List.from(_setupList);

      _listSetupsNotFacingProblem.removeWhere((setup) =>
          occurringProblemSetupIds.contains(setup.id) ||
          solvedProblemSetupIds.contains(setup.id));

      if (_listSetupsNotFacingProblem.length != 0) {
        _newSetupIdWithProblem = _listSetupsNotFacingProblem.first.id;
      }
    });
  }

  Future<void> _addNewOccurringProblem() async {
    await _occurringProblemService.addNewOccurringProblem(
        widget.problemId, _controllerDescription.text, _newSetupIdWithProblem);

    showToast("Il problema riscontrato su un nuovo setup è stato salvato");
    _controllerDescription.clear();

    Navigator.pop(context);

    _refreshState();
  }

  @override
  void initState() {
    super.initState();

    _occurringProblemService = OccurringProblemService();
    _solvedProblemService = SolvedProblemService();
    _setupService = SetupService();

    _dataLoading = _getOccurringProblems();
  }

  @override
  Widget build(BuildContext context) {
    Offset distanceVisualizza =
        isVisualizzaSetupPressed ? Offset(5, 5) : Offset(8, 8);
    double blurVisualizza = isVisualizzaSetupPressed ? 5 : 10;

    return Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          children: [
            Expanded(
                child: RefreshIndicator(
              onRefresh: _refreshState,
              child: Container(
                child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll
                          .disallowIndicator(); // Disable the overscroll glow effect
                      return false;
                    },
                    child: FutureBuilder(
                      future: _dataLoading,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            _isDataLoading) {
                          // Return a loading indicator if still waiting for data
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: _occurringProblemList.length,
                              itemBuilder: (context, index) {
                                final element = _occurringProblemList[index];
                                return OccurringProblemListItem(
                                  occurringProblem: element,
                                  updateStateOccurringProblemPage:
                                      _refreshState,
                                  setup: _setupList.firstWhere(
                                      (setup) => setup.id == element.setupId),
                                );
                              });
                        }
                      },
                    )),
              ),
            )),
            _newOccurringProblemButton(distanceVisualizza, blurVisualizza)
          ],
        ));
  }

  Align _newOccurringProblemButton(
      Offset distanceVisualizza, double blurVisualizza) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Listener(
              onPointerDown: (_) async {
                setState(() => isAddPressed = true); // Reset the state
                await Future.delayed(
                    const Duration(milliseconds: 200)); // Wait for animation
                setState(() => isAddPressed = false); // Reset the state,

                await _findSetupsNotFacingProblem();

                if (_listSetupsNotFacingProblem.isEmpty) {
                  showToast(
                      "Su tutti i setup il problema è stato riscontrato o risolto");
                } else {
                  _addOccurringProblemDialog(
                      distanceVisualizza, blurVisualizza);
                }
              },
              child: AnimatedContainer(
                padding: EdgeInsets.all(10),
                duration: Duration(milliseconds: 150),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: isAddPressed
                        ? []
                        : [
                            BoxShadow(
                                offset: distanceAdd,
                                blurRadius: blurAdd,
                                color: Colors.grey.shade500),
                            BoxShadow(
                                offset: -distanceAdd,
                                blurRadius: blurAdd,
                                color: Colors.white),
                          ]),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 27,
                ),
              ),
            )));
  }

  Future<dynamic> _addOccurringProblemDialog(
      Offset distanceVisualizza, double blurVisualizza) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: const Text("NUOVA PARTECIPAZIONE")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                padding: EdgeInsets.all(10),
                                borderRadius: BorderRadius.circular(10),
                                dropdownColor: backgroundColor,
                                value: _newSetupIdWithProblem.toString(),
                                items: _listSetupsNotFacingProblem
                                    .map<DropdownMenuItem<String>>(
                                        (Setup value) {
                                  return DropdownMenuItem<String>(
                                    value: value.id.toString(),
                                    child: Text(value.id.toString()),
                                  );
                                }).toList(),
                                onChanged: (String? setupId) {
                                  if (setupId != null) {
                                    setState(() {
                                      _newSetupIdWithProblem =
                                          int.parse(setupId);
                                    });
                                  }
                                }),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Listener(
                        onPointerDown: (_) async {
                          setState(() => isVisualizzaSetupPressed =
                              true); // Reset the state
                          await Future.delayed(const Duration(
                              milliseconds: 200)); // Wait for animation

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => VisualizeSetup(
                                  setup: _setupList.firstWhere((setup) =>
                                      setup.id == _newSetupIdWithProblem)),
                            ),
                          );

                          setState(() => isVisualizzaSetupPressed =
                              false); // Reset the state,
                        },
                        child: AnimatedContainer(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          duration: Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isVisualizzaSetupPressed
                                  ? [
                                      BoxShadow(
                                          offset: distanceVisualizza,
                                          blurRadius: blurVisualizza,
                                          color: Colors.grey.shade300,
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
                      height:
                          10), // Add some spacing between the text field and radio buttons

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
                      hintText: 'Descrizione problema riscontrato',
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
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      "CONFERMA",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: _addNewOccurringProblem,
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

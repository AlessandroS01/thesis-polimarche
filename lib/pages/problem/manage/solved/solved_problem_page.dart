import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/driver_model.dart';
import 'package:polimarche/model/member_model.dart';
import 'package:polimarche/pages/problem/manage/solved/solved_problem_list_item_card.dart';
import 'package:polimarche/pages/session/detail/participation/participation_list_item_card.dart';
import 'package:polimarche/service/driver_service.dart';
import 'package:polimarche/service/participation_service.dart';

import '../../../../model/participation_model.dart';
import '../../../../model/setup_model.dart';
import '../../../../model/solved_problem_model.dart';
import '../../../../service/setup_service.dart';
import '../../../../service/solved_problem_service.dart';

class SolvedProblemPage extends StatefulWidget {
  final int problemId;

  const SolvedProblemPage(
      {super.key, required this.problemId});

  @override
  State<SolvedProblemPage> createState() =>
      _SolvedProblemPageState();
}

class _SolvedProblemPageState extends State<SolvedProblemPage> {
  final backgroundColor = Colors.grey.shade300;
  bool isVisualizzaSetupPressed = false;

  late final SolvedProblemService _solvedProblemService;
  late final SetupService _setupService;

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  late List<SolvedProblem> _solvedProblemList;
  late List<Setup> _listSetup;

  Future<void> _getSolvedProblems() async {
    _solvedProblemList = await _solvedProblemService
        .getSolvedProblemsByProblemId(widget.problemId);

    _listSetup = await _setupService.getSetups();
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getSolvedProblems(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _solvedProblemService = SolvedProblemService();
    _setupService = SetupService();
    _dataLoading = _getSolvedProblems();
  }

  @override
  Widget build(BuildContext context) {
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
                              itemCount: _solvedProblemList.length,
                              itemBuilder: (context, index) {
                                final element = _solvedProblemList[index];
                                return SolvedProblemItemList(
                                  solvedProblem: element,
                                  updateStateSolvedProblemPage:
                                      _refreshState,
                                  setup: _listSetup.firstWhere(
                                      (setup) => setup.id == element.setupId),
                                );
                              });
                        }
                      },
                    )),
              ),
            )),
          ],
        ));
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

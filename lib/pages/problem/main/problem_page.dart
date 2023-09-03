import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/pages/problem/main/problem_list_item_card.dart';
import 'package:polimarche/service/problem_service.dart';

import '../../../model/member_model.dart';
import '../../../model/problem_model.dart';

class ProblemPage extends StatefulWidget {
  final Member loggedMember;

  const ProblemPage({super.key, required this.loggedMember});

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  final backgroundColor = Colors.grey.shade300;

  late final Member loggedMember;
  late final ProblemService _problemService;

  final TextEditingController _searchBarController = TextEditingController();

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  late List<Problem> problemList;

  // list displayed inside the listView
  List<dynamic> _filteredProblemList = [];

  Future<void> _getProblems() async {
    problemList = await _problemService.getProblems();

    filterListByQuery(_searchBarController.text);
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getProblems(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
      filterListByQuery(_searchBarController.text);
    });
  }

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredProblemList = problemList
            .where((problem) => problem.descrizione.contains(query.toString()))
            .toList();
      });
    } else {
      setState(() {
        _filteredProblemList = problemList;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _problemService = ProblemService();
    loggedMember = widget.loggedMember;
    _dataLoading = _getProblems();
  }

  @override
  void dispose() {
    super.dispose();
    _searchBarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          children: [
            SizedBox(height: 30),
            // SEARCH BAR
            _searchBar(),

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
                              itemCount: _filteredProblemList.length,
                              itemBuilder: (context, index) {
                                final element = _filteredProblemList[index];
                                return CardProblemListItem(
                                    problem: element,
                                    loggedMember: loggedMember);
                              },
                            );
                          }
                        }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
          decoration: BoxDecoration(
            color: backgroundColor, // Light background color
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10,
                offset: Offset(-5, -5),
              ),
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 10,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _searchBarController,
            onChanged: (query) {
              filterListByQuery(query);
            },
            cursorColor: Colors.black,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Descrizione del problema',
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )),
    );
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.close), // Change to the "X" icon
          onPressed: () {
            // Implement your desired action when the "X" icon is pressed
            Navigator.pop(context); // Example action: Navigate back
          },
        )
      ],
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Problemi",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

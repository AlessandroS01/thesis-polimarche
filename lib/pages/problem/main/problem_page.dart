import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;

  late final Member loggedMember;
  late final ProblemService _problemService;

  final TextEditingController _searchBarController = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

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
            ),

            widget.loggedMember.ruolo == "Caporeparto" ||
                    widget.loggedMember.ruolo == "Manager"
                ? _newProblemButton(distanceAdd, blurAdd)
                  : Container()
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

  Align _newProblemButton(Offset distanceAdd, double blurAdd) {
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

                _addProblemDialog();

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

  Future<dynamic> _addProblemDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Center(child: const Text("NUOVO PROBLEMA")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [ // Add some spacing between the text field and radio buttons
                  TextField(
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
                  hintText: 'Descrizione',
                  hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controllerDescription,
                      ),
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
                  onPressed: _addNewProblem,
                ),
              ],
            ),
          );
        });
  }

  Future<void> _addNewProblem() async {
    String description = _controllerDescription.text;

    if (description.isNotEmpty) {
      if (!problemList.map((problem) => problem.descrizione.toLowerCase()).toList().contains(description.toLowerCase())) {
        await _problemService.addNewProblem(description);

        _controllerDescription.clear();

        _refreshState();

        Navigator.pop(context);

      } else {
        showToast("Il problema inserito è già registrato");
      }
    } else {
      showToast("Immettere una descrizione");
    }

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

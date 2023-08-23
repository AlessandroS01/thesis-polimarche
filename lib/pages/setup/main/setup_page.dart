import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/model/Setup.dart';
import 'package:polimarche/pages/session/main/session_list_item_card.dart';
import 'package:polimarche/pages/setup/main/setup_list_item_card.dart';
import 'package:polimarche/services/session_service.dart';
import 'package:polimarche/services/setup_service.dart';

import '../../../model/Member.dart';

class SetupPage extends StatefulWidget {
  final Member loggedMember;
  final SetupService setupService;

  const SetupPage({super.key, required this.loggedMember, required this.setupService});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final backgroundColor = Colors.grey.shade300;

  late Member loggedMember;
  late final SetupService setupService;

  final TextEditingController _searchBarController = TextEditingController();

  late List<Setup> setupList;
  // list displayed inside the listView
  List<dynamic> _filteredSetupList = [];

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {

    if (query.isNotEmpty) {
      setState(() {
        _filteredSetupList = setupList
            .where((element) =>
                element.id.toString().contains(query.toString()))
            .toList();
      });
    } else {
      setState(() {
        _filteredSetupList = setupList;
      });
    }
  }

  // called whenever a button is clicked
  void changeEventButtonPressed() {
    setState(() {
      filterListByQuery(_searchBarController.text);
    });
  }

  @override
  void initState() {
    super.initState();

    setupService = widget.setupService;
  }

  @override
  Widget build(BuildContext context) {
    loggedMember = widget.loggedMember;
    setupList = setupService.listSetups;

    setState(() {
      filterListByQuery(_searchBarController.text);
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          children: [
            SizedBox(height: 30),
            // SEARCH BAR
            _searchBar(),

            Expanded(
              child: Container(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification:
                      (OverscrollIndicatorNotification overscroll) {
                    overscroll
                        .disallowIndicator(); // Disable the overscroll glow effect
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: _filteredSetupList.length,
                    itemBuilder: (context, index) {
                      final element = _filteredSetupList[index];
                      return CardSetupListItem(
                          setup: element, loggedMember: loggedMember);


                    },
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
            keyboardType: TextInputType.number,
            controller: _searchBarController,
            onChanged: (query) {
              filterListByQuery(query);
            },
            cursorColor: Colors.black,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Id setup',
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )),
    );
  }

}

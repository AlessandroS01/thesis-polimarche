import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/setup_model.dart';
import 'package:polimarche/pages/setup/main/setup_list_item_card.dart';

import '../../../model/member_model.dart';

class SetupPage extends StatefulWidget {
  final Member loggedMember;

  const SetupPage({super.key, required this.loggedMember});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final backgroundColor = Colors.grey.shade300;

  late final Member loggedMember;
  //late final SetupService setupService;

  final TextEditingController _searchBarController = TextEditingController();

  late List<Setup> setupList;
  // list displayed inside the listView
  List<dynamic> _filteredSetupList = [];

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {

    if (query.isNotEmpty) {
      setState(() {
        _filteredSetupList = setupList
            .where((setup) => setup.id.toString().contains(query.toString()))
            .toList();
      });
    } else {
      setState(() {
        _filteredSetupList = setupList;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    //setupService = widget.setupService;
    loggedMember = widget.loggedMember;
  }

  @override
  Widget build(BuildContext context) {

    //setupList = setupService.listSetups;
    filterListByQuery(_searchBarController.text);

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
                          setup: element,
                          loggedMember: loggedMember
                      );
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

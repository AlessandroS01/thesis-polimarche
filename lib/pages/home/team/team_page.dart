import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polimarche/model/driver_model.dart';
import 'package:polimarche/service/driver_service.dart';
import 'package:polimarche/service/member_service.dart';

import '../../../model/member_model.dart';
import 'member_list_item_card.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final backgroundColor = Colors.grey.shade300;

  bool isDriverPressed = false;
  List<String> workshops = [
    "Telaio",
    "Aereodinamica",
    "Dinamica",
    "Battery pack",
    "Elettronica",
    "Controlli",
    "Statica"
  ];
  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  final TextEditingController _searchBarController = TextEditingController();

  late final DriverService driverService;
  late final MemberService memberService;

  late List<Member> members;
  late List<Driver> drivers;

  // contains all the members and workshop areas
  List<dynamic> _teamMembers = [];
  // contains all the drivers
  List<dynamic> _teamDrivers = [];
  // list displayed inside the listView
  List<dynamic> _filteredTeamList = [];

  Future<void> _getMembersAndDrivers() async {
    members = await memberService.getMembers();
    drivers = await driverService.getDrivers();

    populateTeamList();
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getMembersAndDrivers(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
      filterListByQuery(_searchBarController.text);
    });
  }

  @override
  void initState() {
    super.initState();

    memberService = MemberService();
    driverService = DriverService();
    _dataLoading = _getMembersAndDrivers();

    filterListByQuery(_searchBarController.text);
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  // populate _teamMembers and _teamDrivers
  void populateTeamList() {
    _teamMembers.clear();
    _teamMembers.add("Managers");
    _teamMembers
        .addAll(members.where((member) => member.ruolo == "Manager").toList());

    workshops.forEach((area) {
      _teamMembers.add(area);

      _teamMembers
          .addAll(members.where((member) => member.reparto == area).toList());
    });

    _teamDrivers.clear();
    _teamDrivers.add("Piloti");
    // add all the members who are also drivers
    _teamDrivers.addAll(drivers);
  }

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {
    if (query.isNotEmpty && !isDriverPressed) {
      setState(() {
        _filteredTeamList = _teamMembers
            .where((element) =>
                element is String ||
                (element is Member &&
                    element.matricola.toString().contains(query)))
            .toList();
      });
    } else if (query.isNotEmpty && isDriverPressed) {
      setState(() {
        _filteredTeamList = _teamDrivers
            .where((element) =>
                element is String ||
                (element is Driver &&
                    element.membro.matricola.toString().contains(query)))
            .toList();
      });
    } else if (query.isEmpty && isDriverPressed) {
      setState(() {
        _filteredTeamList = _teamDrivers;
      });
    } else {
      setState(() {
        _filteredTeamList = _teamMembers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset distance = isDriverPressed ? Offset(5, 5) : Offset(18, 18);
    double blur = isDriverPressed ? 5.0 : 30.0;

    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: 35),

        // SEARCH BAR
        _searchBar(),

        // DRIVER BUTTON
        _driverButton(distance, blur),

        // LIST OF MEMBERS
        _listMember()
      ],
    ));
  }

  Expanded _listMember() {
    return Expanded(
        flex: 5,
        child: RefreshIndicator(
          onRefresh: _refreshState,
          child: Container(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll
                    .disallowIndicator(); // Disable the overscroll glow effect
                return false;
              },
              child: FutureBuilder(
                future: _dataLoading,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
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
                        itemCount: _filteredTeamList.length,
                        itemBuilder: (context, index) {
                          final element = _filteredTeamList[index];
                          if (element is String) {
                            return ListTile(
                              title: Center(
                                child: Text(
                                  element,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            );
                          }
                          // CREATE A CARD FOR EACH MEMBER
                          if (element is Member) {
                            List driver = _teamDrivers
                                .where((driver) =>
                                    driver is Driver &&
                                    driver.membro.matricola ==
                                        element.matricola)
                                .toList();
                            if (driver.length == 0) {
                              // MEMBER NOT DRIVER
                              return CardMemberListItem(
                                  member: element, driver: null);
                            } else {
                              // MEMBER ALSO DRIVER
                              return CardMemberListItem(
                                  member: element, driver: driver.first);
                            }
                          }
                          // CREATE A CARD FOR EACH DRIVER
                          if (element is Driver) {
                            return CardMemberListItem(
                                member: element.membro, driver: element);
                          }
                          return null;
                        });
                  }
                },
              ),
            ),
          ),
        ));
  }

  Container _driverButton(Offset distance, double blur) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Listener(
          onPointerDown: (_) async {
            setState(
                () => isDriverPressed = !isDriverPressed); // Toggle the state
            _refreshState();
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: isDriverPressed
                    ? [
                        //
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: distance,
                            blurRadius: blur,
                            inset: isDriverPressed),
                        BoxShadow(
                            color: Colors.white,
                            offset: -distance,
                            blurRadius: blur,
                            inset: isDriverPressed),
                      ]
                    : []),
            child: Column(
              children: [
                SvgPicture.asset("assets/icon/driver.svg"),
                SizedBox(height: 5),
                !isDriverPressed
                    ? Text(
                      "Clicca per visualizzare i piloti",
                      style: TextStyle(fontSize: 10),
                    )
                    : Text(
                      "Clicca per visualizzare il team",
                      style: TextStyle(fontSize: 10),
                    )
              ],
            ),
          ),
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
              hintText: 'Matricola',
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

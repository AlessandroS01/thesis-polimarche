import 'package:flutter/material.dart';

import '../../model/Member.dart';
import '../../model/Workshop.dart';
import 'cards/member.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final backgroundColor = Colors.grey.shade300;

  final TextEditingController _searchBarController = TextEditingController();

  List<Member> members = [
    Member(0, "Alessandro", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Aereodinamica")),
    Member(1097941, "Francesco", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Telaio")),
    Member(2, "Antonio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Manager", Workshop("")),
    Member(21, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
    Member(5, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
    Member(789, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
    Member(15, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Marketing")),
  ];
  List<Workshop> workshops = [
    Workshop("Aereodinamica"),
    Workshop("Telaio"),
    Workshop("Battery pack"),
    Workshop("Marketing"),
    Workshop("Elettronica"),
    Workshop("Dinamica"),
  ];

  // contains all the members and workshop areas
  List<dynamic> _team = [];
  // display list
  List<dynamic> _filteredTeamList = [];

  @override
  void initState() {
    populateTeamList();

    setState(() {
      _filteredTeamList = _team;
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();

    super.dispose();
  }

  void populateTeamList(){
    _team.add("Managers");
    _team.addAll(
      members.where((member) => member.ruolo == "Manager").toList()
    );

    workshops.forEach((area) {
      _team.add(area);

      _team.addAll(
          members.where((member) => member.reparto == area).toList()
      );
    });
  }

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {
      if(query.isNotEmpty){
         setState(() {
           _filteredTeamList = _team.where((element) =>
              element is String || element is Workshop
              || (element is Member && element.matricola.toString().contains(query))
           ).toList();
         });
      }
      else{
        setState(() {
          _filteredTeamList = _team;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Team",
                  style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                        ),
                  ),
              ),
            ),

            // SEARCH BAR
            Padding(
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
                        color: Colors.black,
                        fontFamily: 'aleo',
                        letterSpacing: 1
                    ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Matricola',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                    ),
                  ),
                )
              ),
            ),

            // LIST OF MEMEBERS
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator(); // Disable the overscroll glow effect
                    return false;
                  },
                  child: ListView.builder(
                      itemCount: _filteredTeamList.length,
                      itemBuilder: (context, index) {
                        final element = _filteredTeamList[index];

                        if(element is String){
                          return ListTile(
                            title: Center(
                                child: Text(
                                    element,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                ),
                            ),
                          );
                        }
                        if(element is Member){
                          return CardMember(member: element);
                        }
                        if(element is Workshop){
                          return ListTile(
                            title: Center(
                                child: Text(
                                    element.reparto,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                )
                            ),
                          );
                        }
                      },
                  ),
                ),
              )
            )
          ],
        )
    );
  }
}




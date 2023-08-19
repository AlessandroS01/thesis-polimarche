import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/inherited_widgets/team_state.dart';
import 'package:polimarche/model/Driver.dart';
import 'package:polimarche/services/team_service.dart';
import '../../../model/Member.dart';
import '../../../model/Workshop.dart';
import 'member_list_item_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optional/optional.dart';


class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final backgroundColor = Colors.grey.shade300;
  bool isDriverPressed = false;

  final TextEditingController _searchBarController = TextEditingController();

  late final TeamService teamService;

  late List<Member> members;
  late List<Workshop> workshops;
  late List<Driver> drivers;

  // contains all the members and workshop areas
  List<dynamic> _teamMembers = [];
  // contains all the drivers
  List<dynamic> _teamDrivers = [];
  // list displayed inside the listView
  List<dynamic> _filteredTeamList = [];

  @override
  void initState() {
    teamService = TeamService();

    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();

    super.dispose();
  }

  // populate _teamMembers and _teamDrivers
  void populateTeamList(){
    _teamMembers.clear();
    _teamMembers.add("Managers");
    _teamMembers.addAll(
      members.where((member) => member.ruolo == "Manager").toList()
    );

    workshops.forEach((area) {
      _teamMembers.add(area);

      _teamMembers.addAll(
          members.where((member) => member.reparto == area).toList()
      );
    });

    _teamDrivers.clear();
    _teamDrivers.add("Piloti");
    List<int> driverMatricole = drivers.map((driver) => driver.membro.matricola).toList();
    _teamDrivers.addAll(
      members.where((member) =>
        driverMatricole.contains(member.matricola)
      )
    );

  }

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {
      if(query.isNotEmpty && !isDriverPressed){
         setState(() {
           _filteredTeamList = _teamMembers.where((element) =>
              element is String || element is Workshop
              || (element is Member && element.matricola.toString().contains(query))
           ).toList();
         });
      }
      else if(query.isNotEmpty && isDriverPressed){
         setState(() {
           _filteredTeamList = _teamDrivers.where((element) =>
              element is String
              || (element is Member && element.matricola.toString().contains(query))
           ).toList();
         });
      }
      else if(query.isEmpty && isDriverPressed){
         setState(() {
           _filteredTeamList = _teamDrivers;
         });
      }
      else{
        setState(() {
          _filteredTeamList = _teamMembers;
        });
      }
  }

  // called when the user clicks on driver icon
  void toggleDisplayDrivers(){
      isDriverPressed
          ? setState(() {
              filterListByQuery(_searchBarController.text);
            })
          : {
            filterListByQuery(_searchBarController.text)
          };
  }

  void updateState() {
    setState(() {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {

    Offset distance = isDriverPressed ? Offset(5, 5) : Offset(18, 18);
    double blur = isDriverPressed ? 5.0 : 30.0;

    members = teamService.members;
    workshops = teamService.workshops;
    drivers = teamService.drivers;

    populateTeamList();

    setState(() {
      filterListByQuery(_searchBarController.text);
    });

    return TeamInheritedState(
      teamService: teamService,
      child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 35),

              // SEARCH BAR
              _searchBar(),

              // DRIVER BUTTON
              _driverButton(distance, blur),

              // LIST OF MEMBERS
              _listMember(updateState)
            ],
          )
      ),
    );
  }

  Expanded _listMember(VoidCallback updateState) {
    return Expanded(
            flex: 5,
            child: Container(
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
                      // CREATE A CARD FOR EACH MEMBER
                      if(element is Member){
                        Optional<Driver> driver = Optional.ofNullable(null);
                        _teamDrivers.asMap().forEach((index, item) {
                          if(item is Member
                                && item.matricola == element.matricola
                          ){
                            driver = Optional.of(
                                // -1 because the first position is occupied by a string
                                drivers[index - 1] // define the driver
                            );
                          }
                        });
                        return CardMemberListItem(
                            member: element,
                            driver: driver,
                            updateStateTeamPage: updateState,
                        );
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
                      return null;
                    },

                ),
              ),
            )
          );
  }

  Container _driverButton(Offset distance, double blur) {
    return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Listener(
                onPointerDown: (_) async {
                  setState(() => isDriverPressed = !isDriverPressed); // Toggle the state
                  toggleDisplayDrivers();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: isDriverPressed ? [
                        //
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: distance,
                            blurRadius: blur,
                            inset: isDriverPressed
                        ),
                        BoxShadow(
                            color: Colors.white,
                            offset: -distance,
                            blurRadius: blur,
                            inset: isDriverPressed
                        ),
                      ] : []
                  ),
                  child: SvgPicture.asset("assets/icon/driver.svg"),
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
          );
  }
}




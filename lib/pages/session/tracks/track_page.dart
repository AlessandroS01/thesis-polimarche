import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/pages/session/main/session_list_item_card.dart';
import 'package:polimarche/pages/session/tracks/track_list_item_card.dart';
import 'package:polimarche/services/session_service.dart';

import '../../../model/Member.dart';
import '../../../model/Track.dart';

class TrackPage extends StatefulWidget {
  final Member loggedMember;
  final SessionService sessionService;

  const TrackPage({super.key, required this.loggedMember, required this.sessionService});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {

  late Member loggedMember;
  final backgroundColor = Colors.grey.shade300;
  late final SessionService sessionService;

  final TextEditingController _searchBarController = TextEditingController();

  late List<Track> trackList;
  // list displayed inside the listView
  List<dynamic> _filteredTrackList = [];

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {

    if (query.isNotEmpty) {
      // event and query
      setState(() {
        _filteredTrackList = trackList
            .where((element) => element.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      // !event and !query
      setState(() {
        _filteredTrackList = trackList;
      });
    }
  }

  void updateStateTrack() {
    setState(() {
      return;
    });
  }

  @override
  void initState() {
    super.initState();

    sessionService = widget.sessionService;
  }

  @override
  Widget build(BuildContext context) {
    loggedMember = widget.loggedMember;
    trackList = sessionService.listTracks;


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
                    itemCount: _filteredTrackList.length,
                    itemBuilder: (context, index) {
                      final element = _filteredTrackList[index];
                      return CardTrackListItem(
                          track: element);
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


  Container _searchBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Padding(
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
                hintText: 'Nome tracciato',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            )),
      ),
    );
  }

}

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/pages/session/tracks/track_list_item_card.dart';
import 'package:polimarche/service/track_service.dart';

import '../../../model/member_model.dart';
import '../../../model/track_model.dart';

class TrackPage extends StatefulWidget {
  final Member loggedMember;

  const TrackPage({super.key, required this.loggedMember});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  late Member loggedMember;
  final backgroundColor = Colors.grey.shade300;

  late final TrackService _trackService;

  final TextEditingController _searchBarController = TextEditingController();

  Future<void>? _dataLoading;
  bool _isDataLoading = false;

  late List<Track> trackList;
  // list displayed inside the listView
  List<dynamic> _filteredTrackList = [];

  Future<void> _getTracks() async {
    trackList = await _trackService.getTracks();

    filterListByQuery(_searchBarController.text);
  }

  Future<void> _refreshState() async {
    setState(() {
      _isDataLoading = true;
    });

    await _getTracks(); // Await here to ensure data is loaded

    setState(() {
      _isDataLoading = false;
      filterListByQuery(_searchBarController.text);
    });
  }

  // called whenever the input inside the search bar changes
  void filterListByQuery(String query) {
    if (query.isNotEmpty) {
      // event and query
      setState(() {
        _filteredTrackList = trackList
            .where((element) =>
                element.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      // !event and !query
      setState(() {
        _filteredTrackList = trackList;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    loggedMember = widget.loggedMember;
    _trackService = TrackService();
    _dataLoading = _getTracks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshState,
        child: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            children: [
              SizedBox(height: 30),
              // SEARCH BAR
              _searchBar(),

              Expanded(
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
                              itemCount: _filteredTrackList.length,
                              itemBuilder: (context, index) {
                                final element = _filteredTrackList[index];
                                return CardTrackListItem(
                                  track: element,
                                );
                              },
                            );
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
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

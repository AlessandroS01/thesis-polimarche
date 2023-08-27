import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/model/Member.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/services/session_service.dart';
import '../../../../model/Comment.dart';
import 'comment_list_item_card.dart';

class CommentSessionPage extends StatefulWidget {
  final Session session;
  final SessionService sessionService;
  final Member loggedMember;

  const CommentSessionPage(
      {super.key,
      required this.session,
      required this.sessionService,
      required this.loggedMember});

  @override
  State<CommentSessionPage> createState() => _CommentSessionPageState();
}

class _CommentSessionPageState extends State<CommentSessionPage> {
  final backgroundColor = Colors.grey.shade300;
  Offset distanceAdd = Offset(5, 5);
  double blurAdd = 12;
  bool isAddPressed = false;

  late final SessionService sessionService;
  late final Session session;
  late final Member loggedMember;

  late List<Comment> _listComments;
  late List<Comment> _listCommentsDrivers;
  late List<Comment> _listCommentsTeam;

  bool _flagTeam = true;
  bool _flagPilota = false;

  void updateState() {
    setState(() {
      return;
    });
  }

  @override
  void initState() {
    session = widget.session;
    sessionService = widget.sessionService;
    loggedMember = widget.loggedMember;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _listComments = sessionService.getCommentsBySessionId(session.id);

    _listCommentsDrivers =
        _listComments.where((element) => element.flag == "Pilota").toList();

    _listCommentsTeam =
        _listComments.where((element) => element.flag == "Team").toList();

    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Piloti",
                style: TextStyle(fontSize: 16),
              ),
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
                        itemCount: _listCommentsDrivers.length,
                        itemBuilder: (context, index) {
                          final element = _listCommentsDrivers[index];
                          return CardCommentListItem(
                              comment: element,
                              sessionService: sessionService,
                              updateStateCommentPage: updateState,
                              loggedMember: loggedMember);
                        })),
              )),
              Text(
                "Team",
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                  child: Container(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll
                        .disallowIndicator(); // Disable the overscroll glow effect
                    return false;
                  },
                  child: ListView.builder(
                      itemCount: _listCommentsTeam.length,
                      itemBuilder: (context, index) {
                        final element = _listCommentsTeam[index];
                        return CardCommentListItem(
                            comment: element,
                            sessionService: sessionService,
                            updateStateCommentPage: updateState,
                            loggedMember: loggedMember);
                      }),
                ),
              )),
              loggedMember.ruolo == "Caporeparto" ||
                      loggedMember.ruolo == "Manager"
                  ? _newCommentButton(backgroundColor, distanceAdd, blurAdd)
                  : Container()
            ],
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
        "Commenti",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Align _newCommentButton(
      Color backgroundColor, Offset distanceAdd, double blurAdd) {
    TextEditingController _textFieldController = TextEditingController();
    TextEditingController _textFieldControllerFlag = TextEditingController();
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

                _addCommentDialog(
                    _textFieldController, _textFieldControllerFlag);
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

  Future<dynamic> _addCommentDialog(TextEditingController _textFieldController,
      TextEditingController _textFieldControllerFlag) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Nuova descrizione"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                style: const TextStyle(
                color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
                decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              hintText: 'Descrizione',
              hintStyle: TextStyle(color: Colors.grey),
                ),
                controller: _textFieldController,
              ),

              SizedBox(
                  height:
                      30), // Add some spacing between the text field and radio buttons

              Column(
                children: [
                  Text("Flag"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Team"),
                      Checkbox(
                        activeColor: Colors.black,
                        value: _flagTeam,
                        onChanged: (bool? value) {
                          setState(() {
                            _flagTeam = value!;
                            _flagPilota = !value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pilota"),
                      Checkbox(
                        activeColor: Colors.black,
                        value: _flagPilota,
                        onChanged: (bool? value) {
                          setState(() {
                            _flagPilota = value!;
                            _flagTeam = !value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancella"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Conferma"),
              onPressed: () {
                String newFlag = _flagTeam ? "Team" : "Pilota";

                  sessionService.addComment(_textFieldController.text,
                      newFlag, session);

                  updateState();

                  Navigator.pop(context);
                },
            ),
          ],
        ),
      ),
    );
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

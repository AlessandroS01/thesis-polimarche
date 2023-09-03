import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/general_informations/general_information_provider.dart';
import 'package:provider/provider.dart';

class GeneralInformationPage extends StatefulWidget {
  const GeneralInformationPage({super.key});

  static List<String> stringOf(BuildContext context) {
    final generalInformationProvider =
        Provider.of<GeneralInformationProvider>(context, listen: false);

    final List<String> strings = [
      generalInformationProvider.ala,
      generalInformationProvider.note
    ];

    return strings;
  }

  @override
  State<GeneralInformationPage> createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage> {
  final Color backgroundColor = Colors.grey.shade300;

  late GeneralInformationProvider generalInformationProvider;
  bool _isDataInitialized = false;

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

  // ALA DATA
  TextEditingController _controllerAla = TextEditingController();

  // ALA METHOD

  _checkNewAla(String? text) {
    if (text != null) {
      generalInformationProvider.ala = _controllerAla.text;
    }
  }

  // ALA DATA
  TextEditingController _controllerNote = TextEditingController();

  // ALA METHOD
  _checkNewNotes(String? text) {
    if (text != null) {
      generalInformationProvider.note = _controllerNote.text;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      generalInformationProvider =
          Provider.of<GeneralInformationProvider>(context, listen: false);

      // ALA
      _controllerAla.text = generalInformationProvider.ala;

      // NOTE
      _controllerNote.text = generalInformationProvider.note;

      setState(() {
        _isDataInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isDataInitialized
        ? Expanded(
            child: Container(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll
                    .disallowIndicator(); // Disable the overscroll glow effect
                return false;
              },
              child: ListView(children: [
                // ALA
                _alaColumn(),

                SizedBox(
                  height: 100,
                ),

                // NOTE
                _noteColumn(),
                SizedBox(
                  height: 50,
                ),
              ]),
            ),
          ))
        : Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Column _alaColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Ala",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      _frontNewAla()
    ]);
  }

  Container _frontNewAla() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 30),
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
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'aleo',
                      letterSpacing: 1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ala',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: _controllerAla,
                  onChanged: _checkNewAla,
                )),
          ),
        ],
      ),
    );
  }

  Column _noteColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Note",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      _frontNewNotes()
    ]);
  }

  Container _frontNewNotes() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 30),
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
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'aleo',
                      letterSpacing: 1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Note',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: _controllerNote,
                  onChanged: _checkNewNotes,
                )),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:polimarche/model/Wheel.dart';

class GeneralInformationPage extends StatefulWidget {
  final String ala;
  final String note;
  final void Function(String newAla, String newNote) updateModifySetupPage;

  const GeneralInformationPage({super.key, required this.ala, required this.note, required this.updateModifySetupPage});

  @override
  State<GeneralInformationPage> createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Informazioni generali"),
    );
  }
}

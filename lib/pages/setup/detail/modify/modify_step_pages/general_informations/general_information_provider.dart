import 'package:flutter/material.dart';

class GeneralInformationProvider with ChangeNotifier {
  late String _ala;

  late String _note;

  GeneralInformationProvider(this._ala, this._note);

  String get note => _note;

  set note(String value) {
    _note = value;
  }

  String get ala => _ala;

  set ala(String value) {
    _ala = value;
  }

}

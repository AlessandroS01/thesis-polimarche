import 'package:flutter/material.dart';

class GeneralInformationProviderCreate with ChangeNotifier {
  String _ala = "";

  String _note = "";

  GeneralInformationProviderCreate();

  String get note => _note;

  set note(String value) {
    _note = value;
  }

  String get ala => _ala;

  set ala(String value) {
    _ala = value;
  }

}

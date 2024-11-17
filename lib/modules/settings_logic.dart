import 'package:flutter/material.dart';

class SettingsLogic extends ChangeNotifier {
  bool dark = true;
  void changeMode(bool value) {
    dark = value;
    notifyListeners();
  }
}

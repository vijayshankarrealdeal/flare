import 'package:flutter/material.dart';

class NavbarModules extends ChangeNotifier{
  int index = 0;
  void changeTab(int idx){
    index = idx;
    notifyListeners();
  }
}
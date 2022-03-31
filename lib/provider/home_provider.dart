import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier{
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
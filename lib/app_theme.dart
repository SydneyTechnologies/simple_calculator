import 'package:flutter/material.dart';

class CalcTheme extends ChangeNotifier {
  bool darkMode = true;
  void setDarkMode() {
    darkMode = true;
    notifyListeners();
  }

  void setLightMode() {
    darkMode = false;
    notifyListeners();
  }

  bool getDarkMode() {
    return darkMode;
  }
}

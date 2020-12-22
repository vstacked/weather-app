import 'package:flutter/material.dart';

class AppThemeState extends ChangeNotifier {
  var isDarkModeEnabled = true;

  void setLightTheme() {
    print('light');
    isDarkModeEnabled = false;
    notifyListeners();
  }

  void setDarkTheme() {
    print('dark');
    isDarkModeEnabled = true;
    notifyListeners();
  }
}

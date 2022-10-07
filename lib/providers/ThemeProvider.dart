import 'package:bp_computers/utils/Themes.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  String defaultTheme = "light";

  String get currentTheme => defaultTheme;

  changeTheme(String theme) {
    defaultTheme = theme;
    notifyListeners();
  }

  Color? getColor(String theme, String term) {
    var index = theme == "Light" ? 0 : 1;
    return Themes[index][term];
  }
}

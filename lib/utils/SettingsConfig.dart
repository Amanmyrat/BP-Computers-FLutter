import 'package:bp_computers/utils/Themes.dart';
import 'package:flutter/material.dart';

class SettingsConfig {

  Color? getColor(String theme, String term) {
    var index = theme == "dark" ? 0 : 1;
    return Themes[index][term];
  }
}


import 'package:flutter/material.dart';

class SimulationCache {
  final Map<String, List<Color>> _colorCache = {};

  List<Color>? getColors(String themeName) {
    return _colorCache[themeName];
  }

  void setColors(String themeName, List<Color> colors) {
    _colorCache[themeName] = colors;
  }
}

import 'package:flutter/material.dart';

const List<Color> kThemeSeedColors = [
  Colors.cyan,
  Colors.blue,
  Colors.purple,
  Colors.pink,
  Colors.orange
];

class ThemeViewModel extends ChangeNotifier {
  Color get seedColor => kThemeSeedColors[_seedColorIndex];
  int _seedColorIndex = 0;
  set seedColorIndex(int index) {
    _seedColorIndex = index;
    notifyListeners();
  }

  Brightness get brightness => _brightness;
  Brightness _brightness = Brightness.light;

  set brightness(Brightness value) {
    _brightness = value;
    notifyListeners();
  }
}

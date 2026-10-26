import 'package:flutter/material.dart';

/// Mengatur mode tema (terang / gelap / ikuti sistem).
class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  void toggle(Brightness currentBrightness) {
    _mode = currentBrightness == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String THEME = "theme";

  late SharedPreferences _prefs;

  ThemeMode currentTheme = ThemeMode.system;

  ThemeMode get themeMode {
    if (currentTheme.name == 'dark') {
      return ThemeMode.dark;
    } else if (currentTheme.name == 'system') {
      return ThemeMode.system;
    } else {
      return ThemeMode.light;
    }
  }

  bool get isDarkMode {
    if (currentTheme.name == 'dark') {
      return true;
    } else {
      return false;
    }
  }

  void changeTheme(ThemeMode themeMode) async {
    currentTheme = themeMode;
    _prefs.setString(THEME, currentTheme.name);
    notifyListeners();
  }

  initialize() async {
    _prefs = await SharedPreferences.getInstance();
    currentTheme = ThemeMode.values.byName(_prefs.getString(THEME) ?? 'system');
    notifyListeners();
  }
}

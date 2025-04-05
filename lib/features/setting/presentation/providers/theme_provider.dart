import 'package:flutter/material.dart';
import 'package:arestro/core/theme/theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final ThemePreferences preferences;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider(this.preferences) {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> _loadTheme() async {
    final isDark = await preferences.isDarkTheme;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await preferences.setDarkTheme(isDark);
    notifyListeners();
  }
}
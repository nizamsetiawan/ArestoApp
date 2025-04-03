import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String _key = 'isDarkTheme';
  final SharedPreferences prefs;

  ThemePreferences(this.prefs);

  bool get isDarkTheme => prefs.getBool(_key) ?? false;

  Future<void> setDarkTheme(bool value) async {
    await prefs.setBool(_key, value);
  }
}
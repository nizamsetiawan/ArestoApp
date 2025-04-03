import 'package:shared_preferences/shared_preferences.dart';

class ReminderPreferences {
  static const String _key = 'dailyReminder';
  final SharedPreferences prefs;

  ReminderPreferences(this.prefs);

  bool get isReminderActive => prefs.getBool(_key) ?? false;

  Future<void> setReminder(bool value) async {
    await prefs.setBool(_key, value);
  }
}
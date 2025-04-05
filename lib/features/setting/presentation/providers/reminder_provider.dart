import 'package:flutter/material.dart';
import 'package:arestro/core/notification/notification_helper.dart';
import 'package:arestro/core/notification/reminder_preferences.dart';

class ReminderProvider with ChangeNotifier {
  final ReminderPreferences preferences;
  final NotificationHelper notificationHelper;
  bool _isReminderActive = false;

  ReminderProvider({
    required this.preferences,
    required this.notificationHelper,
  }) {
    _loadReminderStatus();
  }

  bool get isReminderActive => _isReminderActive;

  Future<void> _loadReminderStatus() async {
    _isReminderActive = await preferences.isReminderActive;
    notifyListeners();
  }

  Future<void> toggleReminder(bool value) async {
    try {
      // Request permissions first
      final hasPermission = await notificationHelper.requestPermissions();
      if (!hasPermission) {
        _isReminderActive = false;
        notifyListeners();
        return;
      }

      _isReminderActive = value;
      await preferences.setReminder(value);

      if (value) {
        await notificationHelper.showDailyNotification();
      } else {
        await notificationHelper.cancelNotification(0);
      }
    } catch (e) {
      _isReminderActive = false;
      await preferences.setReminder(false);
      debugPrint('Failed to set reminder: $e');
    } finally {
      notifyListeners();
    }
  }
}

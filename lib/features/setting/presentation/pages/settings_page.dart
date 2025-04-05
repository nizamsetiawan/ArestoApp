import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reminder_provider.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return SwitchListTile(
                title: const Text('Mode Gelap'),
                value: themeProvider.isDark,
                onChanged: (value) => themeProvider.toggleTheme(value),
              );
            },
          ),
          Consumer<ReminderProvider>(
            builder: (context, reminderProvider, _) {
              return SwitchListTile(
                title: const Text('Pemberitahuan'),
                subtitle: const Text('Dapatkan pemberitahuan setiap jam 11:00'),
                value: reminderProvider.isReminderActive,
                onChanged: (value) => reminderProvider.toggleReminder(value),
              );
            },
          ),
        ],
      ),
    );
  }
}
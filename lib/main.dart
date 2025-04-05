import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arestro/core/constants/app_constants.dart';
import 'package:arestro/core/navigation/app_routes.dart';
import 'package:arestro/core/navigation/route_generator.dart';
import 'package:arestro/core/styles/app_colors.dart';
import 'package:arestro/core/styles/app_text_styles.dart';
import 'package:arestro/injection_container.dart' as di;

import 'core/notification/notification_helper.dart';
import 'features/favorite/presentation/providers/favorite_provider.dart';
import 'features/restaurant/presentation/providers/restaurant_detail_provider.dart';
import 'features/restaurant/presentation/providers/restaurant_list_provider.dart';
import 'features/restaurant/presentation/providers/restaurant_search_provider.dart';
import 'features/setting/presentation/providers/reminder_provider.dart';
import 'features/setting/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // Initialize notifications
  final notificationHelper = di.sl<NotificationHelper>();
  await notificationHelper.initNotifications();
  await notificationHelper.flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<RestaurantListProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<RestaurantDetailProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<RestaurantSearchProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<FavoriteProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ReminderProvider>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: themeProvider.themeMode,
            initialRoute: AppRoutes.initial,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: Colors.white,
        background: AppColors.lightBackground,
        error: AppColors.error,
      ),
      textTheme: AppTextStyles.textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        titleTextStyle: AppTextStyles.textTheme.titleLarge?.copyWith(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.secondary,
        secondary: AppColors.secondary,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        error: AppColors.error,
      ),
      textTheme: AppTextStyles.textTheme.apply(
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.secondary,
        titleTextStyle: AppTextStyles.textTheme.titleLarge?.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
      ),
    );
  }
}
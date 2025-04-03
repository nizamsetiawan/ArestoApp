import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/navigation/route_generator.dart';
import 'core/styles/app_colors.dart';
import 'core/styles/app_text_styles.dart';
import 'injection_container.dart' as di;
import 'core/navigation/app_routes.dart';
import 'features/restaurant/presentation/providers/restaurant_list_provider.dart';
import 'features/restaurant/presentation/providers/restaurant_detail_provider.dart';
import 'features/restaurant/presentation/providers/restaurant_search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => di.sl<RestaurantListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.sl<RestaurantDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.sl<RestaurantSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ThemeMode.system, // Mengikuti tema sistem
        initialRoute: AppRoutes.initial,
        onGenerateRoute: RouteGenerator.generateRoute,
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
        background: AppColors.background,
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
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.secondary,
        secondary: AppColors.secondary,
        surface: Color(0xFF121212),
        background: Color(0xFF121212),
        error: AppColors.error,
      ),
      textTheme: AppTextStyles.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.secondary,
        titleTextStyle: AppTextStyles.textTheme.titleLarge?.copyWith(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF1E1E1E),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.3)),
        ),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        labelStyle: TextStyle(color: Colors.white70),
      ),
    );
  }
}
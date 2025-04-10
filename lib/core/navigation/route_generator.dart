import 'package:flutter/material.dart';

import '../../features/favorite/presentation/pages/favorites_page.dart';
import '../../features/restaurant/presentation/pages/restaurant_detail_page.dart';
import '../../features/restaurant/presentation/pages/restaurant_list_page.dart';
import '../../features/restaurant/presentation/pages/restaurant_search_page.dart';
import '../../features/setting/presentation/pages/settings_page.dart';
import 'app_routes.dart';

import '../../features/restaurant/domain/entities/restaurant.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
      case AppRoutes.restaurantList:
        return MaterialPageRoute(builder: (_) => const RestaurantListPage());
      case AppRoutes.restaurantDetail:
        final restaurant = settings.arguments as Restaurant;
        return MaterialPageRoute(
          builder: (_) => RestaurantDetailPage(restaurant: restaurant),
        );
      case AppRoutes.restaurantSearch:
        return MaterialPageRoute(builder: (_) => const RestaurantSearchPage());
      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
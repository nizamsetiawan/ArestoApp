import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/database/database_helper.dart';
import 'core/network/network_info.dart';
import 'core/notification/notification_helper.dart';
import 'core/notification/reminder_preferences.dart';
import 'core/theme/theme_preferences.dart';
import 'features/favorite/data/datasources/favorite_local_data_source.dart';
import 'features/favorite/data/repositories/favorite_repository_impl.dart';
import 'features/favorite/domain/repositories/favorite_repository.dart';
import 'features/favorite/domain/usecases/add_favorite.dart';
import 'features/favorite/domain/usecases/get_favorites.dart';
import 'features/favorite/domain/usecases/is_favorite.dart';
import 'features/favorite/domain/usecases/remove_favorite.dart';
import 'features/favorite/presentation/providers/favorite_provider.dart';
import 'features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'features/restaurant/domain/repositories/restaurant_repository.dart';
import 'features/restaurant/domain/usecases/get_restaurant_detail.dart';
import 'features/restaurant/domain/usecases/get_restaurant_list.dart';
import 'features/restaurant/domain/usecases/post_review.dart';
import 'features/restaurant/domain/usecases/search_restaurants.dart';
import 'features/restaurant/presentation/providers/restaurant_detail_provider.dart';
import 'features/restaurant/presentation/providers/restaurant_list_provider.dart';
import 'features/restaurant/presentation/providers/restaurant_search_provider.dart';
import 'features/setting/presentation/providers/reminder_provider.dart';
import 'features/setting/presentation/providers/theme_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(sl()),
  );

  // Database
  sl.registerLazySingleton(() => DatabaseHelper());

  // Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => ThemePreferences(sl()));
  sl.registerLazySingleton(() => ReminderPreferences(sl()));

  // Notification
  sl.registerLazySingleton(() => NotificationHelper());

  // Data sources
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
        () => RestaurantRemoteDataSourceImpl(dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<RestaurantRepository>(
        () => RestaurantRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRestaurantList(sl()));
  sl.registerLazySingleton(() => GetRestaurantDetail(sl()));
  sl.registerLazySingleton(() => SearchRestaurants(sl()));
  sl.registerLazySingleton(() => PostReview(sl()));

  // Favorite Feature
  sl.registerLazySingleton<FavoriteLocalDataSource>(
          () => FavoriteLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<FavoriteRepository>(
          () => FavoriteRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => AddFavorite(sl()));
  sl.registerLazySingleton(() => RemoveFavorite(sl()));
  sl.registerLazySingleton(() => IsFavorite(sl()));

  // Providers
  sl.registerFactory(
        () => RestaurantListProvider(getRestaurantList: sl()),
  );
  sl.registerFactory(
        () => RestaurantDetailProvider(
      getRestaurantDetail: sl(),
      postReview: sl(),
    ),
  );
  sl.registerFactory(
        () => RestaurantSearchProvider(searchRestaurants: sl()),
  );
  sl.registerFactory(
        () => FavoriteProvider(
      getFavorites: sl(),
      addFavorite: sl(),
      removeFavorite: sl(),
    ),
  );
  sl.registerFactory(() => ThemeProvider(sl()));
  sl.registerFactory(() => ReminderProvider(
    preferences: sl(),
    notificationHelper: sl(),
  ));
}
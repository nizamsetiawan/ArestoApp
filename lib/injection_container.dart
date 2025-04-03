import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/network/network_info.dart';
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

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(sl()),
  );

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
}
import 'package:arestro/core/database/database_helper.dart';
import 'package:arestro/features/restaurant/data/models/restaurant_model.dart';

abstract class FavoriteLocalDataSource {
  Future<List<RestaurantModel>> getFavorites();
  Future<void> addFavorite(RestaurantModel restaurant);
  Future<void> removeFavorite(String id);
  Future<bool> isFavorite(String id);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final DatabaseHelper databaseHelper;

  FavoriteLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<void> addFavorite(RestaurantModel restaurant) async {
    await databaseHelper.insertFavorite(restaurant);
  }

  @override
  Future<List<RestaurantModel>> getFavorites() async {
    return await databaseHelper.getFavorites();
  }

  @override
  Future<bool> isFavorite(String id) async {
    return await databaseHelper.isFavorite(id);
  }

  @override
  Future<void> removeFavorite(String id) async {
    await databaseHelper.removeFavorite(id);
  }
}
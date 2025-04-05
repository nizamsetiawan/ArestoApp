import 'package:flutter/material.dart';
import 'package:arestro/core/enums/result_state.dart';
import 'package:arestro/features/favorite/domain/usecases/add_favorite.dart';
import 'package:arestro/features/favorite/domain/usecases/get_favorites.dart';
import 'package:arestro/features/favorite/domain/usecases/remove_favorite.dart';
import 'package:arestro/features/restaurant/domain/entities/restaurant.dart';

class FavoriteProvider with ChangeNotifier {
  final GetFavorites getFavorites;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;

  FavoriteProvider({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
  }) {
    loadFavorites();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _state = ResultState.loading;
    notifyListeners();

    final result = await getFavorites.execute();
    result.fold(
          (failure) {
        _state = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
          (restaurants) {
        _state = restaurants.isEmpty ? ResultState.noData : ResultState.hasData;
        _favorites = restaurants;
        notifyListeners();
      },
    );
  }

  Future<bool> isFavorite(String id) async {
    return _favorites.any((restaurant) => restaurant.id == id);
  }

  Future<void> toggleFavorite(Restaurant restaurant) async {
    final isCurrentlyFavorite = await isFavorite(restaurant.id);
    final result = isCurrentlyFavorite
        ? await removeFavorite.execute(restaurant.id)
        : await addFavorite.execute(restaurant);

    result.fold(
          (failure) {
        _message = failure.message;
        notifyListeners();
      },
          (_) => loadFavorites(),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/enums/result_state.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/usecases/search_restaurants.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final SearchRestaurants searchRestaurants;
  Timer? _searchTimer;


  RestaurantSearchProvider({required this.searchRestaurants});

  ResultState _state = ResultState.noData;
  ResultState get state => _state;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  String _message = '';
  String get message => _message;

  void search(String query) {
    _searchTimer?.cancel();

    if (query.isEmpty) {
      _state = ResultState.noData;
      _restaurants = [];
      notifyListeners();
      return;
    }

    _state = ResultState.loading;
    notifyListeners();

    _searchTimer = Timer(const Duration(milliseconds: 500), () async {
      final result = await searchRestaurants.execute(query);

      result.fold(
            (failure) {
          _state = ResultState.error;
          _message = failure.message;
          notifyListeners();
        },
            (restaurants) {
          _state = restaurants.isEmpty ? ResultState.noData : ResultState.hasData;
          _restaurants = restaurants;
          notifyListeners();
        },
      );
    });
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    super.dispose();
  }
}
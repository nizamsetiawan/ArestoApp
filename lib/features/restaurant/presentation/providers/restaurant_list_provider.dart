import 'package:flutter/material.dart';

import '../../../../core/enums/result_state.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/usecases/get_restaurant_list.dart';

class RestaurantListProvider extends ChangeNotifier {
  final GetRestaurantList getRestaurantList;

  RestaurantListProvider({required this.getRestaurantList}) {
    fetchRestaurantList();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurantList() async {
    _state = ResultState.loading;
    notifyListeners();

    final result = await getRestaurantList.execute();

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
  }
}
import 'package:flutter/material.dart';

import '../../../../core/enums/result_state.dart';
import '../../domain/entities/restaurant_detail.dart';
import '../../domain/usecases/get_restaurant_detail.dart';
import '../../domain/usecases/post_review.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final GetRestaurantDetail getRestaurantDetail;
  final PostReview postReview;

  RestaurantDetailProvider({
    required this.getRestaurantDetail,
    required this.postReview,
  });

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  RestaurantDetail? _restaurantDetail;
  RestaurantDetail? get restaurantDetail => _restaurantDetail;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurantDetail(String id) async {
    _state = ResultState.loading;
    notifyListeners();

    final result = await getRestaurantDetail.execute(id);

    result.fold(
          (failure) {
        _state = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
          (restaurantDetail) {
        _state = ResultState.hasData;
        _restaurantDetail = restaurantDetail;
        notifyListeners();
      },
    );
  }

  Future<void> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final result = await postReview.execute(
      id: id,
      name: name,
      review: review,
    );

    result.fold(
          (failure) {
        _message = failure.message;
        notifyListeners();
      },
          (_) {
        fetchRestaurantDetail(id);
      },
    );
  }
}
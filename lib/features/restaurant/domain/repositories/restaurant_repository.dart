import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/restaurant.dart';
import '../entities/restaurant_detail.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurantList();
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(String id);
  Future<Either<Failure, List<Restaurant>>> searchRestaurants(String query);
  Future<Either<Failure, void>> postReview({
    required String id,
    required String name,
    required String review,
  });
}
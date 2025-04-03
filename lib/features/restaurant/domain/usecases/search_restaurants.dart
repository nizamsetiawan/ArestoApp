import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class SearchRestaurants {
  final RestaurantRepository repository;

  SearchRestaurants(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute(String query) async {
    return await repository.searchRestaurants(query);
  }
}
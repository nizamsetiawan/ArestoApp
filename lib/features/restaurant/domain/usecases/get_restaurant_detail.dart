import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/restaurant_detail.dart';
import '../repositories/restaurant_repository.dart';

class GetRestaurantDetail {
  final RestaurantRepository repository;

  GetRestaurantDetail(this.repository);

  Future<Either<Failure, RestaurantDetail>> execute(String id) async {
    return await repository.getRestaurantDetail(id);
  }
}
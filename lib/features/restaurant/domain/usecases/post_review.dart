import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/restaurant_repository.dart';

class PostReview {
  final RestaurantRepository repository;

  PostReview(this.repository);

  Future<Either<Failure, void>> execute({
    required String id,
    required String name,
    required String review,
  }) async {
    return await repository.postReview(
      id: id,
      name: name,
      review: review,
    );
  }
}
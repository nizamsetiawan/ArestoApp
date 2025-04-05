import 'package:dartz/dartz.dart';
import 'package:arestro/core/error/failures.dart';
import 'package:arestro/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:arestro/features/restaurant/domain/entities/restaurant.dart';

class AddFavorite {
  final FavoriteRepository repository;

  AddFavorite(this.repository);

  Future<Either<Failure, void>> execute(Restaurant restaurant) {
    return repository.addFavorite(restaurant);
  }
}
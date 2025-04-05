import 'package:dartz/dartz.dart';
import 'package:arestro/core/error/failures.dart';
import 'package:arestro/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:arestro/features/restaurant/domain/entities/restaurant.dart';

class GetFavorites {
  final FavoriteRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute() {
    return repository.getFavorites();
  }
}
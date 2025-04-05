import 'package:dartz/dartz.dart';
import 'package:arestro/core/error/failures.dart';
import 'package:arestro/features/restaurant/domain/entities/restaurant.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Restaurant>>> getFavorites();
  Future<Either<Failure, void>> addFavorite(Restaurant restaurant);
  Future<Either<Failure, void>> removeFavorite(String id);
  Future<Either<Failure, bool>> isFavorite(String id);
}
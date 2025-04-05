import 'package:dartz/dartz.dart';
import 'package:arestro/core/error/failures.dart';
import 'package:arestro/features/favorite/data/datasources/favorite_local_data_source.dart';
import 'package:arestro/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:arestro/features/restaurant/domain/entities/restaurant.dart';

import '../../../restaurant/data/models/restaurant_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Restaurant>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure('Failed to load favorites'));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(Restaurant restaurant) async {
    try {
      await localDataSource.addFavorite(RestaurantModel.fromEntity(restaurant));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to add favorite'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String id) async {
    try {
      await localDataSource.removeFavorite(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to remove favorite'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final isFav = await localDataSource.isFavorite(id);
      return Right(isFav);
    } catch (e) {
      return Left(CacheFailure('Failed to check favorite status'));
    }
  }
}
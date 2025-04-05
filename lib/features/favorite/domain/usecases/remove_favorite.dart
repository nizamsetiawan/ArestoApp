import 'package:dartz/dartz.dart';
import 'package:arestro/core/error/failures.dart';
import 'package:arestro/features/favorite/domain/repositories/favorite_repository.dart';

class RemoveFavorite {
  final FavoriteRepository repository;

  RemoveFavorite(this.repository);

  Future<Either<Failure, void>> execute(String id) {
    return repository.removeFavorite(id);
  }
}
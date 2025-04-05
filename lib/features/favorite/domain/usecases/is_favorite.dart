import 'package:dartz/dartz.dart';
import 'package:arestro/core/error/failures.dart';
import 'package:arestro/features/favorite/domain/repositories/favorite_repository.dart';

class IsFavorite {
  final FavoriteRepository repository;

  IsFavorite(this.repository);

  Future<Either<Failure, bool>> execute(String id) {
    return repository.isFavorite(id);
  }
}

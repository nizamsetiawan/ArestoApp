import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/restaurant_detail.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_data_source.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantList() async {
    if (await networkInfo.isConnected()) {
      try {
        final remoteRestaurants = await remoteDataSource.getRestaurantList();
        return Right(remoteRestaurants);
      } on ServerException {
        return Left(ServerFailure(" Server Failure"));
      }
    } else {
      return Left(NetworkFailure(" No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final remoteRestaurantDetail =
        await remoteDataSource.getRestaurantDetail(id);
        return Right(remoteRestaurantDetail);
      } on ServerException {
        return Left(ServerFailure( " Server Failure"));
      }
    } else {
      return Left(NetworkFailure(" No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurants(
      String query) async {
    if (await networkInfo.isConnected()) {
      try {
        final remoteRestaurants = await remoteDataSource.searchRestaurants(query);
        return Right(remoteRestaurants);
      } on ServerException {
        return Left( ServerFailure("Server Failure"));
      }
    } else {
      return Left(NetworkFailure( " No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, void>> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        await remoteDataSource.postReview(
          id: id,
          name: name,
          review: review,
        );
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure( " Server Failure"));
      }
    } else {
      return Left(NetworkFailure( " No Internet Connection"));
    }
  }
}

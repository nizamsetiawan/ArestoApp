import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/post_review_response_model.dart';
import '../models/restaurant_detail_model.dart';
import '../models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurantList();
  Future<RestaurantDetailModel> getRestaurantDetail(String id);
  Future<List<RestaurantModel>> searchRestaurants(String query);
  Future<PostReviewResponseModel> postReview({
    required String id,
    required String name,
    required String review,
  });
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final Dio dio;

  RestaurantRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<RestaurantModel>> getRestaurantList() async {
    final response = await dio.get(AppConstants.restaurantList);
    if (response.statusCode == 200) {
      return (response.data['restaurants'] as List)
          .map((restaurant) => RestaurantModel.fromJson(restaurant))
          .toList();
    } else {
      throw ServerException('Failed to load restaurant list');
    }
  }

  @override
  Future<RestaurantDetailModel> getRestaurantDetail(String id) async {
    final response = await dio.get('${AppConstants.restaurantDetail}/$id');
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(response.data['restaurant']);
    } else {
      throw ServerException('Failed to load restaurant detail');
    }
  }

  @override
  Future<List<RestaurantModel>> searchRestaurants(String query) async {
    final response = await dio.get(
      AppConstants.restaurantSearch,
      queryParameters: {'q': query},
    );
    if (response.statusCode == 200) {
      return (response.data['restaurants'] as List)
          .map((restaurant) => RestaurantModel.fromJson(restaurant))
          .toList();
    } else {
      throw ServerException('Failed to search restaurants');
    }
  }

  @override
  Future<PostReviewResponseModel> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await dio.post(
      AppConstants.postReview,
      data: {
        'id': id,
        'name': name,
        'review': review,
      },
    );
    if (response.statusCode == 201) {
      return PostReviewResponseModel.fromJson(response.data);
    } else {
      throw ServerException('Failed to post review');
    }
  }
}
import '../../domain/entities/restaurant_detail.dart';
import 'category_model.dart';
import 'customer_review_model.dart';
import 'menus_model.dart';

class RestaurantDetailModel extends RestaurantDetail {
  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.description,
    required super.city,
    required super.address,
    required super.pictureId,
    required super.categories,
    required super.menus,
    required super.rating,
    required super.customerReviews,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
        menus: MenusModel.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReviewModel>.from(
            json["customerReviews"].map((x) => CustomerReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": List<dynamic>.from(
        categories.map((x) => (x as CategoryModel).toJson())),
    "menus": (menus as MenusModel).toJson(),
    "rating": rating,
    "customerReviews": List<dynamic>.from(
        customerReviews.map((x) => (x as CustomerReviewModel).toJson())),
  };
}
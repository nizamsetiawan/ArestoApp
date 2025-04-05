import '../../../restaurant/data/models/restaurant_model.dart';
import '../../../restaurant/domain/entities/restaurant.dart';

extension RestaurantModelX on RestaurantModel {
  Restaurant toEntity() {
    return Restaurant(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      rating: rating,
    );
  }

  static RestaurantModel fromEntity(Restaurant restaurant) {
    return RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
    );
  }
}
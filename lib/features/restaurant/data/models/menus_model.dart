import '../../domain/entities/menus.dart';
import 'drink_model.dart';
import 'food_model.dart';

class MenusModel extends Menus {
  MenusModel({required super.foods, required super.drinks});

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
    foods: List<FoodModel>.from(
        json["foods"].map((x) => FoodModel.fromJson(x))),
    drinks: List<DrinkModel>.from(
        json["drinks"].map((x) => DrinkModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => (x as FoodModel).toJson())),
    "drinks":
    List<dynamic>.from(drinks.map((x) => (x as DrinkModel).toJson())),
  };
}

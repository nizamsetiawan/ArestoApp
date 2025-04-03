import '../../domain/entities/food.dart';

class FoodModel extends Food {
  FoodModel({required super.name});

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      FoodModel(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
import '../../domain/entities/drink.dart';

class DrinkModel extends Drink {
  DrinkModel({required super.name});

  factory DrinkModel.fromJson(Map<String, dynamic> json) =>
      DrinkModel(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
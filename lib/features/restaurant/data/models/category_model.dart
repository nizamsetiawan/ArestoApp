import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
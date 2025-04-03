import '../../domain/entities/costumer_review.dart';

class CustomerReviewModel extends CustomerReview {
  CustomerReviewModel({
    required super.name,
    required super.review,
    required super.date,
  });

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) =>
      CustomerReviewModel(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}
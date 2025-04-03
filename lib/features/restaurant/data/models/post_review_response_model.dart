import 'customer_review_model.dart';

class PostReviewResponseModel {
  final bool error;
  final String message;
  final List<CustomerReviewModel> customerReviews;

  PostReviewResponseModel({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory PostReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      PostReviewResponseModel(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReviewModel>.from(
            json["customerReviews"].map((x) => CustomerReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews":
    List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}
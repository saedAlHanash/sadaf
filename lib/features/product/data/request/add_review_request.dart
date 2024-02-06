import '../response/products_response.dart';

class AddReviewRequest {
  AddReviewRequest({
    required this.reviews,
    required this.orderId,
  });

  final List<Review> reviews;
  final int orderId;

  factory AddReviewRequest.fromJson(Map<String, dynamic> json) {
    return AddReviewRequest(
      orderId: 0,
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    );
  }

  factory AddReviewRequest.fromProducts(List<Product> json, int orderId) {
    return AddReviewRequest(
      orderId: orderId,
      reviews: List<Review>.from(
        json.map(
          (e) => Review(
            productId: e.id,
            rating: e.localRate,
          ),
        ),
      )..removeWhere((e) => e.rating == 0 || e.productId == 0),
    );
  }

  Map<String, dynamic> toJson() => {
        "reviews": reviews.map((x) => x.toJson()).toList(),
      };
}

class Review {
  Review({
    required this.productId,
    required this.rating,
  });

  final int productId;
  final num rating;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      productId: json["product_id"] ?? 0,
      rating: json["rating"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "rating": rating.toInt(),
      };
}

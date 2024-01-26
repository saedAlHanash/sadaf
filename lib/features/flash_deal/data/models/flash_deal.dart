import '../../../categories/data/response/category.dart';

class FlashDealResponse {
  FlashDealResponse({
    required this.data,
  });

  final List<FlashDeal> data;

  factory FlashDealResponse.fromJson(Map<String, dynamic> json) {
    return FlashDealResponse(
      data: json["data"] == null
          ? []
          : List<FlashDeal>.from(json["data"]!.map((x) => FlashDeal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class FlashDeal {
  FlashDeal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.inStock,
    required this.category,
    required this.price,
    required this.discountPrice,
    required this.discountEndAt,
    required this.isFavorite,
    required this.currency,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String thumbnail;
  final bool inStock;
  final Category category;
  final String price;
  final String discountPrice;
  final DateTime? discountEndAt;
  final bool isFavorite;
  final String currency;
  final String createdAt;

  factory FlashDeal.fromJson(Map<String, dynamic> json) {
    return FlashDeal(
            id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      inStock: json["in_stock"] ?? false,
      category: Category.fromJson(json["category"] ?? {}),
      price: json["price"] ?? "",
      discountPrice: json["discount_price"] ?? "",
      discountEndAt: DateTime.tryParse(json["discount_end_at"] ?? ""),
      isFavorite: json["is_favorite"] ?? false,
      currency: json["currency"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "in_stock": inStock,
        "category": category.toJson(),
        "price": price,
        "discount_price": discountPrice,
        "discount_end_at": discountEndAt?.toIso8601String(),
        "is_favorite": isFavorite,
        "currency": currency,
        "created_at": createdAt,
      };
}

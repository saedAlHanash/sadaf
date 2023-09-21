import '../models/product.dart';

class ProductByIdResponse {
  ProductByIdResponse({
    required this.data,
  });

  final ProductByIdResult? data;

  factory ProductByIdResponse.fromJson(Map<String, dynamic> json) {
    return ProductByIdResponse(
      data: json["data"] == null ? null : ProductByIdResult.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ProductByIdResult {
  ProductByIdResult({
    required this.product,
    required this.suggestions,
  });

  final Product product;
  final List<Product> suggestions;

  factory ProductByIdResult.fromJson(Map<String, dynamic> json) {
    return ProductByIdResult(
      product: Product.fromJson(json["product"] ?? {}),
      suggestions: json["suggestions"] == null
          ? []
          : List<Product>.from(json["suggestions"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "suggestions": suggestions.map((x) => x).toList(),
      };
}

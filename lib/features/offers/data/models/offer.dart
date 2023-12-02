import '../../../product/data/response/products_response.dart';

class Offer {
  Offer({
    required this.id,
    required this.offer,
    required this.type,
    required this.product,
    required this.startedAt,
    required this.expiredAt,
  });

  final int id;
  final num offer;
  final String type;
  final Product product;
  final String startedAt;
  final String expiredAt;

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json["id"] ?? 0,
      offer: json["offer"] ?? 0,
      type: json["type"] ?? "",
      product: Product.fromJson(json["product"] ?? {}),
      startedAt: json["started_at"] ?? "",
      expiredAt: json["expired_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer": offer,
    "type": type,
    "product": product.toJson(),
    "started_at": startedAt,
    "expired_at": expiredAt,
  };
}

import '../../../product/data/response/products_response.dart';

class FlashDeal {
  FlashDeal({
    required this.id,

  });

  final int id;

  factory FlashDeal.fromJson(Map<String, dynamic> json) {
    return FlashDeal(
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

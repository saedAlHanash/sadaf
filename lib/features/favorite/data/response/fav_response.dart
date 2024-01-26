class FavResponse {
  FavResponse({
    required this.data,
  });

  final List<Fav> data;

  factory FavResponse.fromJson(Map<String, dynamic> json) {
    return FavResponse(
      data: json["data"] == null
          ? []
          : List<Fav>.from(json["data"]!.map((x) => Fav.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Fav {
  Fav({
    required this.id,
    required this.productId,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.discountPrice,
  });

  final int id;
  final int productId;
  final String name;
  final String thumbnail;
  final String price;
  final String discountPrice;

  factory Fav.fromJson(Map<String, dynamic> json) {
    return Fav(
            id: int.tryParse(json["id"].toString()) ?? 0,
      productId:int.tryParse( json["product_id"].toString())  ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      price: json["price"] ?? "",
      discountPrice: json["discount_price"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "thumbnail": thumbnail,
        "price": price,
        "discount_price": discountPrice,
      };
}

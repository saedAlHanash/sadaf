import '../../../offers/data/models/offer.dart';
import '../../../product/data/response/products_response.dart';

class HomeResponse {
  HomeResponse({
    required this.data,
  });

  final HomeResult data;

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      data: HomeResult.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class HomeResult {
  HomeResult({
    required this.offers,
    required this.products,
    required this.bestSeller,
  });

  final List<Offer> offers;
  final List<Product> products;
  final List<Product> bestSeller;

  factory HomeResult.fromJson(Map<String, dynamic> json) {
    return HomeResult(
      offers: json["offers"] == null
          ? []
          : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
      products: json["products"] == null
          ? []
          : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
      bestSeller: json["bestSeller"] == null
          ? []
          : List<Product>.from(json["bestSeller"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "offers": offers.map((x) => x.toJson()).toList(),
        "products": products.map((x) => x.toJson()).toList(),
        "bestSeller": bestSeller.map((x) => x).toList(),
      };
}

class Brand {
  Brand({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class BannersResponse {
  BannersResponse({
    required this.data,
  });

  final List<BannerModel> data;

  factory BannersResponse.fromJson(Map<String, dynamic> json) {
    return BannersResponse(
      data: json["data"] == null
          ? []
          : List<BannerModel>.from(json["data"]!.map((x) => BannerModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class BannerModel {
  BannerModel({
    required this.id,
    required this.image,
    required this.action,
  });

  final int id;
  final String image;
  final String action;

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json["id"] ?? 0,
      image: json["image"] ?? "",
      action: json["action"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "action": action,
      };
}

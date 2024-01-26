import 'package:sadaf/features/categories/data/response/category.dart';
import 'package:sadaf/features/flash_deal/data/models/flash_deal.dart';

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
    required this.categories,
    required this.newProducts,
    required this.flashDeals,
    required this.offers,
  });

  final List<Category> categories;
  final List<Product> newProducts;
  final List<FlashDeal> flashDeals;
  final List<Offer> offers;

  factory HomeResult.fromJson(Map<String, dynamic> json) {
    return HomeResult(
    offers  : json["offers"] == null
          ? []
          : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),

      newProducts: json["new_products"] == null
          ? []
          : List<Product>.from(json["new_products"]!.map((x) => Product.fromJson(x))),

      flashDeals: json["flash_deals"] == null
          ? []
          : List<FlashDeal>.from(json["flash_deals"]!.map((x) => FlashDeal.fromJson(x))),

    categories: json["categories"] == null
          ? []
          : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "categories": categories.map((x) => x.toJson()).toList(),
        "new_products": newProducts.map((x) => x.toJson()).toList(),
        "flash_deals": flashDeals.map((x) => x).toList(),
        "offers": offers.map((x) => x).toList(),
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
            id: int.tryParse(json["id"].toString()) ?? 0,
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

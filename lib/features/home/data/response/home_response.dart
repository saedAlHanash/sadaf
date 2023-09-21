import '../../../catigories/data/models/category.dart';
import '../../../offers/data/models/offer.dart';
import '../../../product/data/models/product.dart';

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
    required this.offers,
    required this.products,
    required this.bestSeller,
  });

  final List<Category> categories;
  final List<Offer> offers;
  final List<Product> products;
  final List<Product> bestSeller;

  factory HomeResult.fromJson(Map<String, dynamic> json) {
    return HomeResult(
      categories: json["categories"] == null
          ? []
          : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
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
        "categories": categories.map((x) => x.toJson()).toList(),
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

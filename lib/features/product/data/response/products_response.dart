import 'package:collection/collection.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../colors/data/response/color_response.dart';

class ProductsResponse extends AbstractMeta {
  ProductsResponse({
    required this.data,
    required super.meta,
  });

  final List<Product> data;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      data: json["data"] == null
          ? []
          : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      meta: Meta.fromJson(json["meta"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "meta": meta.toJson(),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.inStock,
    required this.price,
    required this.priceInIqd,
    required this.discountPrice,
    required this.discountPriceInIqd,
    required this.discountEndAt,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.description,
    required this.images,
    required this.dddImages,
    required this.videoLinks,
    required this.options,
    required this.reviews,
    required this.rating,
    required this.isFavorite,
    required this.isReviewed,
    required this.relatedProducts,
  });

  final int id;
  final String name;
  final String thumbnail;
  final bool inStock;
  final String price;
  final String priceInIqd;
  final String discountPrice;
  final String discountPriceInIqd;
  final DateTime? discountEndAt;
  final List<ColorModel> color;
  final String size;
  final String createdAt;
  final String description;
  final List<String> images;
  final List<String> dddImages;
  final List<String> videoLinks;
  final List<Option> options;
  final List<Review> reviews;
  final num rating;
  bool isFavorite;
  final bool isReviewed;
  final List<Product> relatedProducts;

  //----
  num quantity = 0;
  double localRate = 3;
  final attachment = <Attachment>[];
  final Map<String, List<Option>> groupedOptions = {};
  final Map<String, List<Option>> groupedColors = {};

  factory Product.fromJson(Map<String, dynamic> json) {
    final product = Product(
      id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      inStock: json["in_stock"] ?? false,
      price: json["price"] ?? "",
      priceInIqd: json["price_in_iqd"] ?? "",
      discountPrice: json["discount_price"] ?? "",
      discountPriceInIqd: json["discount_price_in_iqd"] ?? "",
      discountEndAt: DateTime.tryParse(json["discount_end_at"] ?? ""),
      color: json["color"] == null
          ? <ColorModel>[]
          : (json["color"] is List)
              ? List<ColorModel>.from(json["color"]!.map((x) => ColorModel.fromJson(x)))
              : [ColorModel.fromJson(json["color"] ?? {})],
      size: json["size"] ?? "",
      createdAt: json["created_at"] ?? "",
      description: json["description"] ?? "",
      images:
          json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      dddImages: json["threed_images"] == null
          ? []
          : List<String>.from(json["threed_images"]!.map((x) => x)),
      videoLinks: json["video_links"] == null
          ? []
          : List<String>.from(json["video_links"]!.map((x) => x)),
      options: json["options"] == null
          ? []
          : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      rating: num.tryParse(json["rating"].toString()) ?? 0,
      isFavorite: json["is_favorite"] ?? false,
      isReviewed: json["is_reviewed"] ?? false,
      relatedProducts: json["related_products"] == null
          ? []
          : List<Product>.from(json["related_products"]!.map((x) => Product.fromJson(x))),
    );

    product.quantity = json['quantity'] ?? 0;
    product.localRate = json['localRate'] ?? 0;

    product.attachment
        .add(Attachment(link: product.thumbnail, type: AttachmentType.image));

    for (var e in product.images) {
      product.attachment.add(Attachment(link: e, type: AttachmentType.image));
    }

    for (var e in product.dddImages) {
      product.attachment.add(Attachment(link: e, type: AttachmentType.d3));
    }

    for (var e in product.videoLinks) {
      product.attachment.add(
        Attachment(
          link: e,
          type: e.getLinkType(type: AttachmentType.video),
        ),
      );
    }

    if (product.options.isNotEmpty) {
      product.groupedOptions
        ..clear()
        ..addAll(groupBy(product.options, (option) => option.size));

      product.groupedColors
        ..clear()
        ..addAll(groupBy(product.options, (option) => option.color.hex));
    }
    return product;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "in_stock": inStock,
        "price": price,
        "price_in_iqd": priceInIqd,
        "discount_price": discountPrice,
        "discount_price_in_iqd": discountPriceInIqd,
        "discount_end_at": discountEndAt,
        "color": color.map((e) => e.toJson()).toList(),
        "size": size,
        "created_at": createdAt,
        "description": description,
        "images": images.map((x) => x).toList(),
        "threed_images": dddImages.map((x) => x).toList(),
        "video_links": videoLinks.map((x) => x).toList(),
        "options": options.map((x) => x.toJson()).toList(),
        "reviews": reviews.map((x) => x.toJson()).toList(),
        "rating": rating,
        "is_favorite": isFavorite,
        "is_reviewed": isReviewed,
        "related_products": relatedProducts.map((x) => x.toJson()).toList(),
      };
}

class Option {
  Option({
    required this.id,
    required this.thumbnail,
    required this.price,
    required this.priceInIqd,
    required this.discountPrice,
    required this.discountPriceInIqd,
    required this.discountEndAt,
    required this.size,
    required this.color,
  });

  final int id;
  final String thumbnail;
  final String price;
  final String priceInIqd;
  final String discountPrice;
  final String discountPriceInIqd;
  final String discountEndAt;
  final String size;
  final ColorModel color;

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: int.tryParse(json["id"].toString()) ?? 0,
      thumbnail: json["thumbnail"] ?? "",
      price: json["price"] ?? "",
      priceInIqd: json["price_in_iqd"] ?? "",
      discountPrice: json["discount_price"] ?? "",
      discountPriceInIqd: json["discount_price_in_iqd"] ?? "",
      discountEndAt: json["discount_end_at"] ?? "",
      size: json["size"] ?? "",
      color: ColorModel.fromJson(json["color"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "price": price,
        "price_in_iqd": priceInIqd,
        "discount_price": discountPrice,
        "discount_price_in_iqd": discountPriceInIqd,
        "discount_end_at": discountEndAt,
        "size": size,
        "color": color.toJson(),
      };
}

class RelatedProduct {
  RelatedProduct({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.inStock,
    required this.price,
    required this.priceInIqd,
    required this.discountPrice,
    required this.discountPriceInIqd,
    required this.isFavorite,
    required this.isReviewed,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String thumbnail;
  final bool inStock;
  final String price;
  final String priceInIqd;
  final String discountPrice;
  final String discountPriceInIqd;
  final bool isFavorite;
  final bool isReviewed;
  final String createdAt;

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      inStock: json["in_stock"] ?? false,
      price: json["price"] ?? "",
      priceInIqd: json["price_in_iqd"] ?? "",
      discountPrice: json["discount_price"] ?? "",
      discountPriceInIqd: json["discount_price_in_iqd"] ?? "",
      isFavorite: json["is_favorite"] ?? false,
      isReviewed: json["is_reviewed"] ?? false,
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "in_stock": inStock,
        "price": price,
        "price_in_iqd": priceInIqd,
        "discount_price": discountPrice,
        "discount_price_in_iqd": discountPriceInIqd,
        "is_favorite": isFavorite,
        "is_reviewed": isReviewed,
        "created_at": createdAt,
      };
}

class Review {
  Review({
    required this.id,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final int id;
  final User user;
  final num rating;
  final String comment;
  final DateTime? createdAt;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: int.tryParse(json["id"].toString()) ?? 0,
      user: User.fromJson(json["user"] ?? {}),
      rating: num.tryParse(json["rating"].toString()) ?? 0,
      comment: json["comment"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "rating": rating,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.avatar,
  });

  final int id;
  final String name;
  final String avatar;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}

class Attachment {
  Attachment({
    required this.link,
    required this.type,
  });

  final String link;
  final AttachmentType type;
}

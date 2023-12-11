import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/generated/assets.dart';
import 'package:sadaf/generated/assets.dart';
import 'package:sadaf/generated/assets.dart';
import 'package:sadaf/generated/assets.dart';

import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import 'package:collection/collection.dart';

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
    required this.videoLinks,
    required this.options,
    required this.reviews,
    required this.rating,
    required this.isFavorite,
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
  final String discountEndAt;
  final ColorModel color;
  final String size;
  final String createdAt;
  final String description;
  final List<String> images;
  final List<String> videoLinks;
  final List<Option> options;
  final List<Review> reviews;
  final num rating;
  bool isFavorite;
  final List<Product> relatedProducts;

  //----
  num quantity = 0;
  final attachment = <Attachment>[];
  final Map<String, List<Option>> groupedOptions = {};
  final Map<String, List<Option>> groupedColors = {};

  factory Product.fromJson(Map<String, dynamic> json) {
    final product = Product(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      inStock: json["in_stock"] ?? false,
      price: json["price"] ?? "",
      priceInIqd: json["price_in_iqd"] ?? "",
      discountPrice: json["discount_price"] ?? "",
      discountPriceInIqd: json["discount_price_in_iqd"] ?? "",
      discountEndAt: json["discount_end_at"] ?? "",
      color:ColorModel.fromJson( json["color"] ?? {}),
      size: json["size"] ?? "",
      createdAt: json["created_at"] ?? "",
      description: json["description"] ?? "",
      images:
          json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      videoLinks: json["video_links"] == null
          ? []
          : List<String>.from(json["video_links"]!.map((x) => x)),
      options: json["options"] == null
          ? []
          : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      rating: json["rating"] ?? 0,
      isFavorite: json["is_favorite"] ?? false,
      relatedProducts: json["related_products"] == null
          ? []
          : List<Product>.from(json["related_products"]!.map((x) => Product.fromJson(x))),
    );

    product.quantity = json['quantity'] ?? 0;
    product.attachment
        .add(Attachment(link: product.thumbnail, type: AttachmentType.image));

    for (var e in product.images) {
      product.attachment.add(Attachment(link: e, type: AttachmentType.image));
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
        "color": color.toJson(),
        "size": size,
        "created_at": createdAt,
        "description": description,
        "images": images.map((x) => x).toList(),
        "video_links": videoLinks.map((x) => x).toList(),
        "options": options.map((x) => x.toJson()).toList(),
        "reviews": reviews.map((x) => x.toJson()).toList(),
        "rating": rating,
        "is_favorite": isFavorite,
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
      id: json["id"] ?? 0,
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
  final String createdAt;

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      inStock: json["in_stock"] ?? false,
      price: json["price"] ?? "",
      priceInIqd: json["price_in_iqd"] ?? "",
      discountPrice: json["discount_price"] ?? "",
      discountPriceInIqd: json["discount_price_in_iqd"] ?? "",
      isFavorite: json["is_favorite"] ?? false,
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
      id: json["id"] ?? 0,
      user: User.fromJson(json["user"] ?? {}),
      rating: json["rating"] ?? 0,
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
      id: json["id"] ?? 0,
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

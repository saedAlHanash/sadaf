//
// import '../../../categories/data/models/category.dart';
// import '../../../home/data/response/home_response.dart';
//
// class Product {
//   Product({
//     required this.id,
//     required this.quantity,
//     required this.name,
//     required this.cover,
//     required this.price,
//     required this.offer,
//     required this.description,
//     required this.category,
//     required this.brand,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isFav,
//     required this.offerType,
//   });
//
//   final int id;
//   final String name;
//   final List<String> cover;
//   final num price;
//   final num offer;
//   final String description;
//   final Category category;
//   final Brand brand;
//   final String createdAt;
//   final String updatedAt;
//   final String offerType;
//   bool isFav;
//
//   //-----------
//   int quantity;
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json["id"] ?? 0,
//       offerType: json["offer_type"] ?? "",
//       isFav: json["is_fav"] ?? false,
//       name: json["name"] ?? "",
//       cover: json["cover"] == null ? [''] : List<String>.from(json["cover"]!.map((x) => x)),
//       price: json["price"] ?? 0,
//       offer: json["offer"] ?? 0,
//       description: json["description"] ?? "",
//       category: Category.fromJson(json["category"] ?? {}),
//       brand: Brand.fromJson(json["brand"] ?? {}),
//       createdAt: json["created_at"] ?? "",
//       updatedAt: json["updated_at"] ?? "",
//       quantity: json["quantity"] ?? 1,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "cover": cover,
//         "price": price,
//         "is_fav": isFav,
//         "offer": offer,
//         "offer_type": offerType,
//         "description": description,
//         "category": category.toJson(),
//         "brand": brand.toJson(),
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "quantity": quantity,
//       };
// }

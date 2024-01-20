import 'package:sadaf/features/product/data/response/products_response.dart';

class CartResponse {
  CartResponse({
    required this.data,
  });

  final Cart data;

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      data: Cart.fromJson(json["data"] is List ? {} : json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Cart {
  Cart({
    required this.id,
    required this.user,
    required this.subtotal,
    required this.total,
    required this.couponCode,
    required this.products,
  });

  final int id;
  final User user;
  final num subtotal;
  final num total;
  final String couponCode;
  final List<Product> products;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json["id"] ?? 0,
      user: User.fromJson(json["user"] ?? {}),
      subtotal: num.tryParse(json["subtotal"] ?? '0') ?? 0,
      total: num.tryParse(json["total"] ?? '0') ?? 0,
      couponCode: json["coupon_code"] ?? '',
      products: json["products"] == null
          ? []
          : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "subtotal": subtotal,
        "total": total,
        "coupon_code": couponCode,
        "products": products.map((x) => x).toList(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.emailOrPhone,
  });

  final int id;
  final String name;
  final String emailOrPhone;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      emailOrPhone: json["email_or_phone"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email_or_phone": emailOrPhone,
      };
}

import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/request_models/command.dart';
import '../../../product/data/response/products_response.dart';

class OrdersResponse extends AbstractMeta {
  OrdersResponse({
    required this.data,
    required super.meta,
  });

  final List<Order> data;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      data: json["data"] == null
          ? []
          : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
      meta: Meta.fromJson(json["meta"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "meta": meta.toJson(),
      };
}

class Order {
  Order({
    required this.id,
    required this.subtotal,
    required this.total,
    required this.couponCode,
    required this.user,
    required this.products,
  });

  final int id;
  final String subtotal;
  final String total;
  final String couponCode;
  final User user;
  final List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? 0,
      subtotal: json["subtotal"] ?? "",
      total: json["total"] ?? "",
      couponCode: json["coupon_code"] ?? "",
      user: User.fromJson(json["user"] ?? {}),
      products: json["products"] == null
          ? []
          : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "subtotal": subtotal,
        "total": total,
        "coupon_code": couponCode,
        "user": user.toJson(),
        "products": products.map((x) => x.toJson()).toList(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.emailOrPhone,
    required this.address,
    required this.mapAddress,
  });

  final int id;
  final String name;
  final String emailOrPhone;
  final String address;
  final String mapAddress;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      emailOrPhone: json["email_or_phone"] ?? "",
      address: json["address"] ?? "",
      mapAddress: json["map_address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email_or_phone": emailOrPhone,
        "address": address,
        "map_address": mapAddress,
      };
}

import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../product/data/response/products_response.dart';
import '../../../profile/data/response/profile_response.dart';

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
    required this.status,
    required this.statusEnum,
    required this.subtotal,
    required this.total,
    required this.couponCode,
    required this.address,
    required this.user,
    required this.products,
  });

  final int id;
  final String status;
  final OrderStatus statusEnum;
  final String subtotal;
  final String total;
  final String couponCode;
  final Address address;
  final User user;
  final List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? 0,
      status: json["status"] ?? "",
      statusEnum: OrderStatus.values[(json["real_status"] ?? 1) - 1],
      subtotal: json["subtotal"] ?? "",
      total: json["total"] ?? "",
      couponCode: json["coupon_code"] ?? "",
      address: Address.fromJson(json["address"] is String ? {} : (json["address"] ?? {})),
      user: User.fromJson(json["user"] ?? {}),
      products: json["products"] == null
          ? []
          : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "subtotal": subtotal,
        "total": total,
        "coupon_code": couponCode,
        "address": address.toJson(),
        "user": user.toJson(),
        "products": products.map((x) => x.toJson()).toList(),
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

class Address {
  Address({
    required this.address,
    required this.mapAddress,
    required this.governor,
    required this.receiverPhone,
  });

  final String address;
  final MapAddress mapAddress;
  final String governor;
  final String receiverPhone;

  @override
  String toString() {
    return '$governor/$address';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json["address"] ?? "",
      mapAddress: MapAddress.fromJson(
          json["map_address"] is String ? {} : (json["map_address"] ?? {})),
      governor: json["governor"] ?? "",
      receiverPhone: json["receiver_phone"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "map_address": mapAddress.toJson(),
        "governor": governor,
        "receiver_phone": receiverPhone,
      };
}

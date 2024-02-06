import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/abstraction.dart';

import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/strings/enum_manager.dart';
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
    required this.status,
    required this.statusEnum,
    required this.subtotal,
    required this.total,
    required this.couponCode,
    required this.estimatedTime,
    required this.address,
    required this.user,
    required this.driver,
    required this.products,
  });

  final int id;
  final String status;
  final OrderStatus statusEnum;
  final String subtotal;
  final String total;
  final String couponCode;
  final DateTime? estimatedTime;
  final Address address;
  final User user;
  final Driver driver;
  final List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
            id: int.tryParse(json["id"].toString()) ?? 0,
      status: OrderStatus.values[(json["status"] ?? 1) - 1].getName,
      statusEnum: OrderStatus.values[(json["status"] ?? 1) - 1],
      subtotal: json["subtotal"] ?? "",
      total: json["total"] ?? "",
      couponCode: json["coupon_code"] ?? "",
      estimatedTime: DateTime.tryParse(json["estimated_time"].toString()),
      address: Address.fromJson(json["address"] is String ? {} : (json["address"] ?? {})),
      user: User.fromJson(json["user"] ?? {}),
      driver: Driver.fromJson(json["driver"] ?? {}),
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
        "estimated_time": estimatedTime,
        "address": address.toJson(),
        "user": user.toJson(),
        "driver": driver.toJson(),
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
            id: int.tryParse(json["id"].toString()) ?? 0,
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

class Driver {
  Driver({
    required this.id,
    required this.name,
    required this.emailOrPhone,
    required this.phone,
    required this.avatar,
    required this.trackNumber,
    required this.mapAddress,
  });

  final int id;
  final String name;
  final String emailOrPhone;
  final String phone;
  final String avatar;
  final String trackNumber;
  final MapAddress mapAddress;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
            id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      emailOrPhone: json["email_or_phone"] ?? "",
      phone: json["phone"] ?? "",
      avatar: json["avatar"] ?? "",
      trackNumber: json["track_number"] ?? "",
      mapAddress: MapAddress.fromJson(json["map_address"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email_or_phone": emailOrPhone,
        "phone": phone,
        "avatar": avatar,
        "track_number": trackNumber,
        "map_address": mapAddress.toJson(),
      };
}

class MapAddress {
  MapAddress({
    required this.latitude,
    required this.longitude,
  });

  LatLng? get latLng =>
      latitude == 0 ? null : LatLng(latitude.toDouble(), longitude.toDouble());

  final num latitude;
  final num longitude;

  factory MapAddress.fromJson(Map<String, dynamic> json) {
    return MapAddress(
      latitude: num.tryParse(json["latitude"].toString()) ?? 0,
      longitude: num.tryParse(json["longitude"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

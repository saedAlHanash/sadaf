import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileResponse {
  ProfileResponse({
    required this.data,
  });

  final Profile data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      data:  Profile.fromJson(json["data"]??{}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Profile {
  Profile({
    required this.name,
    required this.emailOrPhone,
    required this.mapAddress,
    required this.governor,
    required this.address,
    required this.receiverPhone,
    required this.avatar,
    required this.provider,
    required this.isFromSocial,
    required this.confirmedAt,
  });

  final String name;
  final String emailOrPhone;
  final MapAddress mapAddress;
  final Governor governor;
  final String address;
  final String receiverPhone;
  final String avatar;
  final String provider;
  final bool isFromSocial;
  final DateTime? confirmedAt;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json["name"] ?? "",
      emailOrPhone: json["email_or_phone"] ?? "",
      mapAddress: MapAddress.fromJson(
          json["map_address"] is String ? {} : (json["map_address"] ?? {})),
      governor:
          Governor.fromJson(json["governor"] is List ? {} : (json["governor"] ?? {})),
      address: json["address"] ?? "",
      receiverPhone: json["receiver_phone"] ?? "",
      avatar: json["avatar"] ?? "",
      provider: json["provider"] ?? "",
      isFromSocial: json["is_from_social"] ?? false,
      confirmedAt: DateTime.tryParse(json["otp_verified_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": emailOrPhone,
        "map_address": mapAddress.toJson(),
        "governor": governor.toJson(),
        "address": address,
        "receiver_phone": receiverPhone,
        "avatar": avatar,
        "provider": provider,
        "is_from_social": isFromSocial,
        "otp_verified_at": confirmedAt?.toIso8601String(),
      };
}

class Governor {
  Governor({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Governor.fromJson(Map<String, dynamic> json) {
    return Governor(
      id: int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class MapAddress {
  LatLng? get getLatLng => latitude == 0 ? null : LatLng(latitude, longitude);

  MapAddress({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  String toString() {
    return 'N:$latitude°  E:$longitude°';
  }

  factory MapAddress.fromJson(Map<String, dynamic> json) {
    return MapAddress(
      latitude: double.tryParse(json["latitude"].toString()) ?? 0,
      longitude: double.tryParse(json["longitude"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

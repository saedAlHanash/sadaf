import 'package:sadaf/generated/assets.dart';

class LoginResponse {
  LoginResponse({
    required this.data,
  });

  final LoginData data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: LoginData.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class LoginData {
  LoginData({
    required this.name,
    required this.mapAddress,
    required this.country,
    required this.city,
    required this.home,
    required this.id,
    required this.emailOrPhone,
    required this.token,
  });

  final int id;
  String name;
  String mapAddress;
  String emailOrPhone;
  String country;
  String city;
  String home;
  String token;
  String? _avatar;

  String get address {
    return '$city - $country - $home';
  }

  String get avatar {
    if (_avatar == null) return Assets.iconsLogo;
    return _avatar!.isEmpty ? Assets.iconsLogo : _avatar ?? '';
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      name: json["name"] ?? "",
      mapAddress: json["map_address"] ?? "",
      country: json["country"] ?? "",
      city: json["city"] ?? "",
      home: json["home_address"] ?? "",
      id: json["id"] ?? 0,
      emailOrPhone: json["email_or_phone"] ?? "",
      token: json["token"] ?? "",
    ).._avatar = json["avatar"] ?? '';
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "map_address": mapAddress,
        "country": country,
        "city": city,
        "home_address": home,
        "id": id,
        "email_or_phone": emailOrPhone,
        "token": token,
        "avatar": _avatar,
      };
}

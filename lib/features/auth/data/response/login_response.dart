import 'package:sadaf/generated/assets.dart';

class LoginResponse {
  LoginResponse({
    required this.data,
  });

  final LoginData data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    json["data"]['token'] = json["token"];
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
    required this.emailOrPhone,
    required this.mapAddress,
    required this.governor,
    required this.address,
    required this.receiverPhone,
    required this.avatar,
    required this.token,
  });

  String name;
  String emailOrPhone;
  dynamic mapAddress;
  dynamic governor;
  String address;
  String receiverPhone;
  String avatar;
  String token;

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      name: json["name"] ?? "",
      emailOrPhone: json["email_or_phone"] ?? "",
      mapAddress: json["map_address"] ?? "",
      governor: json["governor"] ?? "",
      address: json["address"] ?? "",
      receiverPhone: json["receiver_phone"] ?? "",
      avatar: json["avatar"] ?? "",
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": emailOrPhone,
        "map_address": mapAddress,
        "governor": governor,
        "address": address,
        "receiver_phone": receiverPhone,
        "avatar": avatar,
        "token": token,
      };
}

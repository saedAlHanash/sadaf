import '../../../profile/data/response/profile_response.dart';

class LoginResponse {
  LoginResponse({
    required this.data,
    required this.token,
  });

  final Profile data;
  final String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: Profile.fromJson(json["data"] ?? {}),
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "token": token,
      };
}

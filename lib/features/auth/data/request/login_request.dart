import 'package:sadaf/main.dart';

class LoginRequest {
  String phone;
  String password;
  bool rememberMe;

  String? fcm;

  LoginRequest({
    this.phone = '',
    this.password = '',
    this.rememberMe = true,
  }) {
    getFireToken().then((value) => fcm = value);
  }

  LoginRequest copyWith({
    String? phone,
    String? password,
    bool? rememberMe,
  }) {
    return LoginRequest(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'fcm_token': fcm,
      'rememberMe': rememberMe,
    };
  }
}

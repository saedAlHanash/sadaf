import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/main.dart';

class LoginRequest {
  String phone;
  String password;

  String? fcm;

  LoginRequest({
    this.phone = '',
    this.password = '',
  }) {
    getFireToken().then((value) => fcm = value);
  }

  LoginRequest copyWith({
    String? phone,
    String? password,
  }) {
    return LoginRequest(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'fcm_token': fcm,
    };
  }
}

import 'dart:convert';

import 'package:http/http.dart';

import '../util/shared_preferences.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:
        AppSharedPreference.logout();
        return ' المستخدم الحالي لم يسجل الدخول ' '${response.statusCode}';

      case 503:
        return 'حدث تغيير في المخدم رمز الخطأ 503 ' '${response.statusCode}';
      case 481:
        return 'لا يوجد اتصال بالانترنت' '${response.statusCode}';

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(jsonDecode(response.body));

        return errorBody.message;
    }
  }
}

class ErrorBody {
  ErrorBody({
    required this.result,
    required this.message,
    required this.data,
  });

  final bool result;
  final String message;
  final Data? data;

  factory ErrorBody.fromJson(Map<String, dynamic> json){
    return ErrorBody(
      result: json["result"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };

}

class Data {
  Data({
    required this.phone,
  });

  final List<String> phone;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      phone: json["phone"] == null ? [] : List<String>.from(json["phone"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "phone": phone.map((x) => x).toList(),
  };

}

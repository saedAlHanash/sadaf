import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sadaf/core/api_manager/api_service.dart';

import '../../generated/l10n.dart';
import '../app/app_widget.dart';
import '../injection/injection_container.dart';
import '../util/abstract_cubit_state.dart';
import '../util/shared_preferences.dart';
import '../util/snack_bar_message.dart';

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
      case 482:
        final ctx = sl<GlobalKey<NavigatorState>>().currentContext;

        return ctx == null ? S().noInternet : S.of(ctx).noInternet;

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(jsonDecode(response.body));

        return '${errorBody.errors.join('\n')}\n ${response.statusCode}';
    }
  }
}

class ErrorBody {
  ErrorBody({
    required this.errors,
  });

  final List<String> errors;

  factory ErrorBody.fromJson(Map<String, dynamic> json) {
    return ErrorBody(
      errors:
          json["errors"] == null ? [] : List<String>.from(json["errors"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "errors": errors.map((x) => x).toList(),
      };
}

showErrorFromApi(AbstractCubit state) {
  if (ctx == null) return;

  NoteMessage.showAwesomeError(context: ctx!, message: state.error);
}

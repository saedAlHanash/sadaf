import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:sadaf/features/auth/data/request/login_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../data/response/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginInitial> {
  LoginCubit() : super(LoginInitial.initial());

  Future<void> login() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _loginApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginData?, String?>> _loginApi() async {
    final response = await APIService().postApi(
      url: PostUrl.loginUrl,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      final pair = Pair(LoginResponse.fromJson(response.jsonBody).data, null);

      AppSharedPreference.cashToken(pair.first.token);
      // AppSharedPreference.cashMyId(pair.first.id);
      AppSharedPreference.cashUser(pair.first);
      AppSharedPreference.removePhoneOrEmail();
      APIService.reInitial();
      return pair;
    } else {
      final error = response.getPairError as Pair<LoginData?, String?>;
      if (error.second?.contains('not verified') ?? false) {
        AppSharedPreference.cashPhoneOrEmail(state.request.phoneOrEmail);
        if (ctx != null) {
          Navigator.pushNamedAndRemoveUntil(
              ctx!, RouteName.confirmCode, (route) => false);
        }
      }
      return error;
    }
  }

  set setPhoneOrEmail(String? phoneOrEmail) => state.request.phoneOrEmail = phoneOrEmail;

  set setPassword(String? password) => state.request.password = password;

  String? get validatePhoneOrEmail {
    if (state.request.phoneOrEmail.isBlank) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password.isBlank) {
      return '${S().password} ${S().is_required}';
    }
    return null;
  }
}

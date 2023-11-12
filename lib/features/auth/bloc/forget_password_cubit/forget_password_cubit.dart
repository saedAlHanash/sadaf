import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstract_cubit_state.dart';
import '../../../../core/util/cheker_helper.dart';
import '../../../../core/util/pair_class.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordInitial> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial.initial());

  Future<void> forgetPassword() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _forgetPasswordApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      AppSharedPreference.cashPhoneOrEmailPassword(state.getEmailOrPhone);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<String?, String?>> _forgetPasswordApi() async {
    final response = await APIService().postApi(
        url: PostUrl.forgetPassword, body: {'email_or_phone': state.getEmailOrPhone});

    if (response.statusCode.success) {
      return Pair(response.jsonBody['data']['otp_code'].toString(), null);
    } else {
      return response.getPairError<String>();
    }
  }
}

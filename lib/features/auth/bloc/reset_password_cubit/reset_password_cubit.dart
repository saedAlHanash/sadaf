import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstract_cubit_state.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/reset_password_request.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordInitial> {
  ResetPasswordCubit() : super(ResetPasswordInitial.initial());

  Future<void> resetPassword() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _resetPasswordApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      AppSharedPreference.removePhoneOrEmail();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _resetPasswordApi() async {
    final response = await APIService().postApi(
      url: PostUrl.resetPassword,
      body: state.request.toJson(),
    );
    if (response.statusCode == 200) {
      final pair = Pair(true, null);
      return pair;
    } else {
      return response.getPairError<bool>();
    }
  }

  set setConfirmPassword(String? phoneOrEmail) =>
      state.request.passwordConfirmation = phoneOrEmail;

  set setPassword(String? password) => state.request.password = password;

  String? get validateConfirmPassword {
    if (state.request.passwordConfirmation.isBlank) {
      return S().passwordEmpty;
    }
    if (state.request.passwordConfirmation != state.request.password) {
      return S().passwordNotMatch;
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

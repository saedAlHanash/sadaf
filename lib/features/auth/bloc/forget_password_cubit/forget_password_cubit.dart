import 'package:sadaf/core/api_manager/api_url.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/util/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordInitial> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> forgetPassword(BuildContext context,
      {required String phone}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _forgetPasswordApi(email: phone);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
        emit(state.copyWith(statuses: CubitStatuses.error));
      }
        emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashEmail(email: phone);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _forgetPasswordApi(
      {required String email}) async {
    if (await network.isConnected) {
      final response = await APIService()
          .postApi(url: PostUrl.forgetPassword, body: {'email': email});

      if (response.statusCode.success) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}

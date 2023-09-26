import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/login_response.dart';

part 'confirm_code_state.dart';

class ConfirmCodeCubit extends Cubit<ConfirmCodeInitial> {
  ConfirmCodeCubit() : super(ConfirmCodeInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> confirmCode(BuildContext context,
      {required String phone, required code}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _confirmCodeApi(phone: phone, code: code);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashToken(pair.first!.token);
      AppSharedPreference.cashMyId(pair.first!.id);
      AppSharedPreference.cashUser(pair.first!);
      AppSharedPreference.removePhoneNumber();

      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<ConfirmCodeData?, String?>> _confirmCodeApi(
      {required String phone, required code}) async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: PostUrl.confirmCode,
        body: {'phone': phone, 'code': code},
      );

      if (response.statusCode == 200) {
        return Pair(ConfirmCodeResponse.fromJson(jsonDecode(response.body)).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}

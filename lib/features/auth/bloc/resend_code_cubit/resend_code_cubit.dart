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
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';

part 'resend_code_state.dart';

class ResendCodeCubit extends Cubit<ResendCodeInitial> {
  ResendCodeCubit() : super(ResendCodeInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> resendCode(BuildContext context, {required String phone}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _resendCodeApi(phone: phone);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
       emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _resendCodeApi({required String phone}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.resendCode,
        query: {'phone': phone},
      );

      if (response.statusCode == 200) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}

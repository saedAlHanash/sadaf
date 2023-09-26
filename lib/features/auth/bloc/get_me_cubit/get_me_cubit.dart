import 'dart:convert';

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
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/login_response.dart';

part 'get_me_state.dart';

class GetMeCubit extends Cubit<GetMeInitial> {
  GetMeCubit() : super(GetMeInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> getMe(BuildContext context,) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getMeApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
        emit(state.copyWith(statuses: CubitStatuses.error));
      }
       emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {

      // AppSharedPreference.cashConfirmCodeData(pair.first!);
      APIService.reInitial();

      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<ConfirmCodeData?, String?>> _getMeApi() async {
    if (await network.isConnected) {
      final response = await APIService()
          .getApi(url: GetUrl.getMe);

      if (response.statusCode.success) {
        return Pair(ConfirmCodeResponse.fromJson(jsonDecode(response.body)).data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, S().noInternet);
    }
  }
}

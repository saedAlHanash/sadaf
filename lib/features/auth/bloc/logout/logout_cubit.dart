import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/enum_manager.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/util/pair_class.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutInitial> {
  LogoutCubit() : super(LogoutInitial.initial());
  

  Future<void> logout(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _logoutApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _logoutApi() async {
    final response = await APIService().postApi(
      url: PostUrl.logout,
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
        return response.getPairError;
    }
  }
}
